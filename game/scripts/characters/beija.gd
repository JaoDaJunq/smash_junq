class_name Beija
extends Fighter
## Beija: beija-flor skatista (design/personagens/beija_flor.md, design/proposta-rodada11.md).
## Aves · Rápido. O menor e mais leve do elenco (caixa de acerto reduzida). 2 pulos no ar.
## Mecânica própria "Pairar": segurando o pulo no ar fica parado batendo asa por até
## HOVER_TIME s por pulo (único do elenco). Especiais:
##  - neutro "Néctar": para no ar e suga uma flor por ~1 s; se ninguém interromper, cura 4%.
##  - lado "Manobra": anda de skate (bate com o corpo) e pode pular dele no meio; o skate
##    segue sozinho como projétil, rente ao chão, e some na borda.
##  - cima "Voo de beija-flor": voo rápido sem dano na direção da alavanca (padrão: cima).
##  - baixo "Grind": no chão, desliza derrubando; no ar, cai rápido com o skate (cravada).
## Jab 3 = rajada de 4 bicadas (as 3 primeiras fracas, a última lança).

const HOVER_TIME := 1.5
const HOVER_ENTRY_VY := -120.0     # só começa a pairar quando já quase parou de subir
const HOVER_DRIFT := 0.6           # controle horizontal enquanto paira (fração do air_speed)
const NECTAR_HEAL := 4.0
const SKATE_RIDE := 760.0
const SKATE_AIR := 520.0
const SKATE_SPEED := 700.0
const SKATE_BAIL_JUMP := 760.0
const FLIGHT_SPEED := 1200.0
const GRIND_SPEED := 640.0
const DIVE_SPEED := 1250.0
const PECKS := [3, 6, 9]           # quadros (depois do início) em que a próxima bicada pode acertar
const HURT_W := 44.0
const HURT_H := 84.0

var hover_left := HOVER_TIME
var _hovering := false
var _jump_was_down := false
var _flying := false
var _nectar := false
var _skated := false
var _peck := 1
var _grind_air := false
var _flight_dir := Vector2.UP


func _ready() -> void:
	super()
	jumped.connect(func(_in_air: bool) -> void:
		hover_left = HOVER_TIME)


func _physics_process(delta: float) -> void:
	_update_hover(delta)
	super(delta)


func is_hovering() -> bool:
	return _hovering


# --- Pairar ---

func _update_hover(delta: float) -> void:
	if is_on_floor() or state == State.LEDGE or state == State.RESPAWN:
		hover_left = HOVER_TIME
	var jump_down := controls.pressed("jump")
	var fresh := jump_down and not _jump_was_down
	_jump_was_down = jump_down
	if _hitstop > 0:
		return
	var jump_pending := jumps_left > 0 and (fresh or controls.buffered("jump"))   # este toque vira pulo, não pairada
	var want := state == State.AIR and not helpless and hover_left > 0.0 and not jump_pending \
			and controls.pressed("jump") and not controls.pressed("down") and velocity.y > HOVER_ENTRY_VY
	if want:
		hover_left = maxf(0.0, hover_left - delta)
		want = hover_left > 0.0
	_hovering = want


func _apply_gravity(delta: float) -> void:
	if _flying:
		return
	if _hovering or _nectar:
		velocity.y = 0.0
		return
	super(delta)


func _air_drift(dir: float, delta: float) -> void:
	if _flying:
		return
	if _nectar:
		velocity.x = 0.0
		return
	if _hovering:
		if absf(dir) > 0.0:
			velocity.x = move_toward(velocity.x, air_speed * HOVER_DRIFT * signf(dir), air_accel * delta)
		else:
			velocity.x = move_toward(velocity.x, 0.0, air_friction * 2.0 * delta)
		return
	super(dir, delta)


## O menor do elenco: a caixa de acerto é mais estreita e mais baixa (ancorada nos pés).
func hurtbox() -> Rect2:
	return Rect2(global_position + Vector2(-HURT_W * 0.5, HEIGHT * 0.5 - HURT_H), Vector2(HURT_W, HURT_H))


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	var ok := super(attacker, data, direction_sign)
	if ok:
		hover_left = HOVER_TIME
		_hovering = false
	return ok


# --- Jab 3: rajada de bicadas ---

func _combo_jab(move_id: String) -> AttackData:
	if move_id != "jab3":
		return super(move_id)
	if _jab_cache.has("jab3"):
		return _jab_cache["jab3"]
	var d := moveset.jab.duplicate() as AttackData
	d.startup = 3
	d.active = 10
	d.recovery = 9
	d.hitbox_offset.x += 10.0
	d.hitbox_radius = 24.0
	d.damage = 1.0
	d.base_knockback = 120.0
	d.knockback_growth = 0.5
	d.angle = 25.0
	d.self_velocity = Vector2(120.0, 0.0)
	_jab_cache["jab3"] = d
	return d


## Última bicada da rajada: mais forte e lança.
func _attack_for(_target: Fighter) -> AttackData:
	if attack_id != "jab3" or _peck < PECKS.size() + 1:
		return attack
	if not _jab_cache.has("jab3_fim"):
		var d := attack.duplicate() as AttackData
		d.damage = 2.4
		d.base_knockback = 270.0
		d.knockback_growth = 4.5
		d.angle = 38.0
		d.hitbox_radius = 28.0
		_jab_cache["jab3_fim"] = d
	return _jab_cache["jab3_fim"]


# --- Especiais ---

