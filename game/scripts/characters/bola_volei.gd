class_name BolaVolei
extends Node2D
## Bola de vôlei do Mourisco (design/personagens/mourisco.md). Depois do saque ela
## fica no palco quicando; QUALQUER lutador pode bater nela com um golpe (a área de
## acerto do golpe encosta na bola). Quem bateu por último é o "dono": se a bola
## está rápida ("viva"), ela machuca quem NÃO é o dono. Só existe uma por Mourisco.
## O Mourisco decide como cada golpe dele rebate (ver Mourisco.ball_hit); os golpes
## dos outros usam o ângulo e a força do próprio golpe.

const RADIUS := 22.0
const GRAVITY := 1500.0
const BOUNCE := 0.72
const LIVE_SPEED := 450.0          # abaixo disso a bola não machuca mais
const MAX_SPEED := 1500.0
const IDLE_LIFETIME := 14.0        # sem ninguém bater, some depois disto
const SPRITE_PATH := "res://assets/characters/mourisco/pixel/bola_volei.png"
const MASK := Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM
const NO_HURT := [Fighter.State.HELD, Fighter.State.HOLDING, Fighter.State.LEDGE, Fighter.State.RESPAWN]

var owner_fighter: Fighter
var velocity := Vector2.ZERO
var live := false
var _grounded := false
var _idle := 0.0
var _age := 0.0
var _cool := {}                    # lutador -> segundos até poder bater/ser batido de novo
var _tex: Texture2D
var _frames := 2


## Cria a bola no mundo (filho do pai do dono) com a velocidade inicial dada.
static func spawn(by: Fighter, at: Vector2, vel: Vector2) -> BolaVolei:
	var b := BolaVolei.new()
	b.owner_fighter = by
	b.velocity = vel
	b.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	b.z_index = 3
	b.add_to_group("bolas_volei")
	b.add_to_group("match_cleanup")
	by.get_parent().add_child(b)
	b.global_position = at
	return b


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)
		_frames = Projectile.strip_frames(_tex)


func is_grounded() -> bool:
	return _grounded


func speed() -> float:
	return velocity.length()


## Bate na bola: nova velocidade, novo dono, "viva" se o golpe é forte.
func knock(by: Fighter, vel: Vector2, make_live: bool) -> void:
	velocity = vel.limit_length(MAX_SPEED)
	owner_fighter = by
	live = make_live and velocity.length() >= LIVE_SPEED
	_grounded = false
	_idle = 0.0
	_cool[by] = 0.35
	# hit_taken do alvo não existe aqui; o efeito de pancada fica por conta de quem chama.


func _physics_process(delta: float) -> void:
	_age += delta
	_idle += delta
	for k in _cool.keys():
		_cool[k] -= delta
		if _cool[k] <= 0.0:
			_cool.erase(k)
	if _idle >= IDLE_LIFETIME or absf(global_position.x) > 2400.0 or global_position.y > 1600.0 or global_position.y < -2200.0:
		queue_free()
		return
	_move(delta)
	_check_swings()
	if live:
		if velocity.length() < LIVE_SPEED:
			live = false
		else:
			_check_hurt()
	queue_redraw()


func _move(delta: float) -> void:
	var space := get_world_2d().direct_space_state
	if _grounded:
		# rolando devagar no chão; cai se o chão acabou
		var below := space.intersect_ray(PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, RADIUS + 6.0), MASK))
		if below.is_empty():
			_grounded = false
		else:
			velocity.x = move_toward(velocity.x, 0.0, 380.0 * delta)
			velocity.y = 0.0
			global_position.y = (below["position"] as Vector2).y - RADIUS
			_step_x(space, delta)
			return
	velocity.y += GRAVITY * delta
	var to := global_position + velocity * delta
	if velocity.y > 0.0:
		var q := PhysicsRayQueryParameters2D.create(global_position, to + Vector2(0, RADIUS), MASK)
		var hit := space.intersect_ray(q)
		if not hit.is_empty():
			global_position = Vector2(to.x, (hit["position"] as Vector2).y - RADIUS)
			if velocity.y < 180.0:
				velocity.y = 0.0
				_grounded = true
			else:
				velocity.y = -velocity.y * BOUNCE
				velocity.x *= 0.9
				live = live and velocity.length() >= LIVE_SPEED
			return
	global_position.y = to.y
	_step_x(space, delta)


