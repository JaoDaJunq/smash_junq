class_name Fighter
extends CharacterBody2D
## Lutador base. Movimento do GDD (andar, correr, pulo, pulo duplo, pulo curto,
## queda rápida, descer de plataforma, borda) e combate (golpes por dados,
## dano %, lançamento, atordoamento, pausa no impacto).
## Personagens estendem esta classe (scripts/characters/) e sobrescrevem os
## ganchos marcados como "Gancho para personagens".
## Valores em pixels e segundos; ajustar no playtest.

signal damage_changed(percent: float)

enum State { IDLE, WALK, RUN, AIR, LEDGE, ATTACK, LAG, HITSTUN, HELD }

const LAYER_STAGE := 1
const LAYER_PLATFORM := 2

@export var player_id := "p1"
@export var display_name := "Lutador"
@export var body_color := Color("4f8cff")
@export var facing := 1
@export var moveset: Moveset
## 100 = médio. Mais peso, menos lançamento com o mesmo dano.
@export var weight := 100.0

@export_group("Chão")
@export var walk_speed := 330.0
@export var run_speed := 560.0
@export var ground_accel := 3200.0
@export var ground_friction := 2800.0
@export_group("Ar")
@export var air_speed := 420.0
@export var air_accel := 1900.0
@export var gravity := 2600.0
@export var max_fall_speed := 1100.0
@export var fast_fall_speed := 1750.0
@export var jump_velocity := 980.0
@export var double_jump_velocity := 900.0
@export var short_hop_factor := 0.45
@export var short_hop_window := 0.1
@export var air_jumps := 1
@export_group("Borda")
@export var ledge_reach := Vector2(70, 50)
@export var ledge_regrab_delay := 0.6

const RADIUS := 28.0
const HEIGHT := 110.0
const RUN_DOUBLE_TAP := 0.25
const FLICK_FRAMES := 3
const DROP_THROUGH_TIME := 0.2
const STICK_THRESHOLD := 0.5

var state := State.IDLE
var spawn_point := Vector2.ZERO
var fast_falling := false
var jumps_left := 0
var damage_percent := 0.0
## Sem pulo nem golpe até pousar (depois de especial para cima, por exemplo).
var helpless := false

## Golpe em andamento.
var attack: AttackData = null
var attack_id := ""
var attack_frame := 0
var _attack_in_air := false
var _hit_targets: Array[Fighter] = []
var _lag_frames := 0

var _hitstun := 0.0
var _hitstop := 0
var held_by: Fighter = null
## Quem este lutador está segurando (agarrão ou golpe que agarra).
var holding: Fighter = null
const HOLD_OFFSET := Vector2(62, 0)
## Segundos sem poder ser atingido (ex.: depois de voltar de um KO).
var invincible_time := 0.0
## Quando false, quem controla a partida cuida de KO e retorno (ver T16).
var auto_respawn := true

var _jump_time := 0.0
var _drop_timer := 0.0
var _ledge: Node2D = null
var _ledge_cooldown := 0.0
var _last_tap_dir := 0
var _last_tap_time := -1.0
var _low_frames := 99
var _clock := 0.0


func _ready() -> void:
	add_to_group("fighters")
	collision_layer = 0
	collision_mask = LAYER_STAGE | LAYER_PLATFORM
	floor_snap_length = 8.0
	spawn_point = global_position
	jumps_left = air_jumps


func act(action: String) -> String:
	return "%s_%s" % [player_id, action]


func _physics_process(delta: float) -> void:
	_clock += delta
	invincible_time = maxf(invincible_time - delta, 0.0)
	_update_holding()
	if _hitstop > 0:
		_hitstop -= 1
		queue_redraw()
		return
	_ledge_cooldown = maxf(_ledge_cooldown - delta, 0.0)
	_update_drop_through(delta)
	var dir := Input.get_axis(act("left"), act("right"))
	var run_trigger := _detect_run_trigger(dir)

	match state:
		State.LEDGE:
			_process_ledge(dir)
		State.HELD:
			_process_held(delta)
		State.HITSTUN:
			_process_hitstun(delta)
		State.ATTACK:
			_process_attack(dir, delta)
		State.LAG:
			_process_lag(delta)
		_:
			if is_on_floor():
				_process_ground(dir, run_trigger, delta)
			else:
				_process_air(dir, delta)

	if state != State.LEDGE and state != State.HELD:
		var was_airborne := not is_on_floor()
		move_and_slide()
		_after_move(was_airborne)
	_check_out_of_bounds()
	queue_redraw()


