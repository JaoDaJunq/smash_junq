class_name Estandarte
extends Node2D
## Estandarte da escola de samba fincado pela Dona Canga (especial para o lado).
## Perto dele, todo golpe dela conta como "na batida" da bateria. Fica até
## LIFETIME segundos ou até levar HITS golpes do adversário. Só existe um por Canga.

const LIFETIME := 12.0
const HITS := 2
const RADIUS := 230.0           # alcance do "ritmo da quadra"
const SPRITE_PATH := "res://assets/characters/arara_canga/pixel/estandarte.png"

var owner_fighter: Fighter
var _age := 0.0
var _hp := HITS
var _hit_cooldown := 0.0
var _tex: Texture2D
var _frames := 1
var _fall := -1.0   # >= 0: caindo


static func plant(by: Fighter, at: Vector2) -> Estandarte:
	var e := Estandarte.new()
	e.owner_fighter = by
	e.z_index = -1
	e.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	e.add_to_group("match_cleanup")
	e.add_to_group("estandartes")
	by.get_parent().add_child(e)
	e.global_position = at
	return e


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)
		_frames = maxi(1, _tex.get_width() / 64)


func covers(p: Vector2) -> bool:
	return _fall < 0.0 and p.distance_to(global_position) <= RADIUS


func _physics_process(delta: float) -> void:
	_age += delta
	_hit_cooldown = maxf(_hit_cooldown - delta, 0.0)
	if _fall >= 0.0:
		_fall += delta
		if _fall > 0.5:
			queue_free()
		queue_redraw()
		return
	if _age >= LIFETIME or owner_fighter == null or not is_instance_valid(owner_fighter):
		knock_down()
		return
	# O adversário derruba a bandeira batendo nela.
	var box := Rect2(global_position + Vector2(-14, -100), Vector2(28, 100))
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == owner_fighter or foe.attack == null or not foe.attack.is_active(foe.attack_frame):
			continue
		if _hit_cooldown <= 0.0 and Combat.circle_hits_rect(foe.hitbox_center(foe.attack), foe.attack.hitbox_radius, box):
			_hp -= 1
			_hit_cooldown = 0.3
			if _hp <= 0:
				knock_down()
				return
	queue_redraw()


func knock_down() -> void:
	if _fall < 0.0:
		_fall = 0.0


func _draw() -> void:
	var rot := 0.0
	if _fall >= 0.0:
		rot = minf(_fall / 0.4, 1.0) * PI * 0.5
		modulate.a = 1.0 - clampf((_fall - 0.3) / 0.2, 0.0, 1.0)
	draw_set_transform(Vector2.ZERO, rot, Vector2(2, 2))
	if _tex != null:
		var i := int(_age * 5.0) % _frames
		var src := Rect2(i * 64, 0, 64, 64)
		draw_texture_rect_region(_tex, Rect2(-32, -60, 64, 64), src)
	else:
		draw_line(Vector2(0, 0), Vector2(0, -48), Color(0.9, 0.75, 0.3), 2.0)
		draw_rect(Rect2(1, -46, 20, 13), Color(0.18, 0.43, 0.77))
	draw_set_transform(Vector2.ZERO)
