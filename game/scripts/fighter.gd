class_name Fighter
extends CharacterBody2D
## Lutador base. Movimento do GDD (andar, correr, pulo, pulo duplo, pulo curto,
## queda rápida, descer de plataforma, borda) e combate (golpes por dados,
## dano %, lançamento, atordoamento, pausa no impacto).
## Personagens estendem esta classe (scripts/characters/) e sobrescrevem os
## ganchos marcados como "Gancho para personagens".
## Valores em pixels e segundos; ajustar no playtest.

## Escapou de um combo com a esquiva.
signal escaped
signal damage_changed(percent: float)
## Avisos para efeitos visuais e sons (não mudam regras do jogo).
signal hit_taken(attacker: Node2D, data: AttackData, launch: Vector2)
signal blocked(data: AttackData)
signal shield_broken
signal jumped(in_air: bool)
signal landed(fall_speed: float)
signal dashed
signal respawn_platform_left

enum State { IDLE, WALK, RUN, AIR, LEDGE, ATTACK, LAG, HITSTUN, HELD, SHIELD, SHIELD_BREAK, DODGE, GRAB, HOLDING, RESPAWN }

const LAYER_STAGE := 1
const LAYER_PLATFORM := 2

@export var player_id := "p1"
@export var display_name := "Lutador"
@export var body_color := Color("4f8cff")
@export var facing := 1
@export var moveset: Moveset
## 100 = médio. Mais peso, menos lançamento com o mesmo dano.
@export var weight := 100.0
## Texto de depuração em cima do lutador (estado e dano). A partida real desliga.
@export var show_debug_label := true

@export_group("Chão")
@export var walk_speed := 330.0
@export var run_speed := 560.0
@export var ground_accel := 3200.0
@export var ground_friction := 2800.0
@export_group("Ar")
@export var air_speed := 420.0
@export var air_accel := 1900.0
@export var air_friction := 700.0
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
## Segundos máximos pendurado na borda; depois solta sozinho.
@export var ledge_max_time := 4.0
@export_group("Defesa")
@export var shield_max := 50.0
## Desgaste por segundo segurando o escudo.
@export var shield_drain := 10.0
@export var shield_regen := 7.0
@export var shield_break_time := 2.5
@export var roll_speed := 700.0
@export var roll_frames := 24
## Quadros (início, fim) sem poder ser atingido.
@export var roll_invuln := Vector2i(2, 16)  # intocável quase na hora (estilo Brawlhalla)
@export var air_dodge_speed := 650.0
@export var air_dodge_frames := 30
@export var air_dodge_invuln := Vector2i(2, 20)
@export_group("Agarrão")
@export var grab_reach := Vector2(52, -10)
@export var grab_radius := 30.0
@export var grab_startup := 6
@export var grab_active := 2
@export var grab_whiff_recovery := 26
@export var pummel_damage := 1.5
## Segundos segurando antes de o adversário se soltar sozinho (mais dano = mais tempo).
@export var grab_hold_base := 1.0

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
## Sequência do ataque básico: jab -> jab2 (outra mão) -> jab3 (finalização).
## Apertar Ataque de novo durante o golpe (ou logo depois) puxa o próximo.
const JAB_CHAIN := {"jab": "jab2", "jab2": "jab3"}
const JAB_LINK_FRAMES := 14   # janela depois do golpe para emendar o próximo
var _jab_queued := false
var _jab_last := ""
var _jab_last_frame := -999
var _jab_cache := {}
var attack_frame := 0
var _attack_in_air := false
var _hit_targets: Array[Fighter] = []
var _lag_frames := 0

var _hitstun := 0.0
var _hitstun_total := 0.0
## Escape de combo: no meio do atordoamento, Defesa faz uma esquiva (com espera).
@export var escape_after := 0.35        # fração do atordoamento que precisa passar
@export var escape_cooldown := 2.0      # segundos até poder escapar de novo
var _escape_wait := 0.0
var _shield_was_down := false
var _shield_tap := false   # Defesa acabou de ser apertada (neste quadro de física)
var _hitstop := 0
var _launch := Vector2.ZERO  # parte do movimento que vem do golpe recebido
var _fall := 0.0             # queda acumulada durante o atordoamento
var _fall_speed_before_move := 0.0
var _respawn_timer := 0.0
var held_by: Fighter = null
## Quem este lutador está segurando (agarrão ou golpe que agarra).
var holding: Fighter = null
const HOLD_OFFSET := Vector2(62, 0)
## Segundos sem poder ser atingido (ex.: depois de voltar de um KO).
var invincible_time := 0.0
## Quando false, quem controla a partida cuida de KO e retorno (ver T16).
var auto_respawn := true