# --- Chão e ar ---

func _process_ground(dir: float, run_trigger: bool, delta: float) -> void:
	fast_falling = false
	helpless = false
	jumps_left = air_jumps
	if _try_start_action():
		return
	if Input.is_action_just_pressed(act("jump")):
		_jump(jump_velocity)
		return
	if Input.is_action_just_pressed(act("down")) and _on_platform():
		_start_drop_through()
		state = State.AIR
		return
	if absf(dir) > 0.0:
		facing = signi(dir)
		if run_trigger or (state == State.RUN and signi(dir) == signi(velocity.x)):
			state = State.RUN
		elif state != State.RUN:
			state = State.WALK
		var target := (run_speed if state == State.RUN else walk_speed) * signf(dir)
		velocity.x = move_toward(velocity.x, target, ground_accel * delta)
	else:
		state = State.IDLE
		velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	velocity.y = 0.0


func _process_air(dir: float, delta: float) -> void:
	state = State.AIR
	_jump_time += delta
	if not helpless:
		if _try_start_action():
			return
		if Input.is_action_just_pressed(act("jump")) and jumps_left > 0:
			jumps_left -= 1
			_jump(double_jump_velocity)
			if absf(dir) > 0.0:
				facing = signi(dir)
				velocity.x = air_speed * signf(dir)
			return
	if Input.is_action_just_released(act("jump")) and velocity.y < 0.0 and _jump_time <= short_hop_window:
		velocity.y *= short_hop_factor
	if Input.is_action_just_pressed(act("down")) and velocity.y > -150.0:
		fast_falling = true
	_air_drift(dir, delta)
	_apply_gravity(delta)
	if velocity.y >= 0.0:
		_try_grab_ledge()


func _air_drift(dir: float, delta: float) -> void:
	if absf(dir) > 0.0:
		velocity.x = move_toward(velocity.x, air_speed * signf(dir), air_accel * delta)


func _apply_gravity(delta: float) -> void:
	var limit := fast_fall_speed if fast_falling else max_fall_speed
	velocity.y = minf(velocity.y + gravity * delta, limit)
	if fast_falling:
		velocity.y = fast_fall_speed


func _jump(speed: float) -> void:
	state = State.AIR
	fast_falling = false
	velocity.y = -speed
	_jump_time = 0.0


func _after_move(was_airborne: bool) -> void:
	if not is_on_floor():
		return
	if state == State.AIR:
		state = State.IDLE
		fast_falling = false
		helpless = false
	elif state == State.ATTACK and _attack_in_air and was_airborne:
		_land_during_attack()


# --- Golpes ---

## Lê Ataque/Especial e a direção e começa o golpe certo. Retorna true se começou.
func _try_start_action() -> bool:
	var special := Input.is_action_just_pressed(act("special"))
	if not special and not Input.is_action_just_pressed(act("attack")):
		return false
	var stick := _stick_direction()
	if special:
		var kind := "neutral"
		if stick == "up" or stick == "down":
			kind = stick
		elif stick == "side":
			kind = "side"
			facing = signi(Input.get_axis(act("left"), act("right")))
		start_special(kind)
		return true
	var move_id := ""
	if is_on_floor():
		match stick:
			"up": move_id = "utilt"
			"down": move_id = "dtilt"
			"side":
				facing = signi(Input.get_axis(act("left"), act("right")))
				move_id = "ftilt"
			_: move_id = "jab"
	else:
		match stick:
			"up": move_id = "uair"
			"down": move_id = "dair"
			"side":
				var x := signi(Input.get_axis(act("left"), act("right")))
				move_id = "fair" if x == facing else "bair"
			_: move_id = "nair"
	return start_attack(move_id)


## "up", "down", "side" ou "neutral", conforme a alavanca no momento.
func _stick_direction() -> String:
	var x := Input.get_axis(act("left"), act("right"))
	var y := Input.get_axis(act("up"), act("down"))
	if absf(y) >= STICK_THRESHOLD and absf(y) >= absf(x):
		return "down" if y > 0.0 else "up"
	if absf(x) >= STICK_THRESHOLD:
		return "side"
	return "neutral"


