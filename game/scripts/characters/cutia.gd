class_name CutiaLigeira
extends Fighter
## Cutia Ligeira: cutia vendedora de castanha na feira (design/personagens/cutia.md).
## Rápida. Especiais:
##  - neutro "Saquinho de castanha": arremessa um saquinho que voa em arco e quica.
##  - lado "Carrinhada": dispara empurrando o carrinho de mão e atropela.
##  - cima "Pulo de cutia": salto alto das pernas compridas (recuperação).
##  - baixo "Enterra castanha": esconde uma castanha no chão (armadilha que estoura
##    quando o adversário pisa). Em cima de uma castanha dela: desenterra e arremessa.
## Mecânica própria: as castanhas enterradas (até 3) viram campo minado do palco.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const CASTANHA_PATH := "res://assets/characters/cutia/pixel/castanha.png"
const DASH_SPEED := 980.0
const HOP_SPEED := 1250.0
const DIG_RANGE := 50.0

@export var bag_speed := 700.0

var _dug_up := false


func _bag(speed: Vector2, data: AttackData, bounces: int) -> void:
	var p := Projectile.spawn(PROJECTILE, self, data, hitbox_center(data), speed, 1.6)
	p.gravity = 1500.0
	p.bounces = bounces
	p.color = Color("b0602a")
	if has_art and ResourceLoader.exists(CASTANHA_PATH):
		p.set_sprite(load(CASTANHA_PATH), 1.5)


func _nearest_buried() -> CastanhaEnterrada:
	for n in get_tree().get_nodes_in_group("castanhas_enterradas"):
		var c := n as CastanhaEnterrada
		if c.owner_fighter == self and absf(c.global_position.x - global_position.x) < DIG_RANGE \
				and absf(c.global_position.y - (global_position.y + HEIGHT * 0.5)) < 30.0:
			return c
	return null


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				_bag(Vector2(bag_speed * facing, -320.0), attack, 2)
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity.x = DASH_SPEED * facing
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.3
		"special_up":
			if frame == attack.startup:
				velocity.y = -HOP_SPEED
				_attack_in_air = true
				jumped.emit(true)
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
					var trap := attack.duplicate() as AttackData
					trap.damage = 8.0
					trap.angle = 85.0
					trap.base_knockback = 330.0
					trap.knockback_growth = 5.5
					CastanhaEnterrada.bury(self, global_position + Vector2(36.0 * facing, HEIGHT * 0.5), trap)