var shield_hp := 50.0
## true quando a arte do personagem (PixelSprite ou CutoutRig) está desenhando o corpo.
var has_art := false
var _shield_stun := 0
var _break_timer := 0.0
var _dodge_frame := 0
var _dodge_in_air := false
var _dodge_directional := false
var _air_dodge_used := false
var _grab_frame := 0
var _grab_timer := 0.0
var _pummel_cooldown := 0
var _default_throws := {}

var _jump_time := 0.0
var _drop_timer := 0.0
var _ledge: Node2D = null
var _ledge_cooldown := 0.0
var _ledge_time := 0.0
var _last_tap_dir := 0
var _last_tap_time := -1.0
var _low_frames := 99
var _clock := 0.0

## De onde vêm os botões: jogador (mapa p1_/p2_) ou CPU (ver set_cpu).
var controls: FighterControls = null
## Cérebro da CPU; null quando uma pessoa controla o lutador.
var brain: CpuBrain = null


func _ready() -> void:
	add_to_group("fighters")
	if controls == null:
		controls = FighterControls.new(player_id)
	collision_layer = 0
	collision_mask = LAYER_STAGE | LAYER_PLATFORM
	floor_snap_length = 8.0
	spawn_point = global_position
	jumps_left = air_jumps
	shield_hp = shield_max


func act(action: String) -> String:
	return "%s_%s" % [player_id, action]


## Passa o controle deste lutador para a CPU (T20).
func set_cpu(new_brain: CpuBrain) -> void:
	brain = new_brain
	controls = CpuControls.new(player_id)


func _physics_process(delta: float) -> void:
	_clock += delta
	if brain != null:
		controls.begin_frame()
		brain.think(self, delta)
	invincible_time = maxf(invincible_time - delta, 0.0)
	_escape_wait = maxf(_escape_wait - delta, 0.0)
	var shield_down := controls.pressed("shield")
	_shield_tap = shield_down and not _shield_was_down
	_shield_was_down = shield_down
	_update_holding()
	# Guarda o próximo toque da sequência do ataque básico, mesmo durante a pausa de impacto.
	if state == State.ATTACK and JAB_CHAIN.has(attack_id) and attack_frame >= 1 			and controls.just_pressed("attack") and _stick_direction() == "neutral":
		_jab_queued = true
	if _hitstop > 0:
		_hitstop -= 1
		# Congelado no impacto, mas em cima de plataforma que se move acompanha ela
		# (senão a vitória-régia atravessa os pés e o lutador cai).
		if is_on_floor() and state != State.LEDGE and state != State.HELD:
			var keep := velocity
			velocity = Vector2.ZERO
			move_and_slide()
			velocity = keep
		queue_redraw()
		return
	_ledge_cooldown = maxf(_ledge_cooldown - delta, 0.0)
	if state != State.SHIELD and state != State.SHIELD_BREAK:
		shield_hp = minf(shield_hp + shield_regen * delta, shield_max)
	_update_drop_through(delta)
	var dir := controls.axis("left", "right")
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
		State.SHIELD:
			_process_shield(delta)
		State.SHIELD_BREAK:
			_process_shield_break(delta)
		State.DODGE:
			_process_dodge(delta)
		State.GRAB:
			_process_grab(delta)
		State.HOLDING:
			_process_holding(delta)
		State.RESPAWN:
			_process_respawn(delta, dir)
		_:
			if is_on_floor():
				_process_ground(dir, run_trigger, delta)
			else:
				_process_air(dir, delta)

	if state != State.LEDGE and state != State.HELD and state != State.RESPAWN:
		var was_airborne := not is_on_floor()
		_fall_speed_before_move = velocity.y
		if state == State.ATTACK and is_on_floor() and attack_id.begins_with("jab"):
			_stop_at_edge(delta)
		move_and_slide()
		_after_move(was_airborne)
		_update_holding()  # quem está seguro acompanha a posição já atualizada
	_check_out_of_bounds()
	queue_redraw()


