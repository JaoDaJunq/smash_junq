class_name EscadaDobravel
extends Node2D
## Escada dobrável do Preguinho (especial para cima): fica aberta TIME s no lugar.
## QUALQUER lutador dentro dela que segure "cima" sobe pela escada (o adversário também
## pode usar). Só uma por dono. Desenhada com a folha escada.png.

const TIME := 2.0
const HALF_W := 36.0
const HEIGHT_PX := 132.0   # altura da escada na tela
const CLIMB := 430.0
const SHEET := "res://assets/characters/macaco_prego/pixel/escada.png"

var owner_fighter: Fighter
var _t := 0.0
var _tex: Texture2D
var _used := Rect2()       # parte desenhada do 1º quadro (64x64 nativos)


## Abre a escada com a base em `base` (mundo). A anterior do mesmo dono fecha.
static func open(owner_f: Fighter, base: Vector2) -> EscadaDobravel:
	for n in owner_f.get_tree().get_nodes_in_group("escadas"):
		if n.get("owner_fighter") == owner_f:
			n.queue_free()
	var e := EscadaDobravel.new()
	e.owner_fighter = owner_f
	e.z_index = -1
	e.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	e.add_to_group("escadas")
	e.add_to_group("match_cleanup")
	owner_f.get_parent().add_child(e)
	e.global_position = base
	return e


func _ready() -> void:
	if ResourceLoader.exists(SHEET):
		_tex = load(SHEET)
		var img := _tex.get_image()
		_used = Rect2(img.get_region(Rect2i(0, 0, 64, 64)).get_used_rect())


func inside(f: Fighter) -> bool:
	var feet := f.global_position.y + Fighter.HEIGHT * 0.5
	return absf(f.global_position.x - global_position.x) <= HALF_W and feet <= global_position.y + 8.0 and feet >= global_position.y - HEIGHT_PX


func _physics_process(delta: float) -> void:
	_t += delta
	if _t >= TIME:
		queue_free()
		return
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or not inside(f) or not f.controls.pressed("up"):
			continue
		if not f.state in [Fighter.State.IDLE, Fighter.State.WALK, Fighter.State.RUN, Fighter.State.AIR]:
			continue
		if f.is_on_floor():
			f.global_position.y -= 12.0   # desgruda do chão (mais que o floor_snap de 8 px)
		f.state = Fighter.State.AIR
		f.fast_falling = false
		f.velocity.y = -CLIMB
		f.velocity.x *= 0.8
	queue_redraw()


func _draw() -> void:
	var fade := clampf((TIME - _t) / 0.35, 0.0, 1.0)
	if _tex == null or _used.size.y <= 0.0:
		draw_rect(Rect2(-HALF_W, -HEIGHT_PX, HALF_W * 2.0, HEIGHT_PX), Color(0.7, 0.7, 0.75, 0.5 * fade), false, 3.0)
		return
	var s := HEIGHT_PX / _used.size.y
	var frame := int(_t * 6.0) % 2 if _t > TIME - 0.35 else 0   # treme antes de fechar
	var src := Rect2(frame * 64 + _used.position.x, _used.position.y, _used.size.x, _used.size.y)
	var dst := Rect2(-_used.size.x * s * 0.5, -HEIGHT_PX, _used.size.x * s, HEIGHT_PX)
	draw_texture_rect_region(_tex, dst, src, Color(1, 1, 1, fade))