## Começa um golpe do moveset pelo nome (ex.: "jab", "fair", "special_up").
func start_attack(move_id: String) -> bool:
	if moveset == null:
		return false
	var data := moveset.move(move_id)
	if data == null:
		return false
	attack = data
	attack_id = move_id
	attack_frame = 0
	_attack_in_air = not is_on_floor()
	_hit_targets.clear()
	fast_falling = false
	state = State.ATTACK
	return true


## Gancho para personagens: especial neutro/lateral/para cima/para baixo.
## O padrão só toca o golpe de dados do moveset. kind: "neutral", "side", "up", "down".
func start_special(kind: String) -> void:
	start_attack("special_" + kind)


## Gancho para personagens: chamado a cada quadro do golpe, depois do quadro avançar.
## Use para efeitos próprios (soltar projétil num quadro, teletransporte, etc.).
func _on_attack_frame(_move_id: String, _frame: int) -> void:
	pass


## Gancho para personagens: chamado quando o golpe termina ou é interrompido.
func _on_attack_end(_move_id: String) -> void:
	pass


func _process_attack(dir: float, delta: float) -> void:
	attack_frame += 1
	if attack_frame == 1 and attack.self_velocity != Vector2.ZERO:
		if attack.self_velocity.x != 0.0:
			velocity.x = attack.self_velocity.x * facing
		if attack.self_velocity.y != 0.0:
			velocity.y = attack.self_velocity.y
			if velocity.y < 0.0:
				_attack_in_air = true  # golpe que tira do chão segue com física de ar
	_on_attack_frame(attack_id, attack_frame)
	if state != State.ATTACK:
		return  # o gancho pode ter encerrado o golpe
	if attack.is_active(attack_frame):
		_check_hits()
	if is_on_floor() and not _attack_in_air:
		velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
		velocity.y = 0.0
	else:
		_air_drift(dir, delta)
		_apply_gravity(delta)
	if attack_frame >= attack.total_frames():
		_end_attack()


func _end_attack() -> void:
	var finished := attack
	var finished_id := attack_id
	attack = null
	attack_id = ""
	if finished and finished.helpless_after and not is_on_floor():
		helpless = true
	state = State.IDLE if is_on_floor() else State.AIR
	_on_attack_end(finished_id)


func _land_during_attack() -> void:
	var lag := attack.landing_lag
	var finished_id := attack_id
	attack = null
	attack_id = ""
	helpless = false
	_on_attack_end(finished_id)
	if lag > 0:
		_lag_frames = lag
		state = State.LAG
	else:
		state = State.IDLE


func _process_lag(delta: float) -> void:
	_lag_frames -= 1
	velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	if not is_on_floor():
		_apply_gravity(delta)
	if _lag_frames <= 0:
		state = State.IDLE if is_on_floor() else State.AIR


## Centro da área de acerto do golpe atual, em coordenadas do mundo.
func hitbox_center(data: AttackData) -> Vector2:
	return global_position + Vector2(data.hitbox_offset.x * facing, data.hitbox_offset.y)


func hurtbox() -> Rect2:
	return Rect2(global_position + Vector2(-RADIUS, -HEIGHT * 0.5), Vector2(RADIUS * 2.0, HEIGHT))


func _check_hits() -> void:
	var center := hitbox_center(attack)
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == self or target in _hit_targets or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(center, attack.hitbox_radius, target.hurtbox()):
			_hit_targets.append(target)
			var move_id := attack_id
			if target.receive_hit(self, attack, facing):
				_on_hit_landed(target, move_id)
			if state != State.ATTACK:
				return  # o gancho pode ter encerrado o golpe


## Gancho para personagens: o golpe atual acertou alguém (ex.: golpe que agarra).
func _on_hit_landed(_target: Fighter, _move_id: String) -> void:
	pass


## Gancho para personagens: pode ser atingido agora?
func can_be_hit() -> bool:
	if invincible_time > 0.0:
		return false
	return state != State.HELD or held_by == null


