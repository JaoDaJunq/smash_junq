class_name RedePesca
extends Node2D
## Rede do Papo-Amarelo: sai em arco; quem é pego fica preso NET_TIME segundos
## (parado no ar, sem poder agir) e se solta mais cedo apertando botões (cada
## aperto tira PRESS_CUT s). Quem leva golpe também se solta (o golpe lança).
## A rede some se bate no chão ou no escudo.

enum Phase { FLY, TRAP }

const GRAVITY := 1400.0
const NET_TIME := 1.0
const PRESS_CUT := 0.1
const RADIUS := 44.0
const SHEET := "res://assets/characters/jacare/pixel/rede.png"

var owner_fighter: Fighter
var data: AttackData
var velocity := Vector2.ZERO
var phase := Phase.FLY
var target: Fighter = null
var slow_factor := 1.0
var _age := 0.0
var _frames: Array[Rect2] = []
var _tex: Texture2D


static func spawn(owner_f: Fighter, attack_data: AttackData, at: Vector2, vel: Vector2) -> RedePesca:
	var r := RedePesca.new()
	r.owner_fighter = owner_f
	r.data = attack_data
	r.velocity = vel
	r.z_index = 4
	r.add_to_group("redes")
	r.add_to_group("match_cleanup")
	owner_f.get_parent().add_child(r)
	r.global_position = at
	return r


func _ready() -> void:
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	if ResourceLoader.exists(SHEET):
		_tex = load(SHEET)
		var img := _tex.get_image()
		var n := Projectile.strip_frames(_tex)
		var fw := _tex.get_width() / n
		for i in n:
			var used := img.get_region(Rect2i(i * fw, 0, fw, _tex.get_height())).get_used_rect()
			if used.size != Vector2i.ZERO:
				_frames.append(Rect2(used.position + Vector2i(i * fw, 0), used.size))


func is_trapping() -> bool:
	return phase == Phase.TRAP


func _physics_process(delta: float) -> void:
	delta *= clampf(slow_factor, 0.05, 1.0)
	slow_factor = 1.0
	_age += delta
	if owner_fighter == null or not is_instance_valid(owner_fighter):
		queue_free()
		return
	if phase == Phase.FLY:
		_fly(delta)
	else:
		_trap()
	queue_redraw()


func _fly(delta: float) -> void:
	var from := global_position
	velocity.y += GRAVITY * delta
	var to := from + velocity * delta
	if velocity.y > 0.0:
		var q := PhysicsRayQueryParameters2D.create(from, to + Vector2(0, 8), Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
		if not get_world_2d().direct_space_state.intersect_ray(q).is_empty():
			_poof()
			return
	global_position = to
	if absf(to.x) > 2400.0 or to.y > 1600.0 or _age > 3.0:
		queue_free()
		return
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == owner_fighter or not f.can_be_hit():
			continue
		if Combat.circle_hits_rect(global_position, RADIUS, f.hurtbox()):
			var travel := 1 if velocity.x >= 0.0 else -1
			if f.receive_hit(owner_fighter, data, travel):
				f.hypnotize(NET_TIME)
				if f.state == Fighter.State.HITSTUN:
					target = f
					phase = Phase.TRAP
					_age = 0.0
					return
			_poof()   # escudo ou armadura: a rede cai
			return


func _trap() -> void:
	var f := target
	# solto: o tempo acabou, apertou botões, esquivou, ou levou golpe (lançamento)
	if f == null or not is_instance_valid(f) or f.state != Fighter.State.HITSTUN or f._launch != Vector2.ZERO \
			or f._hitstun <= 0.0:
		queue_free()
		return
	for a in ["attack", "special", "jump", "shield"]:
		if f.controls.just_pressed(a):
			f._hitstun -= PRESS_CUT
	f._fall = 0.0   # fica pendurado na rede (não despenca)
	f.velocity = Vector2.ZERO
	global_position = f.global_position + Vector2(0, -8)


func _poof() -> void:
	var o := owner_fighter
	if o != null and is_instance_valid(o) and o.move_fx != null:
		o.move_fx.play_at("fx_poof", global_position, 2.0, 0.35, "poof")
	queue_free()


func _draw() -> void:
	if _frames.is_empty() or _tex == null:
		draw_circle(Vector2.ZERO, RADIUS, Color(0.8, 0.7, 0.4, 0.6))
		return
	var i := 3
	var sc := 2.0
	if phase == Phase.FLY:
		i = mini(2, int(_age * 14.0))   # bolinha -> abre -> rede aberta
	else:
		sc = 3.2
	var src: Rect2 = _frames[mini(i, _frames.size() - 1)]
	var size := src.size * sc
	var shake := Vector2.ZERO
	if phase == Phase.TRAP:
		shake = Vector2(sin(_age * 60.0) * 2.0, 0.0)   # se debatendo
	var flip := -1.0 if velocity.x < 0.0 and phase == Phase.FLY else 1.0
	draw_set_transform(shake, 0.0, Vector2(flip, 1.0))
	draw_texture_rect_region(_tex, Rect2(-size * 0.5, size), src, Color(1, 1, 1, 0.92))
	draw_set_transform(Vector2.ZERO)
