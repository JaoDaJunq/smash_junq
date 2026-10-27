class_name SeuPreguicoso
extends Fighter
## Seu Preguiçoso: bicho-preguiça fiscal da prefeitura (design/personagens/preguica.md,
## design/revisao/novos_personagens.md §7). Pesado. Especiais:
##  - neutro "Bolha de moleza": bolha de câmera lenta no lugar dele (4 s, 1 por vez,
##    recarga 8 s). Dentro, adversários e projéteis a 50%; ele não.
##  - lado "Carona": se a garra pega, gruda nas costas do adversário até 3 s: o outro
##    fica lento (60%) e leva 1% a cada 20 quadros. Sai se o tempo acaba, se o outro
##    apertar escudo/ataque (cada aperto -0.3 s), se ele apertar pulo, se o outro
##    levar golpe ou ele levar golpe.
##    No casco do Seu Peba escorrega; no Calango arranca o rabo (ele foge).
##  - cima "Pendura no galho": sobe e fica pendurado no galho até 0.6 s
##    (baixo/pulo solta antes).
##  - baixo "Hora do cafezinho": sentado, cura 1% a cada 18 quadros enquanto segura
##    o botão (até 12% por gole; golpe derrama). No ar não tem café.
## Passivo "Cochilo": 4 s parado sem apanhar, cochila e cura 1%/s (até 10% por vida).
## A lentidão usa Fighter.slow_factor / Projectile.slow_factor.

const BUBBLE_CD := 8.0
const RIDE_TIME := 3.0
const RIDE_SLOW := 0.6
const RIDE_OFFSET := Vector2(-26.0, -34.0)   # nas costas (x vezes o facing do alvo)
const CLIMB_SPEED := 1080.0
const HANG_TIME := 0.6
const COFFEE_MAX := 12.0
const COFFEE_EVERY := 18
const NAP_AFTER := 4.0
const NAP_MAX := 10.0

var _bubble: BolhaMoleza = null
var _bubble_cd := 0.0
var _ride: Fighter = null
var _ride_time := 0.0
var _ride_tick := 0
var _ride_pos := Vector2.ZERO
var _hang := 0.0
var _coffee := 0.0
var _calm := 0.0
var _nap_healed := 0.0
var _nap_tick := 0.0


func _ready() -> void:
	super()
	hit_taken.connect(func(_a: Node2D, _d: AttackData, _l: Vector2) -> void:
		_calm = 0.0)


func _physics_process(delta: float) -> void:
	_bubble_cd = maxf(0.0, _bubble_cd - delta)
	if _ride != null:
		_process_ride(delta)
		return
	if _hang > 0.0:
		_hang -= delta
		if controls.pressed("down") or controls.just_pressed("jump"):
			_hang = 0.0
	if _hang > 0.0 and state == State.AIR:
		# pendurado no galho: parado no ar (pode pegar borda e levar golpe)
		var keep := global_position
		velocity = Vector2.ZERO
		super(delta)
		if state == State.AIR and _hang > 0.0:
			global_position = keep
			velocity = Vector2.ZERO
		else:
			_hang = 0.0
	else:
		_hang = 0.0
		super(delta)
	_process_nap(delta)


func is_riding() -> bool:
	return _ride != null


func is_hanging() -> bool:
	return _hang > 0.0


func is_napping() -> bool:
	return _calm >= NAP_AFTER and state == State.IDLE


func bubble_ready() -> bool:
	return _bubble_cd <= 0.0 and not is_instance_valid(_bubble)


# --- Carona ---

func _on_hit_landed(target: Fighter, move_id: String) -> void:
	if move_id != "special_side" or _ride != null:
		return
	if target is SeuPeba:
		velocity = Vector2(-facing * 260.0, -380.0)   # escorrega no casco
		if move_fx != null:
			move_fx.play_at("fx_poof", target.global_position + Vector2(0, -40), 2.0, 0.4, "poof")
		return
	if target.has_method("_lose_tail") and bool(target.get("tail_ready")):
		# puxou o rabo do Calango: ele foge, a preguiça fica com o rabo na mão
		target._lose_tail(self, attack, facing)
		return
	# a garra não lança: tira o atordoamento e monta nas costas
	target._hitstun = 0.0
	target._hitstun_total = 0.0
	target._launch = Vector2.ZERO
	target.velocity = Vector2.ZERO
	target.state = State.IDLE if target.is_on_floor() else State.AIR
	_ride = target
	_ride_time = RIDE_TIME
	_ride_tick = 0
	_ride_pos = _ride_spot(target)
	if attack != null:
		_on_attack_end(attack_id)
	attack = null
	attack_id = ""
	state = State.AIR
	global_position = _ride_pos