# --- Chão e ar ---

func _process_ground(dir: float, run_trigger: bool, delta: float) -> void:
	fast_falling = false
	helpless = false
	_air_dodge_used = false
	jumps_left = air_jumps
	if controls.just_pressed("grab") or (controls.pressed("shield") and controls.just_pressed("attack")):
		start_grab()
		return
	if controls.pressed("shield"):
		# Defesa (Shift): parado levanta o escudo; andando ou correndo, esquiva
		# rápida e intocável para o lado do movimento (como no Brawlhalla).
		if _shield_tap and absf(dir) > 0.0:
			_start_roll(int(signf(dir)))
		else:
			_enter_shield()
		return
	if _try_start_action():
		return
	if controls.just_pressed("jump"):
		_jump(jump_velocity)
		return
	if controls.just_pressed("down") and _on_platform():
		_start_drop_through()
		state = State.AIR
		return
	if absf(dir) > 0.0:
		facing = int(signf(dir))
		if run_trigger or (state == State.RUN and signf(dir) == signf(velocity.x)):
			if state != State.RUN:
				dashed.emit()
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
		if controls.just_pressed("shield") and not _air_dodge_used:
			_start_air_dodge()
			return
		if _try_start_action():
			return
		if controls.just_pressed("jump") and jumps_left > 0:
			jumps_left -= 1
			_jump(double_jump_velocity)
			if absf(dir) > 0.0:
				facing = int(signf(dir))
				velocity.x = air_speed * signf(dir)
			return
	if controls.just_released("jump") and velocity.y < 0.0 and _jump_time <= short_hop_window:
		velocity.y *= short_hop_factor
	if controls.just_pressed("down") and velocity.y > -150.0:
		fast_falling = true
	_air_drift(dir, delta)
	_apply_gravity(delta)
	if velocity.y >= 0.0:
		_try_grab_ledge()


func _air_drift(dir: float, delta: float) -> void:
	if absf(dir) > 0.0:
		velocity.x = move_toward(velocity.x, air_speed * signf(dir), air_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, air_friction * delta)  # atrito do ar sem direção


func _apply_gravity(delta: float) -> void:
	var limit := fast_fall_speed if fast_falling else max_fall_speed
	velocity.y = minf(velocity.y + gravity * delta, limit)
	if fast_falling:
		velocity.y = fast_fall_speed


func _jump(speed: float) -> void:
	jumped.emit(not is_on_floor())
	state = State.AIR
	fast_falling = false
	velocity.y = -speed
	_jump_time = 0.0


func _after_move(was_airborne: bool) -> void:
	if not is_on_floor():
		return
	if was_airborne:
		landed.emit(_fall_speed_before_move)
	if state == State.AIR:
		state = State.IDLE
		fast_falling = false
		helpless = false
	elif state == State.ATTACK and _attack_in_air and was_airborne:
		_land_during_attack()
	elif state == State.DODGE and _dodge_in_air and was_airborne:
		_lag_frames = 10
		state = State.LAG


# --- Golpes ---

## Lê Ataque/Especial e a direção e começa o golpe certo. Retorna true se começou.
func _try_start_action() -> bool:
	var special := controls.just_pressed("special")
	if not special and not controls.just_pressed("attack"):
		return false
	var stick := _stick_direction()
	if special:
		var kind := "neutral"
		if stick == "up" or stick == "down":
			kind = stick
		elif stick == "side":
			kind = "side"
			facing = int(signf(controls.axis("left", "right")))
		start_special(kind)
		return true
	var move_id := ""
	if is_on_floor():
		match stick:
			"up": move_id = "utilt"
			"down": move_id = "dtilt"
			"side":
				facing = int(signf(controls.axis("left", "right")))
				move_id = "ftilt"
			_: move_id = _next_jab()
	else:
		match stick:
			"up": move_id = "uair"
			"down": move_id = "dair"
			"side":
				var x := int(signf(controls.axis("left", "right")))
				move_id = "fair" if x == facing else "bair"
			_: move_id = "nair"
	return start_attack(move_id)


