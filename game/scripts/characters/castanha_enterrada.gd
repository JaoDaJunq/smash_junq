class_name CastanhaEnterrada
extends Node2D
## Castanha enterrada pela Cutia Ligeira (especial para baixo, ou saquinho que
## caiu no chão sem acertar). Fica no chão como um montinho de terra; depois de ARM
## segundos fica armada, e o primeiro adversário que pisar perto faz ela estourar
## (golpe para cima, fx_estouro_castanha). A Cutia pode desenterrar a castanha
## (especial para baixo em cima dela) e a carrinhada recolhe. Cada Cutia tem no
## máximo MAX castanhas; a mais velha some quando passa disso.
## Armada, pisca 1 quadro por segundo (a CPU não enxerga armadilha: justo para quem
## joga). O Seu Peba passando por baixo da terra estoura sem dano (defuse).

const ARM := 0.5
const RADIUS := 48.0
const LIFETIME := 14.0
const MAX := 3
const MIN_GAP := 90.0            # entre castanhas e outros objetos de chão
const SPRITE_PATH := "res://assets/characters/cutia/pixel/castanha_enterrada.png"

var owner_fighter: Fighter
var data: AttackData
var _age := 0.0
var _tex: Texture2D
var _fw := 64


## Lugar livre no chão de palco perto de `at` (afasta MIN_GAP de castanhas,
## estandarte, cama elástica e faixa). Vector2.INF se não há chão de palco ali
## (nunca em plataforma fina ou móvel).
static func free_spot(by: Fighter, at: Vector2) -> Vector2:
	var spot := at
	var groups := ["castanhas_enterradas", "estandartes", "camas_elasticas", "faixas"]
	for g in groups:
		for n in by.get_tree().get_nodes_in_group(g):
			var o := n as Node2D
			if o == null or o.is_queued_for_deletion():
				continue
			var gap := MIN_GAP if g == "castanhas_enterradas" else 120.0
			if absf(o.global_position.x - spot.x) < gap and absf(o.global_position.y - spot.y) < 60.0:
				spot.x = o.global_position.x + gap * (1.0 if spot.x >= o.global_position.x else -1.0)
	var q := PhysicsRayQueryParameters2D.create(spot + Vector2(0, -30), spot + Vector2(0, 40), Fighter.LAYER_STAGE)
	var hit := by.get_world_2d().direct_space_state.intersect_ray(q)
	if hit.is_empty():
		return Vector2.INF
	return hit.position


static func bury(by: Fighter, at: Vector2, attack_data: AttackData) -> CastanhaEnterrada:
	var mine: Array = []
	for n in by.get_tree().get_nodes_in_group("castanhas_enterradas"):
		if n.owner_fighter == by and not n.is_queued_for_deletion():
			mine.append(n)
	while mine.size() >= MAX:
		mine.pop_front().queue_free()
	var c := CastanhaEnterrada.new()
	c.owner_fighter = by
	c.data = attack_data
	c.z_index = -1
	c.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	c.add_to_group("match_cleanup")
	c.add_to_group("castanhas_enterradas")
	by.get_parent().add_child(c)
	c.global_position = at
	return c


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)
		_fw = _tex.get_width() / Projectile.strip_frames(_tex)


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
		if f == null or f == owner_fighter or not f.can_be_hit() or not f.is_on_floor() or f.state == Fighter.State.HELD:
			continue
		if absf(f.global_position.x - global_position.x) < RADIUS and absf(f.global_position.y + Fighter.HEIGHT * 0.5 - global_position.y) < 30.0:
			f.receive_hit(owner_fighter, data, 1 if f.global_position.x >= global_position.x else -1)
			if owner_fighter != null and owner_fighter.move_fx != null:
				owner_fighter.move_fx.on_hit_landed(f, "castanha_estoura")
			_burst_fx()
			queue_free()
			return


## Estoura sem machucar ninguém (Seu Peba cavou e achou).
func defuse() -> void:
	_burst_fx()
	queue_free()


func _burst_fx() -> void:
	if owner_fighter != null and is_instance_valid(owner_fighter) and owner_fighter.move_fx != null:
		# folha com a base na linha ~58 do quadro: centro 52 px acima do chão (2x)
		owner_fighter.move_fx.play_at("fx_estouro_castanha", global_position + Vector2(0, -54), 2.0, 0.45)


func _draw() -> void:
	if _tex != null:
		var i := 0
		if armed():
			if fmod(_age, 1.0) > 0.92:
				return   # pisca 1 quadro por segundo
			i = int(_age * 4.0) % 2
		# a base do montinho fica na linha ~58 do quadro; 2 px dentro do chão
		draw_set_transform(Vector2.ZERO, 0.0, Vector2(2, 2))
		draw_texture_rect_region(_tex, Rect2(-_fw * 0.5, -58, _fw, 64), Rect2(i * _fw, 0, _fw, 64))
		draw_set_transform(Vector2.ZERO)
		return
	# Sem arte: montinho de terra; armado: a pontinha da castanha aparece.
	var dirt := Color("7a4a22")
	draw_rect(Rect2(-14, -6, 28, 6), Color("2a0f12"))
	draw_rect(Rect2(-12, -5, 24, 5), dirt)
	draw_rect(Rect2(-8, -8, 16, 3), dirt.lightened(0.15))
	if armed():
		var a := 0.75 + 0.25 * sin(_age * 6.0)
		draw_rect(Rect2(-3, -11, 6, 4), Color("7a3a1a", a))
		draw_rect(Rect2(-2, -11, 2, 1), Color("b0602a", a))
