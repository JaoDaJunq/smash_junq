class_name Calango
extends Fighter
## Calango: lagarto ambulante de praia (design/personagens/calango.md). Rápido. Especiais:
##  - neutro "Joga areia": nuvem curta de areia; quem leva fica com areia nos olhos
##    e o próximo golpe dele ERRA (Fighter.sand_time).
##  - lado "Corrida de calango": corre em pé, rapidíssimo; encostando numa parede, sobe por ela.
##  - cima "Salto de lagartixa" (recuperação).
##  - baixo "Tomar sol": deita e esquenta; depois fica mais rápido por SUN_TIME segundos.
## Mecânica própria "Rabo solto": 1 vez (até o rabo crescer de novo, TAIL_REGROW s), um
## golpe que o lançaria longe só arranca o rabo: ele toma o dano mas não voa, fica
## intocável um instante, e o rabo fica no chão se mexendo.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const RABO_PATH := "res://assets/characters/calango/pixel/rabo.png"
const SAND_BLIND := 2.5
const RUN_SPEED := 1000.0
const WALL_CLIMB := 620.0
const HOP_SPEED := 1200.0
const SUN_TIME := 7.0
const SUN_BOOST := 1.3
const TAIL_LAUNCH := 900.0   # lançamento a partir do qual o rabo se solta
const TAIL_REGROW := 15.0

var tail_ready := true
var _tail_timer := 0.0
var _sun := 0.0
var _base_speeds := Vector3.ZERO


func _ready() -> void:
	super()
	_base_speeds = Vector3(walk_speed, run_speed, air_speed)


func has_sun() -> bool:
	return _sun > 0.0


func _physics_process(delta: float) -> void:
	if not tail_ready:
		_tail_timer -= delta
		if _tail_timer <= 0.0:
			tail_ready = true
	if _sun > 0.0:
		_sun -= delta
		if _sun <= 0.0:
			walk_speed = _base_speeds.x
			run_speed = _base_speeds.y
			air_speed = _base_speeds.z
	super(delta)


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if data != null and tail_ready and state != State.SHIELD:
		var speed := Combat.launch_speed(data, damage_percent + data.damage, weight)
		if speed >= TAIL_LAUNCH:
			tail_ready = false
			_tail_timer = TAIL_REGROW
			damage_percent += data.damage
			damage_changed.emit(damage_percent)
			invincible_time = maxf(invincible_time, 0.6)
			velocity = Vector2(direction_sign * 260.0, -200.0)
			_drop_tail()
			hit_taken.emit(attacker, data, Vector2.ZERO)
			return true
	return super(attacker, data, direction_sign)


func _drop_tail() -> void:
	var r := RaboSolto.new()
	r.add_to_group("match_cleanup")
	get_parent().add_child(r)
	r.global_position = global_position + Vector2(-20.0 * facing, HEIGHT * 0.5 - 6.0)
	if ResourceLoader.exists(RABO_PATH):
		r.tex = load(RABO_PATH)


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				var p := Projectile.spawn(PROJECTILE, self, attack, hitbox_center(attack), Vector2(520.0 * facing, 0.0), 0.25)
				p.color = Color("e8d48a")
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity.x = RUN_SPEED * facing
				if is_on_wall():
					velocity.y = -WALL_CLIMB
					_attack_in_air = true
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.3
		"special_up":
			if frame == attack.startup:
				velocity.y = -HOP_SPEED
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if frame == attack.startup and is_on_floor():
				_sun = SUN_TIME
				walk_speed = _base_speeds.x * SUN_BOOST
				run_speed = _base_speeds.y * SUN_BOOST
				air_speed = _base_speeds.z * SUN_BOOST


func _on_hit_landed(target: Fighter, move_id: String) -> void:
	if move_id == "special_neutral":
		target.sand_time = SAND_BLIND
