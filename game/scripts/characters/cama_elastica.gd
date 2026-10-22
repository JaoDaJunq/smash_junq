class_name CamaElastica
extends Node2D
## Mini cama elástica deixada pela Marianinha (especial para cima). Fica LIFETIME s
## no palco; QUALQUER lutador que cair ou pisar em cima é lançado bem alto (dá para
## usar contra o adversário). Só existe uma por Marianinha.
## Sempre APOIADA: cai até achar palco ou plataforma (some se cair do palco),
## acompanha plataforma que se mexe (vitória-régia) e, na beirada, escorrega
## para dentro até os dois pés apoiarem.

const LIFETIME := 6.0
const WIDTH := 100.0
const BOUNCE := 1350.0
const LONA := 36.0              # altura da lona acima do chão (folha: linha 34 de 52)
const SPRITE_PATH := "res://assets/characters/marianinha/pixel/cama_elastica.png"
const MASK := Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM
## Quem está nestes estados não quica (agarrado, agarrando, pendurado, voltando,
## atordoado/hipnotizado): mexer neles deixava gente presa no agarrão para sempre.
const NO_BOUNCE := [Fighter.State.HELD, Fighter.State.HOLDING, Fighter.State.GRAB,
	Fighter.State.LEDGE, Fighter.State.RESPAWN, Fighter.State.HITSTUN]

var owner_fighter: Fighter
var _age := 0.0
var _squash := 0.0
var _tex: Texture2D
var _cool := {}
var _fall_v := 0.0
var _grounded := false
var _floor: Node2D
var _floor_off := Vector2.ZERO


static func place(by: Fighter, at: Vector2) -> CamaElastica:
	var c := CamaElastica.new()
	c.owner_fighter = by
	c.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	c.add_to_group("match_cleanup")
	c.add_to_group("camas_elasticas")
	by.get_parent().add_child(c)
	# Atrás dos lutadores mas na frente do cenário (z -1 ficava atrás do fundo da Ruínas).
	by.get_parent().move_child(c, by.get_index())
	c.global_position = at
	c._settle(0.0)
	return c


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)


func is_grounded() -> bool:
	return _grounded


func _ray(from: Vector2, to: Vector2) -> Dictionary:
	return get_world_2d().direct_space_state.intersect_ray(PhysicsRayQueryParameters2D.create(from, to, MASK))


## Sem chão embaixo, a cama cai até achar o palco ou uma plataforma.
func _settle(delta: float) -> void:
	var hit := _ray(global_position + Vector2(0, -4), global_position + Vector2(0, maxf(_fall_v * delta, 2.0) + 4.0))
	if hit.is_empty():
		_fall_v = minf(_fall_v + 2600.0 * delta, 1600.0)
		global_position.y += _fall_v * delta
		return
	global_position.y = hit.position.y
	_grounded = true
	_fall_v = 0.0
	_fit_on_floor()
	_floor = hit.collider as Node2D
	if _floor != null:
		_floor_off = global_position - _floor.global_position


## Na beirada: empurra para dentro (de 4 em 4 px, até 60) até os dois pés apoiarem.
func _fit_on_floor() -> void:
	var half := WIDTH * 0.5 - 2.0   # pernas da folha vão até ~48 px do centro
	var y := global_position.y
	for i in 16:
		var left := not _ray(Vector2(global_position.x - half, y - 8), Vector2(global_position.x - half, y + 12)).is_empty()
		var right := not _ray(Vector2(global_position.x + half, y - 8), Vector2(global_position.x + half, y + 12)).is_empty()
		if left == right:
			return   # os dois apoiados (ou nenhum: não dá para ajeitar)
		global_position.x += 4.0 if left == false else -4.0


func _physics_process(delta: float) -> void:
	_age += delta
	_squash = maxf(_squash - delta * 4.0, 0.0)
	if _age >= LIFETIME:
		queue_free()
		return
	if not _grounded:
		_settle(delta)
		if global_position.y > 1600.0:
			queue_free()
			return
	elif _floor != null and is_instance_valid(_floor):
		global_position = _floor.global_position + _floor_off   # segue a vitória-régia
	for k in _cool.keys():
		_cool[k] -= delta
	for f in get_tree().get_nodes_in_group("fighters"):
		var who := f as Fighter
		if who.velocity.y < 0.0 or _cool.get(who, 0.0) > 0.0 or not who.visible:
			continue
		if who.state in NO_BOUNCE or who.holding != null or who.held_by != null:
			continue
		var feet := who.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
		if absf(feet.x - global_position.x) <= WIDTH * 0.5 and feet.y >= global_position.y - LONA - 10.0 and feet.y <= global_position.y + 6.0:
			_bounce(who)
	queue_redraw()


func _bounce(who: Fighter) -> void:
	if who.state == Fighter.State.ATTACK and who.attack != null:
		who._end_attack()        # encerra o golpe direito (ganchos dos personagens rodam)
	who.fast_falling = false
	who.velocity.y = -BOUNCE
	who.state = Fighter.State.AIR
	who.helpless = false
	who.jumps_left = who.air_jumps
	who.global_position.y = global_position.y - LONA - Fighter.HEIGHT * 0.5
	who.jumped.emit(true)
	_cool[who] = 0.3
	_squash = 1.0


func _draw() -> void:
	if _tex != null:
		var n := maxi(1, _tex.get_width() / 64)
		var i := 0 if _squash <= 0.0 else (1 if _squash > 0.5 else 2)
		i = mini(i, n - 1)
		# pés da folha na linha 51: Rect2 começa em -52 para os pés tocarem o chão
		var sq := 1.0 - 0.12 * _squash
		draw_set_transform(Vector2.ZERO, 0.0, Vector2(2, 2 * sq))
		draw_texture_rect_region(_tex, Rect2(-32, -52, 64, 64), Rect2(i * 64, 0, 64, 64))
		draw_set_transform(Vector2.ZERO)
	else:
		draw_rect(Rect2(-WIDTH * 0.5, -LONA + _squash * 6.0, WIDTH, 6), Color(0.1, 0.1, 0.12))
		draw_rect(Rect2(-WIDTH * 0.5, -LONA, 6, LONA), Color(0.6, 0.6, 0.65))
		draw_rect(Rect2(WIDTH * 0.5 - 6, -LONA, 6, LONA), Color(0.6, 0.6, 0.65))
	# Some piscando no último segundo
	if _age > LIFETIME - 1.0:
		modulate.a = 0.5 + 0.5 * cos(_age * 20.0)
