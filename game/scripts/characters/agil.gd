class_name Agil
extends Fighter
## Personagem temporário "Ágil" (ver design/gdd.md, Personagens temporários):
## rápido, leve, de combos. Os 9 básicos são só dados (data/movesets/agil.tres);
## aqui ficam os 4 especiais, que precisam de código:
##   neutro: projétil rápido    lateral: investida que atravessa o palco
##   cima: teletransporte curto (recuperação)    baixo: contra-ataque

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")

@export_group("Especiais")
@export var projectile_speed := 1000.0
@export var projectile_life := 1.1
## Distância do teletransporte (especial para cima), na direção da alavanca.
@export var teleport_distance := 260.0

## Quadros parado no ar depois de chegar do teletransporte.
const TELEPORT_HOVER := 6

## Contra-ataque: a janela vai do quadro COUNTER_FROM até o fim do startup do golpe.
const COUNTER_FROM := 3
const COUNTER_RANGE := 280.0
const COUNTER_MIN_DAMAGE := 8.0
const COUNTER_DAMAGE_MULT := 1.4
const COUNTER_ANGLE := 45.0
const COUNTER_EXTRA_KNOCKBACK := 120.0
## Quadros de recuperação que sobram depois de contra-atacar.
const COUNTER_RECOVERY := 12

var _teleport_dir := Vector2.UP
var _countered := false
var _counter_flash := 0.0
var _pending_counter_foe: Fighter = null
var _pending_counter_data: AttackData = null
var _trail_from := Vector2.ZERO
var _trail_to := Vector2.ZERO
var _trail_time := 0.0


func start_special(kind: String) -> void:
	_countered = false
	if kind == "up":
		# A direção vale no instante do apertar: diagonal para cima ou reto para cima
		var stick := Vector2(Input.get_axis(act("left"), act("right")), Input.get_axis(act("up"), act("down")))
		_teleport_dir = stick.normalized() if stick.length() >= 0.5 else Vector2.UP
		if absf(_teleport_dir.x) > 0.1:
			facing = 1 if _teleport_dir.x > 0.0 else -1
	super.start_special(kind)


func _physics_process(delta: float) -> void:
	if _pending_counter_foe != null:
		_apply_pending_counter()
	super._physics_process(delta)
	_trail_time = maxf(_trail_time - delta, 0.0)
	_counter_flash = maxf(_counter_flash - delta, 0.0)


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				var vel := Vector2(projectile_speed * facing, 0.0)
				Projectile.spawn(PROJECTILE, self, attack, hitbox_center(attack), vel, projectile_life)
		"special_side":
			_dash(frame)
		"special_up":
			if frame < attack.startup:
				velocity = Vector2.ZERO  # paira um instante antes de sumir
			elif frame == attack.startup:
				_teleport()
			elif frame <= attack.startup + attack.active + TELEPORT_HOVER:
				velocity = Vector2.ZERO  # paira um pouco na chegada, depois cai sem pulo


## Investida: parado na preparação, depois velocidade constante (self_velocity.x do golpe).
func _dash(frame: int) -> void:
	var end := attack.startup + attack.active
	if frame <= attack.startup:
		velocity.x = 0.0
	elif frame <= end:
		velocity.x = attack.self_velocity.x * facing
		velocity.y = 0.0
	elif frame == end + 1:
		velocity.x *= 0.25  # freia ao terminar


func _teleport() -> void:
	_trail_from = global_position
	move_and_collide(_teleport_dir * teleport_distance)  # para se bater no palco
	_trail_to = global_position
	_trail_time = 0.25
	velocity = Vector2.ZERO
	_attack_in_air = true  # daqui em diante é golpe de ar (cai e pousa normalmente)


func _on_attack_end(_move_id: String) -> void:
	_countered = false


func _counter_active() -> bool:
	return attack != null and attack_id == "special_down" and not _countered \
		and attack_frame >= COUNTER_FROM and attack_frame <= attack.startup


## Durante a janela do contra-ataque o golpe é ignorado e o agressor apanha.
func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if not _counter_active():
		return super.receive_hit(attacker, data, direction_sign)
	_countered = true
	_counter_flash = 0.25
	var foe := attacker as Fighter
	if foe != null and foe.global_position.distance_to(global_position) <= COUNTER_RANGE:
		var strike := attack.duplicate() as AttackData
		strike.damage = maxf(COUNTER_MIN_DAMAGE, data.damage * COUNTER_DAMAGE_MULT)
		strike.angle = COUNTER_ANGLE
		strike.base_knockback += COUNTER_EXTRA_KNOCKBACK
		_pending_counter_foe = foe
		_pending_counter_data = strike
		attack_frame = maxi(attack_frame, attack.total_frames() - COUNTER_RECOVERY)
	return false


## O golpe de volta sai no início do próximo quadro: aplicá-lo aqui dentro tiraria o
## golpe do agressor no meio do processamento dele (ele ainda está em _check_hits).
func _apply_pending_counter() -> void:
	var foe := _pending_counter_foe
	var strike := _pending_counter_data
	_pending_counter_foe = null
	_pending_counter_data = null
	if foe == null or not is_instance_valid(foe) or not foe.can_be_hit():
		return
	var side := signi(roundi(foe.global_position.x - global_position.x))
	if side != 0:
		facing = side
	foe.receive_hit(self, strike, facing)


func _draw() -> void:
	super._draw()
	if _counter_active() or _counter_flash > 0.0:
		var c := Color.WHITE if _counter_flash > 0.0 else Color(0.4, 1.0, 1.0, 0.8)
		draw_arc(Vector2.ZERO, 66.0, 0.0, TAU, 32, c, 4.0)
	if _trail_time > 0.0:
		var a := _trail_time / 0.25
		draw_line(to_local(_trail_from), to_local(_trail_to), Color(0.6, 0.9, 1.0, a), 6.0)
		draw_circle(to_local(_trail_from), 18.0 * a, Color(0.6, 0.9, 1.0, a * 0.6))