func _ride_spot(t: Fighter) -> Vector2:
	return t.global_position + Vector2(RIDE_OFFSET.x * t.facing, RIDE_OFFSET.y)


func _process_ride(delta: float) -> void:
	var t := _ride
	# solta: tempo, alvo apanhou/morreu/pendurou, ele mesmo foi movido ou mudou de estado
	if not is_instance_valid(t) or t.state in [State.HITSTUN, State.RESPAWN, State.LEDGE, State.HELD] \
			or _ride_time <= 0.0 or state != State.AIR or global_position.distance_to(_ride_pos) > 4.0 \
			or controls.just_pressed("jump"):
		_release_ride()
		return
	_ride_time -= delta
	if t.controls.just_pressed("shield") or t.controls.just_pressed("attack"):
		_ride_time -= 0.3
	t.slow_factor = minf(t.slow_factor, RIDE_SLOW)
	facing = t.facing
	_ride_pos = _ride_spot(t)
	global_position = _ride_pos
	velocity = Vector2.ZERO
	_ride_tick += 1
	if _ride_tick % 20 == 0:
		t.add_damage(1.0)
		if move_fx != null:
			move_fx.event("carona", t)
	queue_redraw()


func _release_ride() -> void:
	var t := _ride
	_ride = null
	if state == State.AIR:
		var side := -1.0 if t == null or not is_instance_valid(t) else -float(t.facing)
		velocity = Vector2(side * 220.0, -420.0)


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	_ride = null
	_coffee = COFFEE_MAX   # derrama o café
	var ok := super(attacker, data, direction_sign)
	_hang = 0.0
	return ok


# --- Especiais ---

func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup and bubble_ready():
				_bubble = BolhaMoleza.spawn(self, global_position + Vector2(0, -20))
				_bubble_cd = BUBBLE_CD
		"special_up":
			if frame == attack.startup:
				velocity.y = -CLIMB_SPEED
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if frame == 1:
				_coffee = 0.0
			if _attack_in_air:
				if frame == attack.startup:
					attack_frame = attack.startup + attack.active   # no ar não tem café
				return
			if frame > attack.startup and frame <= attack.startup + attack.active:
				velocity.x = 0.0
				var sip := frame - attack.startup
				if (not controls.pressed("special") and sip > COFFEE_EVERY) or _coffee >= COFFEE_MAX:
					attack_frame = attack.startup + attack.active   # soltou / acabou o gole: levanta
				elif sip % COFFEE_EVERY == 0:
					_coffee += 1.0
					_heal(1.0)
					if move_fx != null:
						move_fx.event("cafe")


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_up" and not is_on_floor() and state == State.AIR:
		_hang = HANG_TIME
		if move_fx != null:
			move_fx.event("galho")


func _heal(amount: float) -> void:
	var h := minf(amount, damage_percent)
	if h > 0.0:
		add_damage(-h)


# --- Cochilo passivo ---

func _process_nap(delta: float) -> void:
	if state == State.IDLE and attack == null:
		_calm += delta
	else:
		_calm = 0.0
	if is_napping():
		_nap_tick += delta
		if _nap_tick >= 1.0:
			_nap_tick = 0.0
			if _nap_healed < NAP_MAX and damage_percent > 0.0:
				var h := minf(minf(1.0, NAP_MAX - _nap_healed), damage_percent)
				_nap_healed += h
				_heal(h)
			if move_fx != null:
				move_fx.event("cochilo")
	else:
		_nap_tick = 0.0


## Teste do som do Berrante (ou outro susto): acorda e larga o café.
func on_scared() -> void:
	_calm = 0.0
	_coffee = COFFEE_MAX


func respawn() -> void:
	super()
	_ride = null
	_hang = 0.0
	_calm = 0.0
	_nap_healed = 0.0
	_coffee = 0.0


func anim_override() -> Array:
	if _ride != null:
		return ["especial_lado", 3, true]
	if _hang > 0.0:
		return ["pendurado", 1.5]
	if is_napping():
		return ["descanso", 3.0]
	return []
