class_name CpuBrain
extends RefCounted
## CPU básica do primeiro corte (GDD, seção CPU). Máquina de estados simples:
## aproximar, atacar, defender, recuperar e reagir. Sem níveis de dificuldade;
## o tempo de reação deixa a CPU imperfeita de propósito.
## A cada quadro escreve os botões que quer apertar em CpuControls.

enum Mode { APPROACH, ATTACK, DEFEND, RECOVER, REACT }

## Quadros entre uma decisão e a próxima (tempo de reação).
var reaction_frames := 14
## Chance de defender quando o adversário ataca por perto.
var defend_chance := 0.3
## Chance de usar o especial neutro de longe.
var zoning_chance := 0.08
## Distância horizontal em que a CPU tenta acertar.
var attack_range := 95.0

var mode := Mode.APPROACH
var rng := RandomNumberGenerator.new()
## Chance, por quadro em que pode, de escapar do combo com a esquiva.
@export var escape_chance := 0.04

var _hold := {}           # ação -> quadros restantes segurando
var _cooldown := 0
var _ledge_wait := 0
var _seen_foe_attack: AttackData = null
var _mash_toggle := false
var _idle := 0


func _init(seed_value := -1) -> void:
	if seed_value >= 0:
		rng.seed = seed_value
	else:
		rng.randomize()


func think(me: Fighter, _delta: float) -> void:
	var c := me.controls as CpuControls
	if c == null:
		return
	_apply_holds(c)
	var foe := _find_foe(me)

	match me.state:
		Fighter.State.HITSTUN, Fighter.State.SHIELD_BREAK, Fighter.State.LAG:
			mode = Mode.REACT
			# Às vezes escapa do combo com a esquiva (nem sempre, para ser justo).
			if me.state == Fighter.State.HITSTUN and me.can_escape() and rng.randf() < escape_chance:
				_tap("shield")
			return
		Fighter.State.HELD:
			mode = Mode.REACT
			_mash_toggle = not _mash_toggle  # aperta botões para se soltar
			if _mash_toggle:
				c.press("jump")
			return
		Fighter.State.LEDGE:
			_ledge_wait += 1
			if _ledge_wait > reaction_frames:
				_ledge_wait = 0
				_tap("up" if rng.randf() < 0.7 else "jump")
			return
		Fighter.State.HOLDING:
			if _cooldown <= 0:
				var toward := _dir_to(me, Vector2.ZERO)
				_tap(["up", "down", "left", "right"][rng.randi() % 4] if rng.randf() < 0.4 else ("right" if toward > 0 else "left"))
				_cooldown = reaction_frames
			_cooldown -= 1
			return

	if _offstage(me):
		mode = Mode.RECOVER
		_recover(me, c)
		return

	if foe == null:
		return
	# Ocupada (golpe, agarrão, esquiva): não toma decisão nova. Com a fila de
	# entrada, um toque dado agora sairia sozinho logo depois (ex.: especial
	# atrás de especial sem nunca andar). Só segue andando e conta o tempo.
	if me.state in [Fighter.State.ATTACK, Fighter.State.GRAB, Fighter.State.DODGE]:
		if _cooldown > 0:
			_cooldown -= 1
		if mode == Mode.APPROACH:
			_walk_toward(me, foe, c)
		return
	if _cooldown > 0:
		_cooldown -= 1
		if mode == Mode.APPROACH:
			_walk_toward(me, foe, c)
		return

	if _should_defend(me, foe):
		mode = Mode.DEFEND
		_defend(me, foe)
		_cooldown = reaction_frames
		return

	var dx := foe.global_position.x - me.global_position.x
	var dy := foe.global_position.y - me.global_position.y
	var on_ledge := foe.state == Fighter.State.LEDGE
	var reach := attack_range + (40.0 if on_ledge else 0.0)
	if absf(dx) <= reach and absf(dy) <= 110.0 and foe.can_be_hit():
		mode = Mode.ATTACK
		if on_ledge and me.is_on_floor():
			_face(me, dx)
			_tap_with("attack", "down")  # golpe baixo acerta quem está pendurado
		else:
			_attack(me, foe, dx, dy)
		_cooldown = reaction_frames + rng.randi_range(0, 10)
		_idle = 0
		return

	mode = Mode.APPROACH
	if absf(dx) > 380.0 and me.is_on_floor() and rng.randf() < zoning_chance:
		_face(me, dx)
		_tap("special")
		_cooldown = reaction_frames
		return
	if dy < -160.0 and me.is_on_floor() and rng.randf() < 0.3:
		_tap("jump", 6)
	if _walk_toward(me, foe, c):
		_idle = 0
	else:
		_idle += 1
		if _idle > 90:
			# Sem nada a fazer (ex.: adversário fora do palco): não fica plantada.
			_idle = 0
			_tap("shield", 10) if rng.randf() < 0.5 else _tap("jump", 3)


# --- Decisões ---

