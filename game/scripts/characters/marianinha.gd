class_name Marianinha
extends Fighter
## Marianinha: marianinha-de-cabeça-amarela ginasta de trampolim
## (design/personagens/marianinha.md). Versátil, pequena e leve, 3 pulos no ar.
## Especiais:
##  - neutro "Semente": cospe uma semente de girassol reta (até 3 por pulo).
##  - lado "Bala de canhão": vira bolinha e é lançada para o lado.
##  - cima "Trampolim": três impulsos seguidos, cada um mais alto (recuperação).
##  - baixo "Bomba!": mergulha de bunda e, ao bater no chão, joga para cima quem
##    estiver perto.
## Mecânica própria "Quique": caindo em cima da cabeça de alguém, quica: o outro
## leva um pouco de dano e ela sobe de novo com os pulos de volta.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const SEMENTE_PATH := "res://assets/characters/marianinha/pixel/semente.png"
const MAX_SEEDS := 3
const CANNON_SPEED := 1250.0
const TRAMPOLINE := [760.0, 880.0, 1000.0]
const TRAMPOLINE_GAP := 10
const BOUNCE_SPEED := 820.0
const BOUNCE_DAMAGE := 2.0
const BOUNCE_COOLDOWN := 0.35

@export var seed_speed := 1200.0

var _seeds_left := MAX_SEEDS
var _diving := false
var _bounce_cooldown := 0.0


func _physics_process(delta: float) -> void:
	_bounce_cooldown = maxf(_bounce_cooldown - delta, 0.0)
	super._physics_process(delta)
	if is_on_floor():
		_seeds_left = MAX_SEEDS
	_try_bounce()


## Quique: pés caindo em cima da cabeça de outro lutador.
func _try_bounce() -> void:
	if _bounce_cooldown > 0.0 or velocity.y <= 50.0 or is_on_floor():
		return
	if state != State.AIR and not (state == State.ATTACK and _attack_in_air):
		return
	var feet := global_position + Vector2(0, HEIGHT * 0.5)
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		var head := foe.hurtbox()
		if feet.x >= head.position.x - 6.0 and feet.x <= head.end.x + 6.0 \
				and feet.y >= head.position.y - 6.0 and feet.y <= head.position.y + 26.0:
			foe.add_damage(BOUNCE_DAMAGE)
			velocity.y = -BOUNCE_SPEED
			jumps_left = air_jumps
			_bounce_cooldown = BOUNCE_COOLDOWN
			if state == State.ATTACK and not _diving:
				_end_attack()
			state = State.AIR
			jumped.emit(true)
			return


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				if _seeds_left <= 0:
					return
				_seeds_left -= 1
				var p := Projectile.spawn(PROJECTILE, self, attack, hitbox_center(attack), Vector2(seed_speed * facing, 0.0), 0.7)
				if has_art and ResourceLoader.exists(SEMENTE_PATH):
					p.set_sprite(load(SEMENTE_PATH))
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity = Vector2(CANNON_SPEED * facing, 0.0)
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.3
		"special_up":
			for i in TRAMPOLINE.size():
				if frame == attack.startup + i * TRAMPOLINE_GAP:
					velocity.y = -TRAMPOLINE[i]
					_attack_in_air = true
					_hit_targets.clear()
					jumped.emit(true)
		"special_down":
			if not _attack_in_air:
				return
			if _diving:
				fast_falling = true
				attack_frame = attack.startup   # segue mergulhando até bater no chão
				return
			if frame < attack.startup:
				velocity = Vector2.ZERO
			else:
				_diving = true
				fast_falling = true
				attack_frame = attack.startup


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_down":
		var landed := _diving and is_on_floor()
		_diving = false
		if landed and moveset != null:
			_pound(moveset.special_down)


## Bomba: ao bater no chão, joga para cima quem estiver perto.
func _pound(data: AttackData) -> void:
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		if Combat.circle_hits_rect(global_position, data.hitbox_radius * 1.3, foe.hurtbox()):
			foe.receive_hit(self, data, int(signf(foe.global_position.x - global_position.x)) if foe.global_position.x != global_position.x else facing)


func _check_hits() -> void:
	if attack_id == "special_down" and _diving:
		return   # no mergulho só machuca ao bater no chão
	super._check_hits()


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	_diving = false
	return super(attacker, data, direction_sign)
