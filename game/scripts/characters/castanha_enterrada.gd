class_name CastanhaEnterrada
extends Node2D
## Castanha enterrada pela Cutia Ligeira (especial para baixo). Fica no chão como um
## montinho de terra; depois de ARM segundos fica armada, e o primeiro adversário que
## pisar perto faz ela estourar (golpe para cima). A Cutia pode desenterrar a castanha
## (especial para baixo de novo em cima dela) e arremessar. Cada Cutia tem no máximo
## MAX castanhas; a mais velha some quando passa disso.

const ARM := 0.5
const RADIUS := 48.0
const LIFETIME := 14.0
const MAX := 3

var owner_fighter: Fighter
var data: AttackData
var _age := 0.0


static func bury(by: Fighter, at: Vector2, attack_data: AttackData) -> CastanhaEnterrada:
	var mine: Array = []
	for n in by.get_tree().get_nodes_in_group("castanhas_enterradas"):
		if n.owner_fighter == by:
			mine.append(n)
	while mine.size() >= MAX:
		mine.pop_front().queue_free()
	var c := CastanhaEnterrada.new()
	c.owner_fighter = by
	c.data = attack_data
	c.z_index = -1
	c.add_to_group("match_cleanup")
	c.add_to_group("castanhas_enterradas")
	by.get_parent().add_child(c)
	c.global_position = at
	return c


func armed() -> bool:
	return _age >= ARM


func _physics_process(delta: float) -> void:
	_age += delta
	queue_redraw()
	if _age > LIFETIME:
		queue_free()
		return
	if not armed():
		return
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == owner_fighter or not f.can_be_hit() or not f.is_on_floor():
			continue
		if absf(f.global_position.x - global_position.x) < RADIUS and absf(f.global_position.y + Fighter.HEIGHT * 0.5 - global_position.y) < 30.0:
			f.receive_hit(owner_fighter, data, 1 if f.global_position.x >= global_position.x else -1)
			if owner_fighter != null and owner_fighter.move_fx != null:
				owner_fighter.move_fx.on_hit_landed(f, "castanha_estoura")
			queue_free()
			return


func _draw() -> void:
	# Montinho de terra; armado: a pontinha da castanha aparece e pisca de leve.
	var dirt := Color("7a4a22")
	draw_rect(Rect2(-14, -6, 28, 6), Color("2a0f12"))
	draw_rect(Rect2(-12, -5, 24, 5), dirt)
	draw_rect(Rect2(-8, -8, 16, 3), dirt.lightened(0.15))
	if armed():
		var a := 0.75 + 0.25 * sin(_age * 6.0)
		draw_rect(Rect2(-3, -11, 6, 4), Color("7a3a1a", a))
		draw_rect(Rect2(-2, -11, 2, 1), Color("b0602a", a))
