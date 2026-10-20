class_name SeuPeba
extends Fighter
## Seu Peba: tatu-peba forrozeiro sanfoneiro (design/personagens/tatu_peba.md).
## Versátil e defensivo. Especiais:
##  - neutro "Nota de sanfona": solta uma nota musical que voa reta.
##  - lado "Rolamento de casco": vira bola e rola atropelando.
##  - cima "Fole a jato": a sanfona sopra e ele sobe (recuperação).
##  - baixo "Toca": cava, some no chão e reaparece mais à frente com as garras
##    para cima (fica intocável enquanto está embaixo da terra).
## Mecânica própria "Casco": golpe que acerta pelas costas tira metade do dano
## e empurra menos.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const NOTA_PATH := "res://assets/characters/tatu_peba/pixel/nota.png"
const ROLL_SPEED := 820.0
const JET_SPEED := 1150.0
const BURROW_DISTANCE := 260.0
const SHELL_DAMAGE := 0.5
const SHELL_KNOCKBACK := 0.6

@export var note_speed := 900.0


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if attacker != null and is_instance_valid(attacker) and data != null:
		var from_behind := signf(attacker.global_position.x - global_position.x) == -float(facing)
		if from_behind:
			var shell := data.duplicate() as AttackData
			shell.damage *= SHELL_DAMAGE
			shell.base_knockback *= SHELL_KNOCKBACK
			shell.knockback_growth *= SHELL_KNOCKBACK
			return super(attacker, shell, direction_sign)
	return super(attacker, data, direction_sign)


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				var p := Projectile.spawn(PROJECTILE, self, attack, hitbox_center(attack), Vector2(note_speed * facing, 0.0), 0.9)
				if has_art and ResourceLoader.exists(NOTA_PATH):
					p.set_sprite(load(NOTA_PATH))
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity.x = ROLL_SPEED * facing
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.25
		"special_up":
			if frame == attack.startup:
				velocity.y = -JET_SPEED
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if _attack_in_air:
				return   # só cava no chão (no ar é um golpe normal)
			if frame < attack.startup:
				invincible_time = maxf(invincible_time, 0.05)
				visible = frame < attack.startup / 2   # some embaixo da terra
				if frame == attack.startup / 2:
					_burrow_move()
			elif frame == attack.startup:
				visible = true


## Anda por baixo da terra até BURROW_DISTANCE à frente (ou na direção segurada),
## sem sair do palco: só para onde ainda há chão.
func _burrow_move() -> void:
	var dir := controls.axis("left", "right")
	var side := signf(dir) if absf(dir) > 0.0 else float(facing)
	facing = int(side)
	var space := get_world_2d().direct_space_state
	var best := global_position.x
	var step := 20.0
	var x := step
	while x <= BURROW_DISTANCE:
		var probe := global_position + Vector2(side * x, 0)
		var q := PhysicsRayQueryParameters2D.create(probe, probe + Vector2(0, HEIGHT * 0.5 + 30.0), LAYER_STAGE)
		if space.intersect_ray(q).is_empty():
			break
		best = probe.x
		x += step
	global_position.x = best


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_down":
		visible = true