## "up", "down", "side" ou "neutral", conforme a alavanca no momento.
func _stick_direction() -> String:
	var x := controls.axis("left", "right")
	var y := controls.axis("up", "down")
	if absf(y) >= STICK_THRESHOLD and absf(y) >= absf(x):
		return "down" if y > 0.0 else "up"
	if absf(x) >= STICK_THRESHOLD:
		return "side"
	return "neutral"


## Próximo golpe da sequência do ataque básico (ou "jab" se a janela passou).
func _next_jab() -> String:
	if Engine.get_physics_frames() - _jab_last_frame <= JAB_LINK_FRAMES and JAB_CHAIN.has(_jab_last):
		return JAB_CHAIN[_jab_last]
	return "jab"


## Dados do 2º e 3º golpes da sequência, derivados do jab do moveset.
func _combo_jab(move_id: String) -> AttackData:
	if moveset == null or moveset.jab == null:
		return null
	if _jab_cache.has(move_id):
		return _jab_cache[move_id]
	var d := moveset.jab.duplicate() as AttackData
	if move_id == "jab2":
		d.hitbox_offset.x += 8.0
		d.base_knockback *= 0.6   # empurra pouco e baixo: o terceiro ainda alcança
		d.angle = 15.0
		d.self_velocity = Vector2(200.0, 0.0)  # passinho: acompanha quem foi empurrado
	else:  # jab3: finalização mais lenta que lança
		d.startup += 3
		d.active += 1
		d.recovery += 10
		d.damage *= 1.8
		d.base_knockback *= 1.6
		d.knockback_growth = maxf(d.knockback_growth * 3.0, 4.5)
		d.angle = 38.0
		d.hitbox_offset.x += 18.0
		d.hitbox_radius *= 1.3
		d.self_velocity = Vector2(320.0, 0.0)
	_jab_cache[move_id] = d
	return d


## Carga do golpe carregável (0..1) enquanto o botão está seguro; -1 sem carga.
## Os lutadores com golpe carregável sobrescrevem.
func charge_ratio() -> float:
	return -1.0


## Começa um golpe do moveset pelo nome (ex.: "jab", "fair", "special_up").
func start_attack(move_id: String) -> bool:
	if moveset == null:
		return false
	var data := _combo_jab(move_id) if move_id in ["jab2", "jab3"] else moveset.move(move_id)
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
	if JAB_CHAIN.has(attack_id):
		if _jab_queued and attack_frame >= attack.startup + attack.active + 2:
			_jab_queued = false
			start_attack(JAB_CHAIN[attack_id])
			return
	if attack.is_active(attack_frame):
		_check_hits()
		if state != State.ATTACK or attack == null:
			return  # um contra-ataque pode ter interrompido o golpe
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
	_jab_queued = false
	if finished_id.begins_with("jab"):
		_jab_last = finished_id
		_jab_last_frame = Engine.get_physics_frames()
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
	if invincible_time > 0.0 or _is_intangible():
		return false
	return state != State.HELD or held_by == null


func _is_intangible() -> bool:
	if state != State.DODGE:
		return false
	var window := air_dodge_invuln if _dodge_in_air else roll_invuln
	return _dodge_frame >= window.x and _dodge_frame <= window.y


## Aplica um golpe neste lutador. direction_sign: para que lado ele é lançado.
## Gancho para personagens (ex.: contra-ataque). Retorna true se o golpe entrou.
func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if state == State.SHIELD:
		_block_hit(attacker, data, direction_sign)
		return false
	release_hold()
	_air_dodge_used = false
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
	_launch = Combat.launch_vector(data, speed, direction_sign)
	if is_on_floor() and _launch.y > 0.0:
		_launch.y = -_launch.y * 0.6
	_fall = 0.0
	velocity = _launch
	_hitstun = Combat.hitstun_time(speed)
	_hitstun_total = _hitstun
	state = State.HITSTUN
	var stop := Combat.hitstop_frames(data.damage)
	_hitstop = stop
	if attacker is Fighter:
		attacker._hitstop = stop
	get_tree().call_group("fight_camera", "shake", speed)
	damage_changed.emit(damage_percent)
	hit_taken.emit(attacker, data, _launch)
	return true