## Anda no eixo x; parede de palco alta rebate.
func _step_x(space: PhysicsDirectSpaceState2D, delta: float) -> void:
	var dx := velocity.x * delta
	if absf(dx) < 0.01:
		return
	var q := PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(dx + signf(dx) * RADIUS, 0), Fighter.LAYER_STAGE)
	var hit := space.intersect_ray(q)
	if not hit.is_empty():
		velocity.x = -velocity.x * 0.6
		return
	global_position.x += dx


## Algum golpe ativo (de qualquer lutador) encosta na bola?
func _check_swings() -> void:
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f.state != Fighter.State.ATTACK or f.attack == null or not f.attack.is_active(f.attack_frame):
			continue
		if _cool.has(f):
			continue
		var c := f.hitbox_center(f.attack)
		if c.distance_to(global_position) > f.attack.hitbox_radius + RADIUS:
			continue
		var res := {}
		if f.has_method("ball_hit"):
			res = f.ball_hit(self, f.attack_id, f.attack)
		if res.get("skip", false):
			continue
		if res.is_empty():
			res = default_hit(f, f.attack)
		knock(f, res["v"], res.get("live", true))
		f._hitstop = maxi(f._hitstop, 3)
		if f.move_fx != null:
			f.move_fx.play_at("fx_poof", global_position, 1.5, 0.3, "poof")


## Velocidade de um golpe qualquer na bola: segue o ângulo e a força do golpe.
static func default_hit(f: Fighter, a: AttackData) -> Dictionary:
	var spd := clampf(260.0 + a.damage * 65.0 + a.base_knockback * 0.45, 520.0, 1400.0)
	var rad := deg_to_rad(a.angle)
	return {"v": Vector2(cos(rad) * f.facing, -sin(rad)) * spd, "live": a.damage >= 4.0}


## Bola viva machuca quem não é o dono (e não está intocável).
func _check_hurt() -> void:
	for n in get_tree().get_nodes_in_group("fighters"):
		var t := n as Fighter
		if t == null or t == owner_fighter or _cool.has(t) or not t.can_be_hit() or t.state in NO_HURT:
			continue
		if not Combat.circle_hits_rect(global_position, RADIUS, t.hurtbox()):
			continue
		var spd := velocity.length()
		var d := AttackData.new()
		d.id = "bola_volei"
		d.damage = clampf(1.5 + spd * 0.0055, 3.0, 9.0)
		d.angle = clampf(rad_to_deg(atan2(-velocity.y, absf(velocity.x))), -50.0, 70.0)
		d.base_knockback = 220.0 + spd * 0.1
		d.knockback_growth = 5.5
		d.hitbox_radius = RADIUS
		var dir := 1 if velocity.x >= 0.0 else -1
		_cool[t] = 0.5
		if t.receive_hit(owner_fighter, d, dir):
			if owner_fighter != null and is_instance_valid(owner_fighter) and owner_fighter.move_fx != null:
				owner_fighter.move_fx.play("fx_poof", "target", t, 2.0, false, 0.3, "poof")
			velocity = Vector2(-float(dir) * 160.0, -420.0)   # quica no adversário
			live = false
			_grounded = false
		return


func _draw() -> void:
	var fade := 1.0 if _idle < IDLE_LIFETIME - 1.5 else 0.5 + 0.5 * cos(_age * 18.0)
	var spin_fps := clampf(speed() / 60.0, 2.0, 18.0)
	if _tex != null:
		var i := int(_age * spin_fps) % _frames
		var s := 1.0
		var w := float(_tex.get_width()) / float(_frames)
		draw_texture_rect_region(_tex, Rect2(-w * 0.5 * s, -_tex.get_height() * 0.5 * s, w * s, _tex.get_height() * s),
			Rect2(i * w, 0, w, _tex.get_height()), Color(1, 1, 1, fade))
	else:
		draw_circle(Vector2.ZERO, RADIUS * 0.7, Color(1, 0.95, 0.7, fade))
		draw_arc(Vector2.ZERO, RADIUS * 0.7, 0.0, TAU, 20, Color("2a0f12"), 2.0)
	if live:
		draw_arc(Vector2.ZERO, RADIUS + 3.0, 0.0, TAU, 24, Color(1.0, 0.85, 0.3, 0.7 * fade), 3.0)
