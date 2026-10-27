class_name Calango
extends Fighter
## Calango: lagarto ambulante de praia (design/personagens/calango.md e
## design/revisao/novos_personagens.md §5). Rápido. Especiais:
##  - neutro "Joga areia": punhado de areia reto e rasante (projétil curto); quem
##    leva fica com areia nos olhos e o próximo golpe dele ERRA (Fighter.sand_time).
##  - lado "Corrida de calango": acelera enquanto segura o botão (atropela de novo a
##    cada RUN_TICK quadros); parede alta à frente: sobe correndo (1 vez por pulo,
##    sem grudar) e no topo dá um pulinho por cima.
##  - cima "Salto de lagartixa" (recuperação).
##  - baixo "Tomar sol": deita e esquenta; segurando, sobe de nível a cada SUN_STEP
##    quadros (até 3: +10/+20/+30% de velocidade por SUN_TIME s). Levar golpe
##    deitado perde tudo.
## Mecânica "Rabo solto": 1 vez por vida, um golpe que o lançaria longe só arranca
## o rabo: o golpe que ele fazia acaba, ele dá um pulinho, fica intocável um
## instante e fica SEM RABO até o próximo KO. O rabo no chão é isca: o primeiro
## golpe de adversário que encostar nele é gasto ali.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const RABO_PATH := "res://assets/characters/calango/pixel/rabo.png"
const AREIA_PATH := "res://assets/characters/calango/pixel/areia.png"
const SAND_SPEED := 700.0
const SAND_LIFE := 0.25
const SAND_BLIND := 2.5
const SAND_W := 34.0
const RUN_MIN := 600.0
const RUN_MAX := 1250.0
const RUN_ACCEL := 1800.0        # px/s²
const RUN_MAX_FRAMES := 50
const RUN_TICK := 8              # atropela de novo
const WALL_RUN_SPEED := 900.0
const WALL_RUN_FRAMES := 18
const HOP_SPEED := 1200.0
const SUN_STEP := 20             # quadros por nível
const SUN_BONUS := [0.0, 0.10, 0.20, 0.30]
const SUN_HOLD_MAX := 90
const SUN_TIME := 7.0
const TAIL_LAUNCH := 900.0       # lançamento a partir do qual o rabo se solta
const TAIL_INVULN := 0.6

var tail_ready := true           # volta só no respawn()
var _sun := 0.0
var sun_level := 0               # nível do sol ativo (0 = sem sol)
var _sun_charge := 0             # nível juntado enquanto segura
var _sun_charging := false
var _base_speeds := Vector3.ZERO
var _sun_hold := 0
var _wall_run_used := false
var _wall_t := 0
var _run_t := 0
var _run_v := 0.0
var wall_runs := 0               # (testes) quantas subidas de parede


func _ready() -> void:
	super()
	_base_speeds = Vector3(walk_speed, run_speed, air_speed)
	hit_taken.connect(func(_a: Node2D, _d: AttackData, _l: Vector2) -> void:
		if _sun_charging:
			_sun_charging = false   # levou golpe deitado: perde o sol juntado
			_sun_charge = 0)


func has_sun() -> bool:
	return _sun > 0.0


func _physics_process(delta: float) -> void:
	if _sun > 0.0:
		_sun -= delta
		if _sun <= 0.0:
			_set_sun(0)
	if is_on_floor() and _wall_t <= 0:
		_wall_run_used = false
	super(delta)


func _set_sun(level: int) -> void:
	sun_level = level
	var k := 1.0 + float(SUN_BONUS[level])
	walk_speed = _base_speeds.x * k
	run_speed = _base_speeds.y * k
	air_speed = _base_speeds.z * k
	modulate = Color(1.08, 1.0, 0.9) if level > 0 else Color.WHITE
	_sun = SUN_TIME if level > 0 else 0.0


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if data != null and tail_ready and state != State.SHIELD:
		var speed := Combat.launch_speed(data, damage_percent + data.damage, weight)
		if speed >= TAIL_LAUNCH:
			_lose_tail(attacker, data, direction_sign)
			return true
	return super(attacker, data, direction_sign)


## Rabo solto: acaba o golpe, pulinho curto, intocável, rabo fica no chão.
func _lose_tail(attacker: Node2D, data: AttackData, direction_sign: int) -> void:
	tail_ready = false
	if attack != null:
		_end_attack()
	helpless = false
	_sun_charging = false
	release_hold()
	damage_percent += data.damage
	damage_changed.emit(damage_percent)
	state = State.AIR
	_hitstun = 0.0
	velocity = Vector2(direction_sign * 320.0, -480.0)   # pulinho para longe do rabo
	invincible_time = maxf(invincible_time, TAIL_INVULN)
	_drop_tail(-direction_sign)
	if move_fx != null:
		move_fx.event("tail")
	hit_taken.emit(attacker, data, Vector2.ZERO)


func respawn() -> void:
	super()
	tail_ready = true
	_set_sun(0)