## Aplica um golpe neste lutador. direction_sign: para que lado ele é lançado.
## Gancho para personagens (ex.: contra-ataque). Retorna true se o golpe entrou.
func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	release_hold()
	if attack != null:
		_on_attack_end(attack_id)
	attack = null
	attack_id = ""
	_ledge = null
	held_by = null
	fast_falling = false
	helpless = false
	damage_percent += data.damage
	var speed := Combat.launch_speed(data, damage_percent, weight)
	velocity = Combat.launch_vector(data, speed, direction_sign)
	if is_on_floor() and velocity.y > 0.0:
		velocity.y = -velocity.y * 0.6
	_hitstun = Combat.hitstun_time(speed)
	state = State.HITSTUN
	var stop := Combat.hitstop_frames(data.damage)
	_hitstop = stop
	if attacker is Fighter:
		attacker._hitstop = stop
	get_tree().call_group("fight_camera", "shake", speed)
	damage_changed.emit(damage_percent)
	return true


func _process_hitstun(delta: float) -> void:
	_hitstun -= delta
	velocity.x = move_toward(velocity.x, 0.0, Combat.LAUNCH_DECAY * delta)
	if not is_on_floor():
		velocity.y = minf(velocity.y + gravity * delta, max_fall_speed)
	if _hitstun <= 0.0:
		state = State.IDLE if is_on_floor() else State.AIR
		jumps_left = maxi(jumps_left, 1) if air_jumps > 0 else 0


# --- Ser segurado (agarrão e golpes que agarram) ---

## Prende este lutador a quem o segurou. Quem segura move a posição dele.
func start_held(holder: Fighter) -> void:
	if attack != null:
		_on_attack_end(attack_id)
	attack = null
	attack_id = ""
	_ledge = null
	held_by = holder
	velocity = Vector2.ZERO
	state = State.HELD


func release_held() -> void:
	held_by = null
	if state == State.HELD:
		state = State.AIR


## Segura o alvo à frente deste lutador até soltar ou arremessar.
func hold(target: Fighter) -> void:
	release_hold()
	holding = target
	target.start_held(self)
	_update_holding()


func release_hold() -> void:
	if holding != null and is_instance_valid(holding) and holding.held_by == self:
		holding.release_held()
	holding = null


## Solta quem está segurando e aplica o arremesso (usa a fórmula de lançamento).
func throw_held(data: AttackData, direction_sign: int) -> void:
	var target := holding
	release_hold()
	if target != null and is_instance_valid(target):
		target.receive_hit(self, data, direction_sign)


func _update_holding() -> void:
	if holding == null:
		return
	if not is_instance_valid(holding) or holding.held_by != self:
		holding = null
		return
	holding.global_position = global_position + Vector2(HOLD_OFFSET.x * facing, HOLD_OFFSET.y)


func _process_held(_delta: float) -> void:
	if held_by == null or not is_instance_valid(held_by):
		release_held()


# --- Plataformas atravessáveis ---

func _on_platform() -> bool:
	for i in get_slide_collision_count():
		var body := get_slide_collision(i).get_collider()
		if body is CollisionObject2D and body.collision_layer & LAYER_PLATFORM:
			return true
	return false


func _start_drop_through() -> void:
	_drop_timer = DROP_THROUGH_TIME
	collision_mask = LAYER_STAGE
	position.y += 2.0


func _update_drop_through(delta: float) -> void:
	if _drop_timer > 0.0:
		_drop_timer -= delta
		if _drop_timer <= 0.0:
			collision_mask = LAYER_STAGE | LAYER_PLATFORM


# --- Borda ---

func _try_grab_ledge() -> void:
	if _ledge_cooldown > 0.0:
		return
	var hand := global_position + Vector2(0, -HEIGHT * 0.35)
	for ledge in get_tree().get_nodes_in_group("ledges"):
		var side: int = ledge.get_meta("side", 1)
		var offset: Vector2 = hand - ledge.global_position
		var outside := offset.x * side > -RADIUS * 0.5
		if outside and absf(offset.x) <= ledge_reach.x and absf(offset.y) <= ledge_reach.y and not _ledge_taken(ledge):
			_grab_ledge(ledge, side)
			return


func _ledge_taken(ledge: Node2D) -> bool:
	for f in get_tree().get_nodes_in_group("fighters"):
		if f != self and f._ledge == ledge:
			return true
	return false


func _grab_ledge(ledge: Node2D, side: int) -> void:
	_ledge = ledge
	state = State.LEDGE
	fast_falling = false
	helpless = false
	velocity = Vector2.ZERO
	facing = -side
	jumps_left = air_jumps
	global_position = ledge.global_position + Vector2(side * (RADIUS + 2.0), HEIGHT * 0.4)