## Pode escapar do combo agora? (parte do atordoamento já passou e a espera acabou)
func can_escape() -> bool:
	return state == State.HITSTUN and _escape_wait <= 0.0 		and _hitstun <= _hitstun_total * (1.0 - escape_after)


func _process_hitstun(delta: float) -> void:
	_hitstun -= delta
	if _shield_tap and can_escape():
		_escape_wait = escape_cooldown
		_hitstun = 0.0
		_launch = Vector2.ZERO
		_fall = 0.0
		if is_on_floor():
			var d := controls.axis("left", "right")
			_start_roll(int(signf(d)) if absf(d) > 0.0 else -facing)
		else:
			_start_air_dodge()
		escaped.emit()
		return
	# Lançamento e queda separados: a velocidade do golpe perde força aos poucos e
	# a gravidade (mais fraca durante o atordoamento) puxa para baixo por conta própria.
	_launch = _launch.move_toward(Vector2.ZERO, Combat.LAUNCH_DECAY * delta)
	if is_on_floor():
		_fall = 0.0
		_launch.y = minf(_launch.y, 0.0)
	else:
		_fall = minf(_fall + gravity * Combat.HITSTUN_GRAVITY_SCALE * delta, max_fall_speed)
	velocity = _launch + Vector2(0.0, _fall)
	if _hitstun <= 0.0:
		state = State.IDLE if is_on_floor() else State.AIR
		jumps_left = maxi(jumps_left, 1) if air_jumps > 0 else 0


# --- Plataforma de retorno (depois de um KO) ---

## Segura o lutador parado numa plataforma no alto até ele agir ou o tempo acabar.
func start_respawn_hold(max_time := 3.0) -> void:
	state = State.RESPAWN
	velocity = Vector2.ZERO
	_respawn_timer = max_time


func _process_respawn(delta: float, dir: float) -> void:
	velocity = Vector2.ZERO
	_respawn_timer -= delta
	var acted := absf(dir) > 0.0
	for action in ["jump", "attack", "special", "shield", "down", "grab"]:
		if controls.pressed(action):
			acted = true
	if acted or _respawn_timer <= 0.0:
		state = State.AIR
		respawn_platform_left.emit()
		_process_air(dir, delta)  # o botão que tirou da plataforma já vale neste quadro


# --- Escudo e esquivas ---

func _enter_shield() -> void:
	state = State.SHIELD
	_shield_stun = 0


