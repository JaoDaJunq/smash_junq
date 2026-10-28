class_name AnzolPesca
extends Node2D
## Anzol do Papo-Amarelo (linha de pesca). Sai da vara na direção escolhida, voa até
## HOOK_RANGE e volta. Dois usos (mode):
##  - FISGA (especial neutro): se pega o adversário, puxa ele até a boca do jacaré
##    (o jacaré dá uma mordida curta ao chegar).
##  - BORDA (especial cima): se pega uma borda do palco, puxa o jacaré até ela e ele
##    se pendura (é a volta ao palco dele).
## A linha é desenhada daqui: da ponta da vara até o anzol.

enum Mode { FISGA, BORDA }
enum Phase { OUT, REEL, PULL, BACK }

const SPEED := 1500.0
const BACK_SPEED := 2000.0
const REEL_SPEED := 1300.0
const PULL_SPEED := 1700.0
const HOOK_RADIUS := 22.0
const LEDGE_CATCH := 46.0
const ROD_TIP := Vector2(46.0, -44.0)   # ponta da vara (olhando para a direita)
const SHEET := "res://assets/characters/jacare/pixel/anzol.png"

var owner_fighter: PapoAmarelo
var mode := Mode.FISGA
var phase := Phase.OUT
var dir := Vector2.RIGHT
var max_range := 430.0
var hooked_foe: Fighter = null
var hooked_ledge: Node2D = null
## Anda com o relógio do jogo (bolha de moleza etc. não se aplicam: é só a linha).
var _flown := 0.0
var _age := 0.0
var _reel_time := 0.0
var _frames: Array[Rect2] = []
var _tex: Texture2D


static func spawn(owner_f: PapoAmarelo, hook_mode: Mode, direction: Vector2, reach: float) -> AnzolPesca:
	var h := AnzolPesca.new()
	h.owner_fighter = owner_f
	h.mode = hook_mode
	h.dir = direction.normalized()
	h.max_range = reach
	h.z_index = 4
	h.add_to_group("anzois")
	h.add_to_group("match_cleanup")
	owner_f.get_parent().add_child(h)
	h.global_position = h.rod_tip()
	return h


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


func rod_tip() -> Vector2:
	var o := owner_fighter
	return o.global_position + Vector2(ROD_TIP.x * o.facing, ROD_TIP.y)


func _physics_process(delta: float) -> void:
	_age += delta
	var o := owner_fighter
	if o == null or not is_instance_valid(o) or o.state == Fighter.State.RESPAWN:
		queue_free()
		return
	if phase != Phase.BACK and o.state != Fighter.State.ATTACK:
		phase = Phase.BACK   # o jacaré levou golpe ou o golpe acabou: recolhe
		hooked_foe = null
		hooked_ledge = null
	match phase:
		Phase.OUT:
			_step_out(delta)
		Phase.REEL:
			_step_reel(delta)
		Phase.PULL:
			_step_pull(delta)
		Phase.BACK:
			var to := rod_tip() - global_position
			if to.length() <= BACK_SPEED * delta + 8.0:
				queue_free()
				return
			global_position += to.normalized() * BACK_SPEED * delta
	queue_redraw()


