class_name Maracaja
extends Fighter
## Maracajá: jaguatirica malandra do parkour (design/personagens/maracaja.md).
## Rápido e rasteiro. Especiais:
##  - neutro "Espreita": segurar Especial carrega (agachado, mexendo o quadril);
##    soltar salta reto com as garras. Quanto mais carregou, mais longe e forte.
##  - lado "Bote": salto em arco; quem ele pegar fica preso, leva arranhões e é
##    arremessado (agarrão, vence o escudo).
##  - cima "Salto de parede": dois saltos seguidos em zigue-zague (recuperação).
##  - baixo "Cochilo de gato": deita fingindo dormir; quem bater nele nessa
##    hora leva um coice duplo (contra-ataque). Sem ninguém bater, só cochila.
## Mecânica própria: no ar, encostando na lateral do palco, gruda por um
## instante e pode pular de novo dali (pulo de parede).

## Arremesso do bote (recurso na cena; ver maracaja.tscn).
@export var pounce_throw_data: AttackData

const MAX_CHARGE := 45
const LEAP_SPEED := Vector2(900.0, 1500.0)   # sem carga -> carga cheia
const LEAP_DAMAGE_BONUS := 0.8
const LEAP_LIFT := 420.0
## Bote: velocidade do salto em arco e quadros segurando (2 arranhões) antes de arremessar.
const POUNCE_VELOCITY := Vector2(720.0, -620.0)
const POUNCE_HOLD := 22
const POUNCE_SCRATCH := 2.0
## Salto de parede: os dois impulsos (quadro e velocidade).
const CLIMB_1 := 0
const CLIMB_2 := 12
const CLIMB_SPEED := Vector2(260.0, 1050.0)
## Gruda na parede: tempo máximo, espera para grudar de novo e o pulo dela.
const CLING_TIME := 0.7
const CLING_COOLDOWN := 0.5
const WALL_JUMP := Vector2(520.0, 980.0)

## Cochilo: janela do contra-ataque (do quadro COUNTER_FROM até o fim do startup).
const COUNTER_FROM := 3
const COUNTER_RANGE := 260.0
const COUNTER_MIN_DAMAGE := 9.0
const COUNTER_DAMAGE_MULT := 1.3

var _countered := false
var _pending_counter_foe: Fighter = null
var _pending_counter_data: AttackData = null
var _charging := false
var _charge := 0
var _pounce_timer := 0
var _cling := 0.0
var _cling_cooldown := 0.0
var _cling_side := 0     # lado da parede: 1 = parede à direita


func start_special(kind: String) -> void:
	super(kind)
	if kind == "neutral" and attack_id == "special_neutral":
		_charging = true
		_charge = 0


func charge_ratio() -> float:
	return float(_charge) / MAX_CHARGE if _charging and attack_id == "special_neutral" else -1.0


func is_clinging() -> bool:
	return _cling > 0.0


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral": _leap_step(frame)
		"special_side": _pounce_step(frame)
		"special_up": _climb_step(frame)
		"special_down":
			if frame == attack.startup + 1 and not _countered:
				attack_frame = attack.startup + attack.active + 1   # ninguém bateu: só levanta


func _on_attack_end(move_id: String) -> void:
	_countered = false
	match move_id:
		"special_neutral":
			_charging = false
			_charge = 0
		"special_side":
			if holding != null:
				_throw()


func _physics_process(delta: float) -> void:
	if _pending_counter_foe != null:
		_apply_pending_counter()
	super._physics_process(delta)


func counter_active() -> bool:
	return attack != null and attack_id == "special_down" and not _countered 		and attack_frame >= COUNTER_FROM and attack_frame <= attack.startup


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if counter_active():
		_countered = true
		var foe := attacker as Fighter
		if foe != null and foe.global_position.distance_to(global_position) <= COUNTER_RANGE:
			var strike := attack.duplicate() as AttackData
			strike.damage = maxf(COUNTER_MIN_DAMAGE, data.damage * COUNTER_DAMAGE_MULT)
			_pending_counter_foe = foe
			_pending_counter_data = strike
		attack_frame = attack.startup + 1   # acorda no coice
		return false
	_charging = false
	_charge = 0
	_cling = 0.0
	return super(attacker, data, direction_sign)


# --- Cochilo de gato (contra-ataque) ---

## O coice sai no começo do próximo quadro (aplicar dentro do golpe do
## agressor tiraria o golpe dele no meio do processamento).
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


