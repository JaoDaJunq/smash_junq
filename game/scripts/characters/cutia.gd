class_name CutiaLigeira
extends Fighter
## Cutia Ligeira: cutia vendedora de castanha na feira (design/personagens/cutia.md e
## design/revisao/novos_personagens.md §4). Rápida. Especiais:
##  - neutro "Saquinho de castanha": saquinho em arco que quica; se ERRAR e parar no
##    chão, rasga e PLANTA uma castanha ali (conta no limite de 3).
##  - lado "Carrinhada colhedora": dispara empurrando o carrinho de mão; as castanhas
##    dela no caminho são recolhidas (até 3) e, no acerto ou no fim, o carrinho
##    DESPEJA em leque. Para na beirada.
##  - cima "Pulo de susto": sobe no 3º quadro, intocável do 3º ao 6º, e derruba uma
##    castanha para baixo (afunda quem guarda a borda).
##  - baixo "Enterra castanha": esconde uma castanha no chão (armadilha). Em cima de
##    uma castanha dela: desenterra e arremessa turbinada.
## Mecânica própria: as castanhas enterradas (até 3) viram campo minado do palco.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const CASTANHA_PATH := "res://assets/characters/cutia/pixel/castanha.png"
const DASH_SPEED := 980.0
const AIR_DASH := 500.0
const DIG_RANGE := 50.0
const BAG_PLANT := true            # saquinho que para no chão sem acertar planta castanha
const CART_COLLECT_RANGE := 40.0   # px dos pés até a castanha para recolher
const CART_MAX := 3
const CART_SPREAD := [-0.30, -0.10, 0.10]   # ângulos do despejo
const CART_SHOT_SPEED := 760.0
const SCARE_HOP := 1300.0          # pulo de susto
const SCARE_INTANGIBLE := Vector2i(3, 6)

@export var bag_speed := 700.0

var _dug_up := false
var _cart_load := 0
var _cart_dumped := false
var collected_total := 0           # (testes) castanhas recolhidas pela carrinhada


func _trap_data() -> AttackData:
	var base := moveset.move("special_down") if moveset != null else attack
	var trap := base.duplicate() as AttackData
	trap.damage = 8.0
	trap.angle = 85.0
	trap.base_knockback = 330.0
	trap.knockback_growth = 5.5
	return trap


func _bag(speed: Vector2, data: AttackData, bounces: int) -> Projectile:
	var p := Projectile.spawn(PROJECTILE, self, data, hitbox_center(data), speed, 1.6)
	p.gravity = 1500.0
	p.bounces = bounces
	p.color = Color("b0602a")
	if has_art and ResourceLoader.exists(CASTANHA_PATH):
		p.set_sprite(load(CASTANHA_PATH), 1.5)
	return p


func _nearest_buried() -> CastanhaEnterrada:
	for n in get_tree().get_nodes_in_group("castanhas_enterradas"):
		var c := n as CastanhaEnterrada
		if c.owner_fighter == self and not c.is_queued_for_deletion() and absf(c.global_position.x - global_position.x) < DIG_RANGE \
				and absf(c.global_position.y - (global_position.y + HEIGHT * 0.5)) < 30.0:
			return c
	return null


## Saquinho que errou e parou no chão: rasga e planta uma castanha.
func _on_bag_landed(p: Projectile) -> void:
	if not BAG_PLANT or not is_instance_valid(self):
		return
	var spot := CastanhaEnterrada.free_spot(self, p.global_position + Vector2(0, 6))
	if move_fx != null:
		move_fx.play_at("fx_saquinho_rasga", p.global_position + Vector2(0, -16), 3.0, 0.4, "rasgo")
	if spot != Vector2.INF:
		CastanhaEnterrada.bury(self, spot, _trap_data())


