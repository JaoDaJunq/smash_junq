class_name Fighter
extends CharacterBody2D
## Lutador greybox: movimento do GDD (andar, correr, pulo, pulo duplo, pulo curto,
## queda rápida, descer de plataforma atravessável, agarrar a borda e subir).
## Valores em pixels e segundos; ajustar no playtest.

enum State { IDLE, WALK, RUN, AIR, LEDGE }

const LAYER_STAGE := 1
const LAYER_PLATFORM := 2

@export var player_id := "p1"
@export var body_color := Color("4f8cff")
@export var facing := 1

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

var state := State.IDLE
var spawn_point := Vector2.ZERO
var fast_falling := false
var jumps_left := 0
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
	_ledge_cooldown = maxf(_ledge_cooldown - delta, 0.0)
	_update_drop_through(delta)
	var dir := Input.get_axis(act("left"), act("right"))
	var run_trigger := _detect_run_trigger(dir)

	if state == State.LEDGE:
		_process_ledge(dir)
	elif is_on_floor():
		_process_ground(dir, run_trigger, delta)
	else:
		_process_air(dir, delta)

	if state != State.LEDGE:
		move_and_slide()
		_after_move()
	_check_out_of_bounds()
	queue_redraw()


func _process_ground(dir: float, run_trigger: bool, delta: float) -> void:
	fast_falling = false
	jumps_left = air_jumps
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
	if absf(dir) > 0.0:
		velocity.x = move_toward(velocity.x, air_speed * signf(dir), air_accel * delta)
	var limit := fast_fall_speed if fast_falling else max_fall_speed
	velocity.y = minf(velocity.y + gravity * delta, limit)
	if fast_falling:
		velocity.y = fast_fall_speed
	if velocity.y >= 0.0:
		_try_grab_ledge()


func _jump(speed: float) -> void:
	state = State.AIR
	fast_falling = false
	velocity.y = -speed
	_jump_time = 0.0


func _after_move() -> void:
	if is_on_floor() and state == State.AIR:
		state = State.IDLE
		fast_falling = false


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
	if absf(global_position.x) > 2200.0 or global_position.y > 1400.0 or global_position.y < -1600.0:
		respawn()


func respawn() -> void:
	global_position = spawn_point
	velocity = Vector2.ZERO
	state = State.AIR
	_ledge = null
	fast_falling = false
	jumps_left = air_jumps


# --- Visual greybox ---

func _draw() -> void:
	var rect := Rect2(-RADIUS, -HEIGHT * 0.5, RADIUS * 2.0, HEIGHT)
	draw_rect(rect, body_color)
	var eye := Vector2(facing * RADIUS * 0.45, -HEIGHT * 0.28)
	draw_circle(eye, 6.0, Color.WHITE)
	draw_circle(eye + Vector2(facing * 2.0, 0), 3.0, Color.BLACK)
	if fast_falling:
		draw_line(Vector2(-RADIUS, -HEIGHT * 0.5 - 8), Vector2(RADIUS, -HEIGHT * 0.5 - 8), Color.WHITE, 3.0)
	var font := ThemeDB.fallback_font
	var label := "%s %s" % [player_id.to_upper(), State.keys()[state]]
	draw_string(font, Vector2(-RADIUS * 2.0, -HEIGHT * 0.5 - 16), label, HORIZONTAL_ALIGNMENT_CENTER, RADIUS * 4.0, 18, Color.WHITE)
