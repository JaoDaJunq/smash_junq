class_name Estandarte
extends Node2D
## Estandarte da escola de samba fincado pela Dona Canga (especial para o lado).
## Perto dele, todo golpe dela conta como "na batida" da bateria. Fica até
## LIFETIME segundos ou até levar HITS golpes do adversário (projéteis também
## contam). Só existe um por Canga.
## Sempre fica APOIADO: se nasce sem chão embaixo, cai até achar palco ou
## plataforma (e some se cair do palco); em plataforma que se mexe (vitória-régia)
## acompanha a plataforma.

const LIFETIME := 12.0
const HITS := 2
const RADIUS := 230.0           # alcance do "ritmo da quadra"
const SPRITE_PATH := "res://assets/characters/arara_canga/pixel/estandarte.png"
const GRAVITY := 2600.0
const MAX_FALL := 1400.0

var owner_fighter: Fighter
var _age := 0.0
var _hp := HITS
var _hit_cooldown := 0.0
var _tex: Texture2D
var _frames := 1
var _fall := -1.0   # >= 0: tombando (derrubado)
var _grounded := false
var _drop_v := 0.0
var _floor: Node2D
var _floor_off := Vector2.ZERO
var _wobble := 0.0   # tremida quando leva golpe


static func plant(by: Fighter, at: Vector2) -> Estandarte:
	var e := Estandarte.new()
	e.owner_fighter = by
	e.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	e.add_to_group("match_cleanup")
	e.add_to_group("estandartes")
	by.get_parent().add_child(e)
	# Atrás dos lutadores mas NA FRENTE do cenário: com z -1 o fundo da Ruínas
	# (montanhas, z 0) cobria a bandeira. Mesmo z dos lutadores, antes deles na árvore.
	by.get_parent().move_child(e, by.get_index())
	e.global_position = at
	e._settle(0.0)
	return e


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)
		_frames = maxi(1, _tex.get_width() / 64)


## Só dá ritmo fincado no chão (caindo ou tombando não vale).
func covers(p: Vector2) -> bool:
	return _fall < 0.0 and _grounded and p.distance_to(global_position) <= RADIUS


func is_grounded() -> bool:
	return _grounded


## Cai até achar chão (palco ou plataforma) e gruda nele.
func _settle(delta: float) -> void:
	var step := maxf(_drop_v * delta, 2.0) + 4.0
	var q := PhysicsRayQueryParameters2D.create(global_position + Vector2(0, -4), global_position + Vector2(0, step),
		Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	if hit.is_empty():
		_drop_v = minf(_drop_v + GRAVITY * delta, MAX_FALL)
		global_position.y += _drop_v * delta
		return
	global_position.y = hit.position.y
	_grounded = true
	_drop_v = 0.0
	_floor = hit.collider as Node2D
	if _floor != null:
		_floor_off = global_position - _floor.global_position


func _physics_process(delta: float) -> void:
	_age += delta
	_hit_cooldown = maxf(_hit_cooldown - delta, 0.0)
	_wobble = maxf(_wobble - delta * 3.0, 0.0)
	if _fall >= 0.0:
		_fall += delta
		if _fall > 0.5:
			queue_free()
		queue_redraw()
		return
	if _age >= LIFETIME or owner_fighter == null or not is_instance_valid(owner_fighter):
		knock_down()
		return
	if not _grounded:
		_settle(delta)
		if global_position.y > 1600.0:
			queue_free()   # caiu do palco
			return
	elif _floor != null and is_instance_valid(_floor):
		global_position = _floor.global_position + _floor_off   # segue a vitória-régia
	# O adversário derruba a bandeira batendo nela (golpe ou projétil).
	var box := Rect2(global_position + Vector2(-14, -100), Vector2(28, 100))
	if _hit_cooldown <= 0.0:
		for f in get_tree().get_nodes_in_group("fighters"):
			var foe := f as Fighter
			if foe == owner_fighter or foe.attack == null or not foe.attack.is_active(foe.attack_frame):
				continue
			if Combat.circle_hits_rect(foe.hitbox_center(foe.attack), foe.attack.hitbox_radius, box):
				if foe is Tucao and foe.attack_id == "special_down":
					_hp -= 1   # bicada pilão do Tucão conta como 2 golpes
				if _take_hit():
					return
				break
	if _hit_cooldown <= 0.0:
		for n in get_tree().get_nodes_in_group("match_cleanup"):
			var p := n as Projectile
			if p == null or p.is_queued_for_deletion() or p.owner_fighter == owner_fighter or p.data == null:
				continue
			if Combat.circle_hits_rect(p.global_position, p.data.hitbox_radius, box):
				p.queue_free()
				if _take_hit():
					return
				break
	queue_redraw()


## Leva um golpe; true se caiu.
func _take_hit() -> bool:
	_hp -= 1
	_hit_cooldown = 0.3
	_wobble = 1.0
	if _hp <= 0:
		knock_down()
		return true
	return false


func knock_down() -> void:
	if _fall < 0.0:
		_fall = 0.0


func _draw() -> void:
	var rot := sin(_age * 40.0) * 0.12 * _wobble
	if _fall >= 0.0:
		rot = minf(_fall / 0.4, 1.0) * PI * 0.5
		modulate.a = 1.0 - clampf((_fall - 0.3) / 0.2, 0.0, 1.0)
	draw_set_transform(Vector2.ZERO, rot, Vector2(2, 2))
	if _tex != null:
		var i := int(_age * 5.0) % _frames
		var src := Rect2(i * 64, 0, 64, 64)
		# a ponta do mastro (linha 62 da folha) fica 2 px dentro do chão
		draw_texture_rect_region(_tex, Rect2(-32, -61, 64, 64), src)
	else:
		draw_line(Vector2(0, 0), Vector2(0, -48), Color(0.9, 0.75, 0.3), 2.0)
		draw_rect(Rect2(1, -46, 20, 13), Color(0.18, 0.43, 0.77))
	draw_set_transform(Vector2.ZERO)