## Sem rabo: parado/andando usa a folha sem_rabo.
func anim_override() -> Array:
	if not tail_ready and state in [State.IDLE, State.WALK]:
		return ["sem_rabo", 6.0]
	return []


func _drop_tail(side: int) -> void:
	var r := RaboSolto.new()
	r.owner_fighter = self
	r.add_to_group("match_cleanup")
	r.add_to_group("iscas")
	get_parent().add_child(r)
	# o rabo fica para trás (do lado de onde veio o golpe), separado do calango
	r.global_position = global_position + Vector2(40.0 * side, HEIGHT * 0.5)
	r.flip = side > 0
	if ResourceLoader.exists(RABO_PATH):
		r.tex = load(RABO_PATH)


func _check_hits() -> void:
	if attack_id == "special_neutral":
		return   # a areia é só o projétil (antes acertava 2x e o corpo a corpo não cegava)
	super._check_hits()


func _on_projectile_hit(target: Fighter, p: Projectile) -> void:
	if p.has_meta("areia"):
		target.sand_time = SAND_BLIND
		if move_fx != null:
			move_fx.play("fx_areia_olho", "target_eyes", target, 2.6, true, SAND_BLIND, "areia_olho")


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				var at := global_position + Vector2(48.0 * facing, HEIGHT * 0.5 - 30.0)
				var p := Projectile.spawn(PROJECTILE, self, attack, at, Vector2(SAND_SPEED * facing, 0.0), SAND_LIFE)
				p.color = Color("e8d48a")
				p.look = "areia"
				p.set_meta("areia", true)
				if has_art and ResourceLoader.exists(AREIA_PATH):
					p.set_sprite_fit(load(AREIA_PATH), SAND_W)
		"special_side":
			_run(frame)
		"special_up":
			if frame == attack.startup:
				velocity.y = -HOP_SPEED
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			_sunbathe(frame)


func _run(frame: int) -> void:
	if frame == 1:
		_run_t = 0
		_wall_t = 0
	var dt := get_physics_process_delta_time()
	if frame < attack.startup or frame > attack.startup + attack.active:
		if frame == attack.startup + attack.active + 1:
			velocity.x *= 0.3
		return
	_run_t += 1
	if _run_t % RUN_TICK == 0:
		_hit_targets.clear()   # atropela de novo
	if _wall_t > 0:
		# subindo a parede correndo (sem grudar)
		_wall_t -= 1
		velocity = Vector2(0.0, -WALL_RUN_SPEED)
		attack_frame = attack.startup + 1
		if _run_t % 3 == 0 and move_fx != null:
			move_fx.play("fx_poeira_corrida", "wall", null, 1.5, false, 0.3, "poeira")
		if _wall_t == 0:
			velocity = Vector2(200.0 * facing, -400.0)   # pulinho por cima no topo
		return
	if frame == attack.startup:
		_run_v = RUN_MIN
	_run_v = move_toward(_run_v, RUN_MAX, RUN_ACCEL * dt)
	velocity.x = _run_v * facing
	if is_on_floor() and not _attack_in_air:
		velocity.x += ground_friction * dt * facing   # o atrito do golpe vem depois
	if _run_t % 3 == 0 and move_fx != null and is_on_floor():
		move_fx.play("fx_poeira_corrida", "feet_behind", null, 2.0, false, 0.3, "poeira")
	if not _wall_run_used and tall_wall_ahead(12.0):
		_wall_run_used = true
		_wall_t = WALL_RUN_FRAMES
		_attack_in_air = true
		wall_runs += 1
		attack_frame = attack.startup + 1
		return
	if controls.pressed("special") and _run_t < RUN_MAX_FRAMES:
		attack_frame = attack.startup + 1   # segurando: continua correndo e acelerando


func _sunbathe(frame: int) -> void:
	if frame == 1:
		_sun_charge = 0
		_sun_hold = 0
		_sun_charging = is_on_floor()
	if not _sun_charging:
		return
	if frame < attack.startup:
		_sun_hold += 1
		if _sun_hold % SUN_STEP == 0 and _sun_charge < 3:
			_sun_charge += 1
			_sun_fx(_sun_charge)
		if frame == attack.startup - 1 and controls.pressed("special") and _sun_hold < SUN_HOLD_MAX:
			attack_frame -= 1   # segurando: continua deitado juntando sol
	elif frame == attack.startup:
		_sun_charging = false
		if _sun_charge == 0:
			_sun_fx(1)   # só um toque: nível 1
		_set_sun(maxi(1, _sun_charge))


func _sun_fx(level: int) -> void:
	if move_fx == null:
		return
	# raios descendo em cima dele deitado: a base do raio encosta no corpo
	var px := 1.25 + 0.25 * level
	move_fx.play_at("fx_sol", global_position + Vector2(0, HEIGHT * 0.5 - 20.0 - 30.0 * px), px, 0.5)