func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"jab3":
			if frame == 1:
				_peck = 1
			elif frame - attack.startup in PECKS:
				_peck += 1
				_hit_targets.clear()   # cada bicada pode acertar de novo
		"special_neutral":
			_nectar_frame(frame)
		"special_side":
			_manobra_frame(frame)
		"special_up":
			_voo_frame(frame)
		"special_down":
			_grind_frame(frame)


func _on_attack_end(_move_id: String) -> void:
	_nectar = false
	_flying = false


## Néctar: parado no ar (no chão fica em pé) até o fim; cura no último quadro.
func _nectar_frame(frame: int) -> void:
	if frame == 1:
		_nectar = true
	if not is_on_floor():
		velocity.x = 0.0
	if frame == attack.startup and move_fx != null:
		move_fx.play_at("fx_nectar", global_position + Vector2(facing * 58.0, -18.0), 1.5, 0.5)
	if frame == attack.total_frames():
		_heal(NECTAR_HEAL)


func _heal(amount: float) -> void:
	var h := minf(amount, damage_percent)
	if h > 0.0:
		add_damage(-h)
	if move_fx != null:
		move_fx.play("fx_nectar", "head", null, 1.5, false, 0.5)


## Manobra: anda no skate; pular no meio sai dele; no fim (ou ao pular) o skate segue sozinho.
func _manobra_frame(frame: int) -> void:
	var a := attack
	if frame == 1:
		_skated = false
		controls.consume("jump")
	var last := a.startup + a.active
	if frame < a.startup or frame > last or _skated:
		return
	var on_ground := is_on_floor() and not _attack_in_air
	if on_ground:
		velocity.x = SKATE_RIDE * facing
		if not _floor_ahead():
			velocity.x = 0.0
			_launch_skate(true)   # a borda chegou: o skate vai sozinho
			return
	else:
		velocity.x = SKATE_AIR * facing
	if frame > a.startup + 2 and controls.take("jump"):
		velocity.y = -SKATE_BAIL_JUMP
		_attack_in_air = true
		jumped.emit(true)
		_launch_skate(on_ground)
		attack_frame = last   # o resto do golpe é a recuperação
		return
	if frame == last:
		_launch_skate(on_ground)


func _launch_skate(on_ground: bool) -> void:
	if _skated or attack == null:
		return
	_skated = true
	var d := attack.duplicate() as AttackData
	d.damage = 4.5
	d.hitbox_radius = 22.0
	d.base_knockback = 250.0
	d.knockback_growth = 5.0
	d.angle = 40.0
	var at := global_position + Vector2(facing * 44.0, HEIGHT * 0.5 - 14.0 if on_ground else 10.0)
	SkateVoador.launch(self, d, at, facing, SKATE_SPEED, on_ground)


## Voo: depois do preparo, dispara na direção da alavanca (sem direção = para cima).
func _voo_frame(frame: int) -> void:
	var a := attack
	if frame == a.startup:
		var v := controls.stick()
		if v.length() < 0.5:
			v = Vector2(0.0, -1.0)
		if is_on_floor() and v.y > 0.0:
			v.y = 0.0
			if v.x == 0.0:
				v = Vector2(0.0, -1.0)
		v = v.normalized()
		if absf(v.x) > 0.3:
			facing = int(signf(v.x))
		_flight_dir = v
		_flying = true
		_attack_in_air = true
		jumped.emit(true)
	if frame >= a.startup and frame <= a.startup + a.active:
		velocity = _flight_dir * FLIGHT_SPEED
	elif frame == a.startup + a.active + 1:
		velocity *= 0.25
		_flying = false



## Grind no chão (desliza e derruba) ou cravada no ar (cai com o skate).
func _grind_frame(frame: int) -> void:
	var a := attack
	if frame == 1:
		_grind_air = _attack_in_air or not is_on_floor()
		if _grind_air:
			var d := a.duplicate() as AttackData
			d.hitbox_offset = Vector2(4.0, 54.0)
			d.hitbox_radius = 28.0
			d.damage = 7.0
			d.angle = -70.0
			d.base_knockback = 230.0
			d.knockback_growth = 5.0
			attack = d
			a = d
	if frame < a.startup or frame > a.startup + a.active:
		return
	if _grind_air:
		velocity.x *= 0.85
		fast_falling = true   # mergulho na velocidade da queda rápida
		velocity.y = maxf(velocity.y, DIVE_SPEED)
	elif is_on_floor():
		velocity.x = GRIND_SPEED * facing
		if not _floor_ahead():
			velocity.x = 0.0


func _floor_ahead() -> bool:
	var from := global_position + Vector2(facing * (RADIUS + 10.0), HEIGHT * 0.5 - 24.0)
	var q := PhysicsRayQueryParameters2D.create(from, from + Vector2(0, 56.0), collision_mask)
	q.exclude = [get_rid()]
	return not get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func respawn() -> void:
	super()
	hover_left = HOVER_TIME
	_hovering = false
	_flying = false
	_nectar = false


## Pairando: bate asa com os quadros de subida/topo do pulo.
func anim_override() -> Array:
	if _hovering:
		return ["pulo", 12.0, false, [2, 3, 4]]
	return []


func _draw() -> void:
	super()
	# barrinha do fôlego de pairar (só aparece depois de gastar um pouco)
	if hover_left < HOVER_TIME - 0.01 and not is_on_floor() and state in [State.AIR, State.ATTACK]:
		var top := Vector2(-20.0, -HEIGHT * 0.5 - 84.0)
		draw_rect(Rect2(top - Vector2(1.5, 1.5), Vector2(43.0, 8.0)), Color("2a0f12"))
		draw_rect(Rect2(top, Vector2(40.0 * hover_left / HOVER_TIME, 5.0)), Color("6bd04a") if _hovering else Color("c8d84a"))
