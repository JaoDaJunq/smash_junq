class_name Tucao
extends Fighter
## Tucão: tucano-toco pipoqueiro do estádio (design/personagens/tucano.md).
## Forte. Especiais:
##  - neutro "Punhado de pipoca": 3 pipocas em leque, de perto.
##  - lado "Bicada investida": corpo esticado, desliza de bico à frente.
##  - cima "Voo de bico": sobe de bico para cima (recuperação).
##  - baixo "Bicada pilão": no ar, mergulha de bico; no chão, crava o bico à frente.
## Mecânica própria "Bico blindado": durante os golpes de bico ele toma o dano
## mas não é interrompido nem lançado (aguenta o tranco e bate mesmo assim).

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PIPOCA_PATH := "res://assets/characters/tucano/pixel/pipoca.png"
const PIPOCA_COR := Color("f5ecc8")
## Golpes de bico (com o bico blindado) e a partir de que quadro até o fim do ativo.
const BICO := ["jab_c", "ftilt", "utilt", "fair", "uair", "dair", "special_side", "special_down"]
const LUNGE_SPEED := 900.0
const FLY_SPEED := 1180.0
const DIVE_SPEED := 1300.0

@export var pipoca_speed := 760.0


func is_beak_armored() -> bool:
	return attack != null and attack_id in BICO and attack_frame <= attack.startup + attack.active


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if data != null and state != State.SHIELD and is_beak_armored():
		damage_percent += data.damage
		var stop := Combat.hitstop_frames(data.damage)
		_hitstop = stop
		if attacker is Fighter:
			attacker._hitstop = stop
		damage_changed.emit(damage_percent)
		hit_taken.emit(attacker, data, Vector2.ZERO)
		return true
	return super(attacker, data, direction_sign)


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				for a in [-0.22, 0.0, 0.22]:
					var v := Vector2(pipoca_speed * facing, 0.0).rotated(a * facing) + Vector2(0, -60)
					var p := Projectile.spawn(PROJECTILE, self, attack, hitbox_center(attack), v, 0.45)
					p.color = PIPOCA_COR
					if has_art and ResourceLoader.exists(PIPOCA_PATH):
						p.set_sprite(load(PIPOCA_PATH))
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity.x = LUNGE_SPEED * facing
				if not is_on_floor():
					velocity.y = minf(velocity.y, 60.0)
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.2
		"special_up":
			if frame == attack.startup:
				velocity.y = -FLY_SPEED
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if _attack_in_air and frame >= attack.startup / 2 and not is_on_floor():
				velocity = Vector2(velocity.x * 0.3, DIVE_SPEED)