func _attack(me: Fighter, foe: Fighter, dx: float, dy: float) -> void:
	_face(me, dx)
	if foe.state == Fighter.State.SHIELD and me.is_on_floor():
		_tap("grab")
		return
	var roll := rng.randf()
	if me.is_on_floor():
		if dy < -70.0:
			_tap_with("attack", "up")
		elif roll < 0.35:
			_tap("attack")
		elif roll < 0.7:
			_tap_with("attack", "right" if dx > 0 else "left")
		elif roll < 0.82:
			_tap_with("attack", "down")
		elif roll < 0.9:
			_tap("grab")
		else:
			_tap_with("special", "right" if dx > 0 else "left")
	else:
		if dy < -60.0:
			_tap_with("attack", "up")
		elif dy > 60.0:
			_tap_with("attack", "down")
		elif roll < 0.5:
			_tap("attack")
		else:
			_tap_with("attack", "right" if dx > 0 else "left")


func _should_defend(me: Fighter, foe: Fighter) -> bool:
	if foe.attack == null:
		_seen_foe_attack = null
		return false
	if foe.attack == _seen_foe_attack:
		return false  # já decidiu sobre este golpe
	_seen_foe_attack = foe.attack
	var close := me.global_position.distance_to(foe.global_position) < 180.0
	return close and me.is_on_floor() and rng.randf() < defend_chance


func _defend(me: Fighter, foe: Fighter) -> void:
	if rng.randf() < 0.6:
		_tap("shield", 18)
	else:
		# rola para longe do adversário
		var away := "left" if foe.global_position.x > me.global_position.x else "right"
		_hold["shield"] = 4
		_hold[away] = 2


func _recover(me: Fighter, c: CpuControls) -> void:
	var edge := _stage_edge_x()
	var x := me.global_position.x
	var side := 1.0 if x >= 0.0 else -1.0
	# Embaixo do palco: primeiro sai para fora da borda, senão bate por baixo e cai.
	var under := absf(x) < edge + 40.0 and me.global_position.y > 20.0
	if under:
		c.press("right" if side > 0.0 else "left")
	else:
		c.press("left" if side > 0.0 else "right")
	if me.helpless or me.state == Fighter.State.ATTACK:
		return
	if under:
		if me.velocity.y > 0.0 and me.jumps_left > 0 and me.global_position.y > 250.0:
			c.press("jump")  # ganha altura enquanto vai para o lado
		return
	var below_stage := me.global_position.y > -20.0
	var far := absf(x) > edge + 220.0
	if me.velocity.y > 0.0 and me.jumps_left > 0 and (below_stage or far):
		c.press("jump")  # tap: o controle virtual só "aperta" se não estava apertado
		return
	if me.jumps_left == 0 and (below_stage or (far and me.velocity.y > 150.0)):
		c.press("up")
		c.press("special")


## Anda em direção ao adversário. Retorna false se ficou parada.
func _walk_toward(me: Fighter, foe: Fighter, c: CpuControls) -> bool:
	var dx := foe.global_position.x - me.global_position.x
	if absf(dx) < attack_range * 0.6:
		return false
	var edge := _stage_edge_x()
	var margin := 8.0 if foe.state == Fighter.State.LEDGE else 30.0
	var next_x := me.global_position.x + signf(dx) * 20.0
	if me.is_on_floor() and absf(next_x) > edge - margin:
		return false  # não sai do palco correndo atrás de quem está fora
	c.press("right" if dx > 0 else "left")
	return true


# --- Utilidades ---

func _tap(action: String, frames := 2) -> void:
	_hold[action] = frames


## Aperta um botão junto com uma direção (a direção chega no mesmo quadro).
func _tap_with(action: String, direction: String) -> void:
	_hold[direction] = 3
	_hold[action] = 2


func _apply_holds(c: CpuControls) -> void:
	for action in _hold.keys():
		if _hold[action] > 0:
			c.press(action)
			_hold[action] -= 1
		else:
			_hold.erase(action)


func _face(me: Fighter, dx: float) -> void:
	if dx != 0.0 and me.is_on_floor() and me.state != Fighter.State.ATTACK:
		me.facing = 1 if dx > 0.0 else -1


func _find_foe(me: Fighter) -> Fighter:
	for f in me.get_tree().get_nodes_in_group("fighters"):
		if f != me:
			return f as Fighter
	return null


func _stage_edge_x() -> float:
	var edge := 560.0
	var tree := Engine.get_main_loop() as SceneTree
	for ledge in tree.get_nodes_in_group("ledges"):
		edge = absf((ledge as Node2D).global_position.x)
		break
	return edge


func _offstage(me: Fighter) -> bool:
	if me.is_on_floor():
		return false
	return absf(me.global_position.x) > _stage_edge_x() or me.global_position.y > 10.0


func _dir_to(me: Fighter, point: Vector2) -> float:
	return signf(point.x - me.global_position.x)