func _step_out(delta: float) -> void:
	var from := global_position
	var step := SPEED * delta
	var to := from + dir * step
	# terreno: o anzol bate e volta (não atravessa o palco)
	var q := PhysicsRayQueryParameters2D.create(from, to, Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	if mode == Mode.BORDA:
		var ledge := _ledge_on_path(from, to)
		if ledge != null:
			hooked_ledge = ledge
			global_position = ledge.global_position
			phase = Phase.PULL
			owner_fighter.hook_caught_ledge(self)
			return
	for i in 3:
		var p := from.lerp(to, float(i + 1) / 3.0)
		for n in get_tree().get_nodes_in_group("fighters"):
			var f := n as Fighter
			if f == null or f == owner_fighter or not f.can_be_hit():
				continue
			if Combat.circle_hits_rect(p, HOOK_RADIUS, f.hurtbox()):
				global_position = p
				_hit_foe(f)
				return
	if not hit.is_empty():
		global_position = hit["position"]
		phase = Phase.BACK
		return
	global_position = to
	_flown += step
	if _flown >= max_range:
		phase = Phase.BACK


## Borda livre perto do caminho do anzol (do lado de fora do palco, como a mão).
func _ledge_on_path(from: Vector2, to: Vector2) -> Node2D:
	var best: Node2D = null
	var bd := LEDGE_CATCH
	for ledge in get_tree().get_nodes_in_group("ledges"):
		var l := ledge as Node2D
		var side: int = l.get_meta("side", 1)
		if owner_fighter._ledge_taken(l):
			continue
		if (owner_fighter.global_position.x - l.global_position.x) * side < -Fighter.RADIUS * 0.5:
			continue   # o jacaré está do lado de dentro dela
		var closest := Geometry2D.get_closest_point_to_segment(l.global_position, from, to)
		var d := closest.distance_to(l.global_position)
		if d < bd:
			bd = d
			best = l
	return best


func _hit_foe(f: Fighter) -> void:
	var o := owner_fighter
	var sign_x := 1 if f.global_position.x >= o.global_position.x else -1
	if mode == Mode.BORDA:
		f.receive_hit(o, o.hook_up_data(), sign_x)
		phase = Phase.BACK
		return
	if f.receive_hit(o, o.hook_data(), sign_x):
		hooked_foe = f
		phase = Phase.REEL
		_reel_time = 0.0
		o.hook_caught_foe(self, f)
	else:
		phase = Phase.BACK   # escudo: o anzol quica e volta


func _step_reel(delta: float) -> void:
	var o := owner_fighter
	var f := hooked_foe
	_reel_time += delta
	# quem se soltou (esquiva), saiu da luta ou foi parar noutro estado: larga
	if f == null or not is_instance_valid(f) or f.state != Fighter.State.HITSTUN or _reel_time > 0.6 \
			or o.state != Fighter.State.ATTACK:
		phase = Phase.BACK
		hooked_foe = null
		return
	var mouth := o.global_position + Vector2(o.facing * (Fighter.RADIUS * 2.0 + 8.0), 0.0)
	f.global_position = f.global_position.move_toward(mouth, REEL_SPEED * delta)
	f.velocity = Vector2.ZERO
	f._launch = Vector2.ZERO
	f._fall = 0.0
	f._hitstun = maxf(f._hitstun, 0.12)
	f._hitstun_total = maxf(f._hitstun_total, 0.12)
	global_position = f.global_position + Vector2(0, -30)
	if f.global_position.distance_to(mouth) <= 6.0:
		hooked_foe = null
		phase = Phase.BACK
		o.hook_bite(f)


func _step_pull(delta: float) -> void:
	var o := owner_fighter
	var l := hooked_ledge
	if l == null or not is_instance_valid(l) or o.state != Fighter.State.ATTACK or o._ledge_taken(l):
		phase = Phase.BACK
		hooked_ledge = null
		return
	var side: int = l.get_meta("side", 1)
	var hang := l.global_position + Vector2(side * (Fighter.RADIUS + 2.0), Fighter.HEIGHT * 0.4)
	o.velocity = Vector2.ZERO
	o.global_position = o.global_position.move_toward(hang, PULL_SPEED * delta)
	if o.global_position.distance_to(hang) <= 4.0:
		queue_free()
		o.hook_arrived(l)


func _draw() -> void:
	var o := owner_fighter
	if o == null or not is_instance_valid(o):
		return
	var a := to_local(rod_tip())
	var b := Vector2.ZERO
	# linha com uma barriguinha para baixo que some quando estica
	var pts := PackedVector2Array()
	var sag := 10.0 if phase == Phase.OUT or phase == Phase.BACK else 3.0
	var n := 10
	for i in n + 1:
		var t := float(i) / n
		pts.append(a.lerp(b, t) + Vector2(0, sin(t * PI) * sag))
	draw_polyline(pts, Color("2a0f12"), 4.0)
	draw_polyline(pts, Color("f0e6c8"), 2.0)
	if _frames.is_empty() or _tex == null:
		draw_circle(b, 8.0, Color("c8ccd0"))
		return
	var src: Rect2 = _frames[int(_age * 10.0) % _frames.size()]
	var sc := 1.4
	var size := src.size * sc
	# o anzol "olha" para onde voa: a ponta do desenho (para baixo) segue a direção
	var ang := dir.angle() - PI * 0.5
	if phase == Phase.BACK:
		ang = (global_position - rod_tip()).angle() + PI * 0.5
	draw_set_transform(Vector2.ZERO, ang, Vector2.ONE)
	draw_texture_rect_region(_tex, Rect2(-size * 0.5, size), src)
	draw_set_transform(Vector2.ZERO)