func _check_hits() -> void:
	if attack_id == "special_down":
		return   # o cochilo só machuca de volta (contra-ataque)
	super._check_hits()


# --- Espreita (bote reto carregável) ---

func _leap_step(frame: int) -> void:
	if _charging:
		if frame < attack.startup:
			velocity.x = 0.0
			return
		if controls.pressed("special") and _charge < MAX_CHARGE:
			_charge += 1
			attack_frame = attack.startup - 1   # fica espreitando
			velocity.x = 0.0
			return
		_charging = false
		var ratio := float(_charge) / MAX_CHARGE
		var scaled := attack.duplicate() as AttackData
		scaled.damage *= 1.0 + LEAP_DAMAGE_BONUS * ratio
		scaled.base_knockback *= 1.0 + 0.4 * ratio
		attack = scaled
		velocity.x = lerpf(LEAP_SPEED.x, LEAP_SPEED.y, ratio) * facing
		velocity.y = -LEAP_LIFT   # salto baixo e longo (no ar, sem atrito do chão)
		_attack_in_air = true
		return
	if frame > attack.startup + attack.active:
		velocity.x *= 0.9


# --- Bote (agarrão em arco) ---

func _pounce_step(frame: int) -> void:
	if holding != null:
		attack_frame = attack.startup + attack.active + 1
		velocity = Vector2.ZERO
		_pounce_timer += 1
		if _pounce_timer % 8 == 0 and holding != null:
			holding.damage_percent += POUNCE_SCRATCH   # arranhões enquanto prende
			holding.damage_changed.emit(holding.damage_percent)
		if _pounce_timer >= POUNCE_HOLD:
			_throw()
		return
	if frame == attack.startup:
		velocity = Vector2(POUNCE_VELOCITY.x * facing, POUNCE_VELOCITY.y)
		_attack_in_air = true
	if not attack.is_active(frame):
		return
	var center := hitbox_center(attack)
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == self or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(center, attack.hitbox_radius, target.hurtbox()):
			hold(target)
			_pounce_timer = 0
			return


func _throw() -> void:
	var data := pounce_throw_data if pounce_throw_data != null else moveset.special_side
	throw_held(data, facing)


# --- Salto de parede (recuperação em zigue-zague) ---

func _climb_step(frame: int) -> void:
	var dir := controls.axis("left", "right")
	if frame == attack.startup + CLIMB_1 or frame == attack.startup + CLIMB_2:
		var side := signf(dir) if absf(dir) > 0.0 else float(facing)
		if frame == attack.startup + CLIMB_2:
			side = -side if absf(dir) == 0.0 else side   # zigue-zague se não escolher lado
		velocity = Vector2(CLIMB_SPEED.x * side, -CLIMB_SPEED.y)
		_attack_in_air = true
		jumped.emit(true)


# --- Gruda na parede ---

func _process_air(dir: float, delta: float) -> void:
	_cling_cooldown = maxf(_cling_cooldown - delta, 0.0)
	if _cling > 0.0:
		_process_cling(dir, delta)
		return
	super(dir, delta)
	if state == State.AIR and not helpless and _cling_cooldown <= 0.0 and velocity.y > -100.0 and _touching_wall():
		var n := _wall_normal
		_cling_side = -int(signf(n.x))
		if _cling_side != 0:
			_cling = CLING_TIME
			facing = _cling_side
			velocity = Vector2.ZERO
			fast_falling = false


var _wall_normal := Vector2.ZERO


## Encostado numa parede (ou lateral bem inclinada de uma ilha).
func _touching_wall() -> bool:
	for i in get_slide_collision_count():
		var n := get_slide_collision(i).get_normal()
		if absf(n.x) > 0.7:
			_wall_normal = n
			return true
	return false


func _process_cling(dir: float, delta: float) -> void:
	state = State.AIR
	_cling -= delta
	velocity = Vector2(_cling_side * 40.0, 30.0)   # encostado, escorregando bem devagar
	if controls.just_pressed("jump"):
		_cling = 0.0
		_cling_cooldown = CLING_COOLDOWN
		facing = -_cling_side
		_jump(WALL_JUMP.y)
		velocity.x = WALL_JUMP.x * facing
		_air_dodge_used = false
		return
	if _cling <= 0.0 or (absf(dir) > 0.0 and signf(dir) != _cling_side) or controls.just_pressed("down"):
		_cling = 0.0
		_cling_cooldown = CLING_COOLDOWN
		return
	if _try_start_action():
		_cling = 0.0
		_cling_cooldown = CLING_COOLDOWN
