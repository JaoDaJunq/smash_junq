class_name NuvemVeneno
extends Node2D
## Nuvem de veneno do Bandeira (especial neutro): fica TIME s no lugar. Quem está
## dentro (menos o dono, que usa máscara) tosse: não consegue segurar o escudo e
## toma DAMAGE % a cada TICK s. Só existe uma nuvem por Bandeira.

const RADIUS := 46.0   # era 78: a nuvem ficava grande demais (João, 28/10)
const TIME := 3.0
const TICK := 0.5
const DAMAGE := 1.0
const SPRITE_PATH := "res://assets/characters/tamandua/pixel/fx_nuvem_veneno.png"
const SPRITE_SCALE := 1.5

var owner_fighter: Fighter
var _t := 0.0
var _tick := 0.0
var _tex: Texture2D
var _frames := 4


static func spawn(owner_f: Fighter, at: Vector2) -> NuvemVeneno:
	var n := NuvemVeneno.new()
	n.owner_fighter = owner_f
	n.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	n.z_index = 4
	n.add_to_group("nuvens_veneno")
	n.add_to_group("match_cleanup")
	owner_f.get_parent().add_child(n)
	n.global_position = at
	return n


func _ready() -> void:
	# Depois de todos os lutadores (e antes do Hits, prioridade 100): o escudo que
	# eles levantaram neste quadro é derrubado antes de qualquer golpe ser resolvido.
	process_physics_priority = 50
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)
		_frames = Projectile.strip_frames(_tex)


func inside(f: Fighter) -> bool:
	return Combat.circle_hits_rect(global_position, RADIUS, f.hurtbox())


func _physics_process(delta: float) -> void:
	_t += delta
	if _t >= TIME:
		queue_free()
		return
	_tick += delta
	var pulse := _tick >= TICK
	if pulse:
		_tick -= TICK
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == owner_fighter or not inside(f):
			continue
		if f.state == Fighter.State.SHIELD:
			f.state = Fighter.State.IDLE   # tosse: o escudo cai
		if pulse and f.invincible_time <= 0.0 and f.state != Fighter.State.RESPAWN:
			f.add_damage(DAMAGE)
			if owner_fighter != null and is_instance_valid(owner_fighter) and owner_fighter.move_fx != null:
				owner_fighter.move_fx.play("fx_tosse", "target_head", f, 2.0, true, 0.4, "estrelas")
	queue_redraw()


func _draw() -> void:
	if _tex == null:
		draw_circle(Vector2.ZERO, RADIUS, Color(0.45, 0.8, 0.2, 0.35))
		return
	var i := 0
	if _t < 0.3:
		i = 0
	elif _t > TIME - 0.5:
		i = _frames - 1
	else:
		i = 1 + int(_t / 0.3) % maxi(1, _frames - 2)
	var w := float(_tex.get_width()) / float(_frames)
	var size := Vector2(w, _tex.get_height()) * SPRITE_SCALE
	var fade := clampf((TIME - _t) / 0.5, 0.0, 1.0) * 0.5 + 0.5
	draw_texture_rect_region(_tex, Rect2(-size * 0.5, size), Rect2(i * w, 0, w, _tex.get_height()), Color(1, 1, 1, fade))