func _process_ledge(dir: float) -> void:
	var side: int = _ledge.get_meta("side", 1)
	if Input.is_action_just_pressed(act("up")):
		global_position = _ledge.global_position + Vector2(-side * (RADIUS + 24.0), -HEIGHT * 0.5 - 1.0)
		_release_ledge(State.IDLE)
	elif Input.is_action_just_pressed(act("jump")):
		_release_ledge(State.AIR)
		_jump(jump_velocity)
	elif Input.is_action_just_pressed(act("down")) or (absf(dir) > 0.0 and signi(dir) == side):
		_release_ledge(State.AIR)


func _release_ledge(next_state: State) -> void:
	_ledge = null
	_ledge_cooldown = ledge_regrab_delay
	state = next_state


# --- Corrida: toque duplo ou alavanca empurrada rápido ---

func _detect_run_trigger(dir: float) -> bool:
	var triggered := false
	var tap_dir := 0
	if Input.is_action_just_pressed(act("left")):
		tap_dir = -1
	elif Input.is_action_just_pressed(act("right")):
		tap_dir = 1
	if tap_dir != 0:
		if tap_dir == _last_tap_dir and _clock - _last_tap_time <= RUN_DOUBLE_TAP:
			triggered = true
		_last_tap_dir = tap_dir
		_last_tap_time = _clock
	# Alavanca: sair do centro até o fim do curso em poucos quadros conta como corrida.
	# No teclado a tecla vai direto a 1.0, então ali só o toque duplo vale.
	if absf(dir) < 0.3:
		_low_frames = 0
	else:
		_low_frames = mini(_low_frames + 1, 99)
		if absf(dir) >= 0.9 and _low_frames <= FLICK_FRAMES and not _keyboard_held():
			triggered = true
	return triggered


func _keyboard_held() -> bool:
	for action in [act("left"), act("right")]:
		for e in InputMap.action_get_events(action):
			if e is InputEventKey and Input.is_physical_key_pressed(e.physical_keycode):
				return true
	return false


# --- Provisório até a T16 (zonas de KO): volta ao ponto inicial ao cair da arena ---

func _check_out_of_bounds() -> void:
	if auto_respawn and absf(global_position.x) > 2200.0 or global_position.y > 1400.0 or global_position.y < -1600.0:
		respawn()


func respawn() -> void:
	release_hold()
	if attack != null:
		_on_attack_end(attack_id)
	global_position = spawn_point
	velocity = Vector2.ZERO
	state = State.AIR
	attack = null
	attack_id = ""
	_ledge = null
	held_by = null
	fast_falling = false
	helpless = false
	jumps_left = air_jumps
	damage_percent = 0.0
	damage_changed.emit(damage_percent)


# --- Visual greybox ---

func _draw() -> void:
	var rect := Rect2(-RADIUS, -HEIGHT * 0.5, RADIUS * 2.0, HEIGHT)
	var color := body_color
	if state == State.HITSTUN and int(_clock * 20.0) % 2 == 0:
		color = color.lightened(0.5)
	elif helpless:
		color = color.darkened(0.4)
	if invincible_time > 0.0:
		color.a = 0.45 if int(_clock * 12.0) % 2 == 0 else 0.8
	draw_rect(rect, color)
	var eye := Vector2(facing * RADIUS * 0.45, -HEIGHT * 0.28)
	draw_circle(eye, 6.0, Color.WHITE)
	draw_circle(eye + Vector2(facing * 2.0, 0), 3.0, Color.BLACK)
	if fast_falling:
		draw_line(Vector2(-RADIUS, -HEIGHT * 0.5 - 8), Vector2(RADIUS, -HEIGHT * 0.5 - 8), Color.WHITE, 3.0)
	if attack != null and attack.is_active(attack_frame):
		var local := Vector2(attack.hitbox_offset.x * facing, attack.hitbox_offset.y)
		draw_circle(local, attack.hitbox_radius, Color(1, 0.2, 0.2, 0.55))
	var font := ThemeDB.fallback_font
	var label := "%s %s %d%%" % [player_id.to_upper(), attack_id if attack else State.keys()[state], roundi(damage_percent)]
	draw_string(font, Vector2(-RADIUS * 3.0, -HEIGHT * 0.5 - 16), label, HORIZONTAL_ALIGNMENT_CENTER, RADIUS * 6.0, 18, Color.WHITE)
