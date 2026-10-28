class_name PregoChao
extends Node2D
## Prego do Preguinho (especial para baixo): fica espetado no chão até alguém pisar.
## Quem pisa (menos o dono) tropeça: golpe curto para cima. Só um por dono (o anterior some).
## Desenhado com a folha prego.png (quadro 1 = prego, 2 = prego entortado).

const ARM := 0.4
const RADIUS := 34.0
const LIFETIME := 25.0
const SHEET := "res://assets/characters/macaco_prego/pixel/prego.png"

var owner_fighter: Fighter
var data: AttackData
var _age := 0.0
var _bent := -1.0       # depois de pisado: tempo mostrando o prego entortado
var _tex: Texture2D


static func plant(by: Fighter, at: Vector2, attack_data: AttackData) -> PregoChao:
	for n in by.get_tree().get_nodes_in_group("pregos"):
		if n.get("owner_fighter") == by:
			n.queue_free()
	var p := PregoChao.new()
	p.owner_fighter = by
	p.data = attack_data
	p.z_index = -1
	p.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	p.add_to_group("pregos")
	p.add_to_group("match_cleanup")
	by.get_parent().add_child(p)
	p.global_position = at
	return p


func _ready() -> void:
	if ResourceLoader.exists(SHEET):
		_tex = load(SHEET)


func armed() -> bool:
	return _age >= ARM and _bent < 0.0


func _physics_process(delta: float) -> void:
	_age += delta
	queue_redraw()
	if _bent >= 0.0:
		_bent += delta
		if _bent > 0.4:
			queue_free()
		return
	if _age > LIFETIME:
		queue_free()
		return
	if not armed():
		return
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == owner_fighter or not f.can_be_hit() or not f.is_on_floor() or f.state == Fighter.State.HELD:
			continue
		if absf(f.global_position.x - global_position.x) < RADIUS and absf(f.global_position.y + Fighter.HEIGHT * 0.5 - global_position.y) < 24.0:
			f.receive_hit(owner_fighter, data, 1 if f.global_position.x >= global_position.x else -1)
			if owner_fighter != null and is_instance_valid(owner_fighter) and owner_fighter.move_fx != null:
				owner_fighter.move_fx.on_hit_landed(f, "prego_pisado")
			_bent = 0.0
			return


func _draw() -> void:
	if _tex == null:
		draw_rect(Rect2(-3, -22, 6, 24), Color("2a0f12"))
		draw_rect(Rect2(-2, -21, 4, 22), Color("a8a09a"))
		return
	var i := 1 if _bent >= 0.0 else 0
	# a ponta do prego fica na linha ~51 do quadro; 4 px dentro do chão (2x)
	draw_texture_rect_region(_tex, Rect2(-64, 4 - 51 * 2, 128, 128), Rect2(i * 64, 0, 64, 64))