func _is_intangible() -> bool:
	if attack_id == "special_up" and attack != null and attack_frame >= SCARE_INTANGIBLE.x and attack_frame <= SCARE_INTANGIBLE.y:
		return true
	return super()


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				var p := _bag(Vector2(bag_speed * facing, -320.0), attack, 2)
				p.landed_still.connect(_on_bag_landed)
		"special_side":
			if frame == 1:
				_cart_load = 0
				_cart_dumped = false
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				if is_on_floor() and not _attack_in_air:
					velocity.x = DASH_SPEED * facing
					_collect()
					if not _floor_ahead():
						velocity.x = 0.0   # o carrinho para na beirada
				else:
					velocity.x = AIR_DASH * facing   # no ar: só um passo curto
				if frame == attack.startup + attack.active:
					_dump()
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.3
		"special_up":
			if frame == attack.startup:
				velocity.y = -SCARE_HOP
				_attack_in_air = true
				jumped.emit(true)
			elif frame == attack.startup + 1:
				var d := attack.duplicate() as AttackData
				d.damage = 3.0
				d.angle = -60.0
				d.base_knockback = 260.0
				d.knockback_growth = 2.0
				d.hitbox_radius = 16.0
				var p := _bag(Vector2(0.0, 600.0), d, 0)
				p.global_position = global_position + Vector2(0, HEIGHT * 0.5)
		"special_down":
			if frame == 1:
				_dug_up = false
			if _attack_in_air or not is_on_floor():
				return
			if frame == attack.startup:
				var c := _nearest_buried()
				if c != null:
					# Desenterra e arremessa: castanha "turbinada" (mais dano, voa reto e baixo)
					c.queue_free()
					_dug_up = true
					var d := attack.duplicate() as AttackData
					d.damage = 9.0
					d.angle = 40.0
					_bag(Vector2(900.0 * facing, -300.0), d, 0)
				else:
					var spot := CastanhaEnterrada.free_spot(self, global_position + Vector2(36.0 * facing, HEIGHT * 0.5))
					if spot != Vector2.INF:
						CastanhaEnterrada.bury(self, spot, _trap_data())


## Recolhe as castanhas dela que o carrinho alcança.
func _collect() -> void:
	if _cart_load >= CART_MAX:
		return
	var feet := global_position + Vector2(0, HEIGHT * 0.5)
	for n in get_tree().get_nodes_in_group("castanhas_enterradas"):
		var c := n as CastanhaEnterrada
		if c == null or c.owner_fighter != self or c.is_queued_for_deletion():
			continue
		if absf(c.global_position.x - (feet.x + facing * 20.0)) <= CART_COLLECT_RANGE and absf(c.global_position.y - feet.y) < 30.0:
			c.queue_free()
			_cart_load += 1
			collected_total += 1
			if move_fx != null:
				move_fx.play_at("fx_cova", c.global_position + Vector2(0, -32), 1.5, 0.3)
			if _cart_load >= CART_MAX:
				return


## Despeja o que o carrinho recolheu: 1 castanha (4%) por unidade, em leque.
func _dump() -> void:
	if _cart_dumped or _cart_load <= 0:
		return
	_cart_dumped = true
	var d := attack.duplicate() as AttackData
	d.damage = 4.0
	d.hitbox_radius = 16.0
	d.base_knockback = 200.0
	d.knockback_growth = 2.5
	d.angle = 40.0
	for i in _cart_load:
		var a: float = CART_SPREAD[i % CART_SPREAD.size()]
		var v := Vector2(CART_SHOT_SPEED * facing, 0.0).rotated(a * facing) + Vector2(0, -260.0)
		var p := _bag(v, d, 0)
		p.global_position = global_position + Vector2(40.0 * facing, -10.0)
	_cart_load = 0
	queue_redraw()


func _on_hit_landed(_target: Fighter, move_id: String) -> void:
	if move_id == "special_side":
		_dump()


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_side":
		_cart_load = 0


func _floor_ahead() -> bool:
	# começa bem acima dos pés: a cápsula de cada bicho tem altura diferente
	var from := global_position + Vector2(facing * (RADIUS + 10.0), HEIGHT * 0.5 - 24.0)
	var q := PhysicsRayQueryParameters2D.create(from, from + Vector2(0, 56.0), collision_mask)
	q.exclude = [get_rid()]
	return not get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func _draw() -> void:
	super()
	# castanhas recolhidas aparecem empilhadas no carrinho
	if attack_id == "special_side" and _cart_load > 0:
		for i in _cart_load:
			var c := Vector2(facing * (44.0 + i * 9.0), 14.0 - (i % 2) * 7.0)
			draw_circle(c, 6.0, Color("2a0f12"))
			draw_circle(c, 4.5, Color("7a3a1a"))
			draw_circle(c + Vector2(-1.5, -1.5), 1.5, Color("b0602a"))
