class_name CamaElastica
extends Node2D
## Mini cama elástica deixada pela Marianinha (especial para cima). Fica LIFETIME s
## no palco; QUALQUER lutador que cair em cima é lançado bem alto (dá para usar
## contra o adversário). Só existe uma por Marianinha.

const LIFETIME := 6.0
const WIDTH := 100.0
const BOUNCE := 1350.0
const SPRITE_PATH := "res://assets/characters/marianinha/pixel/cama_elastica.png"

var owner_fighter: Fighter
var _age := 0.0
var _squash := 0.0
var _tex: Texture2D
var _cool := {}


static func place(by: Fighter, at: Vector2) -> CamaElastica:
	var c := CamaElastica.new()
	c.owner_fighter = by
	c.z_index = -1
	c.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	c.add_to_group("match_cleanup")
	c.add_to_group("camas_elasticas")
	by.get_parent().add_child(c)
	c.global_position = at
	return c


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)


func _physics_process(delta: float) -> void:
	_age += delta
	_squash = maxf(_squash - delta * 4.0, 0.0)
	if _age >= LIFETIME:
		queue_free()
		return
	for k in _cool.keys():
		_cool[k] -= delta
	for f in get_tree().get_nodes_in_group("fighters"):
		var who := f as Fighter
		if who.velocity.y < 0.0 or _cool.get(who, 0.0) > 0.0:
			continue
		var feet := who.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
		if absf(feet.x - global_position.x) <= WIDTH * 0.5 and feet.y >= global_position.y - 26.0 and feet.y <= global_position.y + 6.0:
			who.velocity.y = -BOUNCE
			who.state = Fighter.State.AIR
			who.helpless = false
			who.jumps_left = who.air_jumps
			who.global_position.y = global_position.y - Fighter.HEIGHT * 0.5 - 8.0
			who.jumped.emit(true)
			_cool[who] = 0.3
			_squash = 1.0
	queue_redraw()


func _draw() -> void:
	if _tex != null:
		var n := maxi(1, _tex.get_width() / 64)
		var i := 0 if _squash <= 0.0 else (1 if _squash > 0.5 else 2)
		i = mini(i, n - 1)
		draw_set_transform(Vector2.ZERO, 0.0, Vector2(2, 2))
		draw_texture_rect_region(_tex, Rect2(-32, -60, 64, 64), Rect2(i * 64, 0, 64, 64))
		draw_set_transform(Vector2.ZERO)
	else:
		draw_rect(Rect2(-WIDTH * 0.5, -14 + _squash * 6.0, WIDTH, 6), Color(0.1, 0.1, 0.12))
		draw_rect(Rect2(-WIDTH * 0.5, -10, 6, 10), Color(0.6, 0.6, 0.65))
		draw_rect(Rect2(WIDTH * 0.5 - 6, -10, 6, 10), Color(0.6, 0.6, 0.65))
	# Some piscando no último segundo
	if _age > LIFETIME - 1.0:
		modulate.a = 0.5 + 0.5 * cos(_age * 20.0)