func _process_shield(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	velocity.y = 0.0
	if not is_on_floor():
		state = State.AIR
		return
	if _shield_stun > 0:
		_shield_stun -= 1
		return
	shield_hp -= shield_drain * delta
	if shield_hp <= 0.0:
		_break_shield()
		return
	if controls.just_pressed("jump"):
		_jump(jump_velocity)
		return
	if controls.just_pressed("attack") or controls.just_pressed("grab"):
		start_grab()
		return
	if controls.just_pressed("left"):
		_start_roll(-1)
		return
	if controls.just_pressed("right"):
		_start_roll(1)
		return
	if not controls.pressed("shield"):
		_lag_frames = 6
		state = State.LAG


## Golpe no escudo: sem dano %, desgasta o escudo, empurra e trava um instante.
func _block_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> void:
	blocked.emit(data)
	shield_hp -= data.damage * 1.2
	_shield_stun = int(data.damage * 0.8) + 2
	velocity.x = direction_sign * (120.0 + data.damage * 18.0)
	var stop := Combat.hitstop_frames(data.damage)
	_hitstop = stop
	if attacker is Fighter:
		attacker._hitstop = stop
	if shield_hp <= 0.0:
		_break_shield()


func _break_shield() -> void:
	shield_broken.emit()
	shield_hp = 0.0
	state = State.SHIELD_BREAK
	_break_timer = shield_break_time
	velocity = Vector2(0, -750)


func _process_shield_break(delta: float) -> void:
	_break_timer -= delta
	velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	if not is_on_floor():
		velocity.y = minf(velocity.y + gravity * delta, max_fall_speed)
	if _break_timer <= 0.0:
		shield_hp = shield_max * 0.4
		state = State.IDLE if is_on_floor() else State.AIR


func _start_roll(dir: int) -> void:
	state = State.DODGE
	_dodge_in_air = false
	_dodge_frame = 0
	velocity.x = roll_speed * dir


func _start_air_dodge() -> void:
	state = State.DODGE
	_dodge_in_air = true
	_dodge_frame = 0
	_air_dodge_used = true
	fast_falling = false
	var stick := Vector2(controls.axis("left", "right"), controls.axis("up", "down"))
	_dodge_directional = stick.length() >= STICK_THRESHOLD
	if _dodge_directional:
		velocity = stick.normalized() * air_dodge_speed
	else:
		velocity *= 0.3


func _process_dodge(delta: float) -> void:
	_dodge_frame += 1
	if _dodge_in_air:
		if _dodge_directional and _dodge_frame <= 15:
			velocity = velocity.move_toward(Vector2.ZERO, 1400.0 * delta)
		else:
			_apply_gravity(delta)
		if _dodge_frame >= air_dodge_frames:
			state = State.AIR
	else:
		velocity.y = 0.0
		if _dodge_frame > roll_frames * 0.7:
			velocity.x = move_toward(velocity.x, 0.0, ground_friction * 2.0 * delta)
		if not is_on_floor():
			state = State.AIR
		elif _dodge_frame >= roll_frames:
			state = State.IDLE


# --- Agarrão e arremessos ---

func start_grab() -> void:
	state = State.GRAB
	_grab_frame = 0
	velocity.x *= 0.4


func _process_grab(delta: float) -> void:
	_grab_frame += 1
	velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	if not is_on_floor():
		_apply_gravity(delta)
	if _grab_frame > grab_startup and _grab_frame <= grab_startup + grab_active:
		var center := global_position + Vector2(grab_reach.x * facing, grab_reach.y)
		for f in get_tree().get_nodes_in_group("fighters"):
			var target := f as Fighter
			if target != self and target.can_be_grabbed() and Combat.circle_hits_rect(center, grab_radius, target.hurtbox()):
				_grab_connect(target)
				return
	if _grab_frame >= grab_startup + grab_active + grab_whiff_recovery:
		state = State.IDLE if is_on_floor() else State.AIR


## Gancho para personagens: pode ser agarrado agora? Agarrão passa pelo escudo.
func can_be_grabbed() -> bool:
	return can_be_hit() and state != State.LEDGE and state != State.HELD


func _grab_connect(target: Fighter) -> void:
	velocity = Vector2.ZERO
	target.facing = -facing
	hold(target)
	state = State.HOLDING
	_grab_timer = minf(grab_hold_base + target.damage_percent * 0.01, 3.0)
	_pummel_cooldown = 0
	_hitstop = 4
	target._hitstop = 4


## Chamado por quem está sendo segurado ao apertar botões.
func shorten_grab(seconds: float) -> void:
	if state == State.HOLDING:
		_grab_timer -= seconds


func _process_holding(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	if holding == null:
		state = State.IDLE
		return
	_grab_timer -= delta
	if _grab_timer <= 0.0:
		_grab_escape()
		return
	_pummel_cooldown -= 1
	if controls.just_pressed("attack") and _pummel_cooldown <= 0:
		holding.add_damage(pummel_damage)
		holding._hitstop = 3
		_pummel_cooldown = 18
		return
	if controls.just_pressed("left") or controls.just_pressed("right"):
		var side := -1 if controls.just_pressed("left") else 1
		_do_throw("fthrow" if side == facing else "bthrow", side)
	elif controls.just_pressed("up"):
		_do_throw("uthrow", facing)
	elif controls.just_pressed("down"):
		_do_throw("dthrow", facing)


func _do_throw(throw_id: String, side: int) -> void:
	facing = side
	throw_held(throw_data(throw_id), side)
	_lag_frames = 14
	state = State.LAG


func _grab_escape() -> void:
	var target := holding
	release_hold()
	state = State.IDLE
	velocity.x = -facing * 280.0
	if target != null and is_instance_valid(target):
		target.velocity.x = facing * 280.0


## Arremesso do moveset ou, se não houver, um padrão razoável.
func throw_data(throw_id: String) -> AttackData:
	if moveset != null and moveset.move(throw_id) != null:
		return moveset.move(throw_id)
	if _default_throws.is_empty():
		# [dano, ângulo, base, crescimento]
		var table := {"fthrow": [8.0, 40.0, 380.0, 6.0], "bthrow": [10.0, 40.0, 400.0, 7.0],
			"uthrow": [7.0, 90.0, 360.0, 6.0], "dthrow": [6.0, 75.0, 260.0, 3.0]}
		for id in table:
			var data := AttackData.new()
			data.id = id
			data.damage = table[id][0]
			data.angle = table[id][1]
			data.base_knockback = table[id][2]
			data.knockback_growth = table[id][3]
			_default_throws[id] = data
	return _default_throws[throw_id]


func add_damage(amount: float) -> void:
	damage_percent += amount
	damage_changed.emit(damage_percent)


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
		return
	# Apertar botões ajuda a se soltar mais rápido do agarrão.
	for action in ["jump", "attack", "special", "shield", "left", "right", "up", "down"]:
		if controls.just_pressed(action):
			held_by.shorten_grab(0.08)
			break


# --- Beirada ---

## Só o ataque básico (passinho do jab2/jab3) para na beirada, para não derrubar
## ninguém de plataforma pequena. Especiais e golpes que avançam saem da beirada
## normalmente (ex.: a investida do Juba atravessa e sai da plataforma).
func _stop_at_edge(delta: float) -> void:
	if absf(velocity.x) < 1.0:
		return
	var ahead := signf(velocity.x) * (RADIUS * 0.5 + absf(velocity.x) * delta)
	var from := global_position + Vector2(ahead, HEIGHT * 0.5 - 4.0)
	var q := PhysicsRayQueryParameters2D.create(from, from + Vector2(0, 24.0), collision_mask)
	q.exclude = [get_rid()]
	if get_world_2d().direct_space_state.intersect_ray(q).is_empty():
		velocity.x = 0.0


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
	_ledge_time = 0.0
	_ledge = ledge
	state = State.LEDGE
	fast_falling = false
	helpless = false
	_air_dodge_used = false
	velocity = Vector2.ZERO
	facing = -side
	jumps_left = air_jumps
	global_position = ledge.global_position + Vector2(side * (RADIUS + 2.0), HEIGHT * 0.4)


func _process_ledge(dir: float) -> void:
	var side: int = _ledge.get_meta("side", 1)
	_ledge_time += get_physics_process_delta_time()
	if _ledge_time >= ledge_max_time:
		_release_ledge(State.AIR)
		return
	if controls.just_pressed("up"):
		global_position = _ledge.global_position + Vector2(-side * (RADIUS + 24.0), -HEIGHT * 0.5 - 1.0)
		_release_ledge(State.IDLE)
	elif controls.just_pressed("jump"):
		_release_ledge(State.AIR)
		_jump(jump_velocity)
	elif controls.just_pressed("down") or (absf(dir) > 0.0 and int(signf(dir)) == side):
		_release_ledge(State.AIR)


func _release_ledge(next_state: State) -> void:
	_ledge = null
	_ledge_cooldown = ledge_regrab_delay
	state = next_state


# --- Corrida: toque duplo ou alavanca empurrada rápido ---

func _detect_run_trigger(dir: float) -> bool:
	var triggered := false
	var tap_dir := 0
	if controls.just_pressed("left"):
		tap_dir = -1
	elif controls.just_pressed("right"):
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
		if absf(dir) >= 0.9 and _low_frames <= FLICK_FRAMES and not controls.horizontal_from_keyboard():
			triggered = true
	return triggered




# --- Provisório até a T16 (zonas de KO): volta ao ponto inicial ao cair da arena ---

func _check_out_of_bounds() -> void:
	if auto_respawn and (absf(global_position.x) > 2200.0 or global_position.y > 1400.0 or global_position.y < -1600.0):
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
	_hitstun = 0.0
	_hitstop = 0
	_lag_frames = 0
	_air_dodge_used = false
	shield_hp = shield_max
	damage_percent = 0.0
	damage_changed.emit(damage_percent)


# --- Visual greybox ---

func _draw() -> void:
	if state == State.RESPAWN:
		# Plataforma de retorno: barra luminosa na cor do jogador, pulsando
		var pulse := 0.75 + 0.25 * sin(_clock * 6.0)
		var feet := HEIGHT * 0.5
		draw_rect(Rect2(-60, feet, 120, 10), body_color.lightened(0.3) * Color(1, 1, 1, pulse))
		draw_rect(Rect2(-48, feet + 10, 96, 6), body_color * Color(1, 1, 1, 0.5 * pulse))
		draw_circle(Vector2(0, feet + 8), 70.0, body_color * Color(1, 1, 1, 0.12 * pulse))
	var rect := Rect2(-RADIUS, -HEIGHT * 0.5, RADIUS * 2.0, HEIGHT)
	var color := body_color
	if state == State.HITSTUN and int(_clock * 20.0) % 2 == 0:
		color = color.lightened(0.5)
	elif helpless:
		color = color.darkened(0.4)
	if invincible_time > 0.0:
		color.a = 0.45 if int(_clock * 12.0) % 2 == 0 else 0.8
	elif _is_intangible():
		color.a = 0.4
	if not has_art:  # sem arte: corpo greybox (retângulo com olho)
		draw_rect(rect, color)
		var eye := Vector2(facing * RADIUS * 0.45, -HEIGHT * 0.28)
		draw_circle(eye, 6.0, Color.WHITE)
		draw_circle(eye + Vector2(facing * 2.0, 0), 3.0, Color.BLACK)
	if fast_falling and not has_art:
		draw_line(Vector2(-RADIUS, -HEIGHT * 0.5 - 8), Vector2(RADIUS, -HEIGHT * 0.5 - 8), Color.WHITE, 3.0)
	if state == State.SHIELD:
		var r := 30.0 + 42.0 * (shield_hp / shield_max)
		draw_circle(Vector2.ZERO, r, Color(0.55, 0.85, 1.0, 0.35))
		draw_arc(Vector2.ZERO, r, 0.0, TAU, 32, Color(0.75, 0.95, 1.0, 0.8), 2.0)
	elif state == State.SHIELD_BREAK:
		for i in 3:
			var a := _clock * 6.0 + i * TAU / 3.0
			draw_circle(Vector2(cos(a) * 26.0, -HEIGHT * 0.5 - 10.0 + sin(a) * 6.0), 5.0, Color(1, 0.9, 0.3))
	elif show_debug_label and state == State.GRAB and _grab_frame > grab_startup and _grab_frame <= grab_startup + grab_active:
		draw_circle(Vector2(grab_reach.x * facing, grab_reach.y), grab_radius, Color(0.6, 0.3, 1.0, 0.5))
	if show_debug_label and attack != null and attack.is_active(attack_frame):  # área de acerto (depuração)
		var local := Vector2(attack.hitbox_offset.x * facing, attack.hitbox_offset.y)
		draw_circle(local, attack.hitbox_radius, Color(1, 0.2, 0.2, 0.55))
	var font := ThemeDB.fallback_font
	if show_debug_label:
		var label := "%s %s %d%%" % [player_id.to_upper(), attack_id if attack else State.keys()[state], roundi(damage_percent)]
		draw_string(font, Vector2(-RADIUS * 3.0, -HEIGHT * 0.5 - 16), label, HORIZONTAL_ALIGNMENT_CENTER, RADIUS * 6.0, 18, Color.WHITE)
	else:
		# Indicador do jogador (como no gênero): seta e "P1"/"P2"/"CPU" na cor do lutador
		var tag := "CPU" if brain != null else player_id.to_upper()
		var top := -HEIGHT * 0.5 - 14.0
		draw_colored_polygon(PackedVector2Array([Vector2(-9, top - 12), Vector2(9, top - 12), Vector2(0, top)]), body_color.lightened(0.25))
		draw_string(font, Vector2(-RADIUS * 2.0, top - 18), tag, HORIZONTAL_ALIGNMENT_CENTER, RADIUS * 4.0, 22, body_color.lightened(0.35))
