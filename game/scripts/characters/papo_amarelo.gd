class_name PapoAmarelo
extends Fighter
## Papo-Amarelo: jacaré-de-papo-amarelo pescador (design/personagens/jacare.md,
## design/proposta-rodada11.md). Répteis · Pesado, o mais pesado do jogo.
## Mecânica própria: o ANZOL (linha de pesca), que prende na borda e fisga de longe.
## Especiais:
##  - neutro "Fisgada": lança o anzol na direção segurada depois do toque (8 direções;
##    sem direção vai para a frente). Se fisga o adversário, puxa ele até a boca e dá
##    uma mordida curta.
##  - lado "Rede": joga a rede em arco; quem é pego fica preso 1 s (se solta apertando
##    botões; levar golpe também solta).
##  - cima "Anzol na borda": lança o anzol para cima e para a frente (mira sozinho na
##    borda do palco mais perto); se pega a borda, a linha o puxa e ele se pendura.
##    Se não pega nada, fica sem pulo nem golpe até pousar.
##  - baixo "Rolamento da morte": mordida que agarra, gira com o adversário e arremessa
##    longe; ele sai com "dente quebrado" (estrelinhas).

const HOOK_RANGE := 430.0
const AIM_DEADZONE := 0.35
const NET_SPEED := Vector2(520.0, -300.0)
const ROLL_FRAMES := 36
const ROLL_TICK := 9
const ROLL_DAMAGE := 1.5

var _hook: AnzolPesca = null
var _rolling := false
var _roll_t := 0
var _hook_data: AttackData
var _bite_data: AttackData
var _hook_up_data: AttackData
var _net_data: AttackData
var _roll_throw: AttackData


func _ready() -> void:
	super()
	_hook_data = _make_data(2.0, 40.0, 0.0, 0.0)
	_bite_data = _make_data(4.5, 55.0, 250.0, 4.5)
	_hook_up_data = _make_data(4.0, 85.0, 250.0, 4.0)
	_net_data = _make_data(1.0, 40.0, 0.0, 0.0)
	_roll_throw = _make_data(8.0, 40.0, 420.0, 7.4)


static func _make_data(dmg: float, ang: float, base: float, growth: float) -> AttackData:
	var d := AttackData.new()
	d.damage = dmg
	d.angle = ang
	d.base_knockback = base
	d.knockback_growth = growth
	return d


func hook_data() -> AttackData:
	return _hook_data


func hook_up_data() -> AttackData:
	return _hook_up_data


func is_rolling() -> bool:
	return _rolling


func has_hook() -> bool:
	return _hook != null and is_instance_valid(_hook)


# --- Entrada dos especiais ---

func start_special(kind: String) -> void:
	if kind == "neutral" or kind == "up":
		var x := controls.axis("left", "right")
		if absf(x) >= AIM_DEADZONE:
			facing = int(signf(x))
	if kind == "up":
		var l := _ledge_to_hook()
		if l != null:
			facing = 1 if l.global_position.x >= global_position.x else -1
	super.start_special(kind)


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				_throw_hook(AnzolPesca.Mode.FISGA, _aim_dir())
		"special_side":
			if frame == attack.startup:
				var at := global_position + Vector2(facing * 40.0, -40.0)
				RedePesca.spawn(self, _net_data, at, Vector2(NET_SPEED.x * facing, NET_SPEED.y))
		"special_up":
			if frame == attack.startup:
				if not is_on_floor():
					velocity.y = minf(velocity.y, -260.0)   # um empurrãozinho: é a volta ao palco
					_attack_in_air = true
				var l := _ledge_to_hook()
				var dir := Vector2(facing * 0.6, -0.8)
				if l != null:
					dir = l.global_position - _rod_tip()
				_throw_hook(AnzolPesca.Mode.BORDA, dir)
			elif has_hook() and _hook.phase == AnzolPesca.Phase.PULL:
				attack_frame = attack.startup + 1   # a linha está puxando: segura o golpe
		"special_down":
			_roll_step(frame)
	if move_id == "special_neutral" and has_hook() and _hook.phase == AnzolPesca.Phase.REEL:
		attack_frame = mini(attack_frame, attack.startup + attack.active)   # puxando: não termina


func _rod_tip() -> Vector2:
	return global_position + Vector2(AnzolPesca.ROD_TIP.x * facing, AnzolPesca.ROD_TIP.y)


func _throw_hook(hook_mode: AnzolPesca.Mode, dir: Vector2) -> void:
	if has_hook():
		_hook.queue_free()
	if hook_mode == AnzolPesca.Mode.FISGA and dir.x != 0.0 and signf(dir.x) != float(facing):
		facing = int(signf(dir.x))   # mirou para trás: vira
	_hook = AnzolPesca.spawn(self, hook_mode, dir, HOOK_RANGE)


## Direção do anzol: a alavanca segurada (8 direções); sem direção, para a frente.
func _aim_dir() -> Vector2:
	var v := Vector2(controls.axis("left", "right"), controls.axis("up", "down"))
	if v.length() < AIM_DEADZONE:
		return Vector2(facing, 0.0)
	return Vector2.from_angle(snappedf(v.angle(), PI / 4.0))


## Borda livre ao alcance do anzol (do lado de fora do palco, mais perto primeiro).
func _ledge_to_hook() -> Node2D:
	var best: Node2D = null
	var bd := HOOK_RANGE - 30.0
	for ledge in get_tree().get_nodes_in_group("ledges"):
		var l := ledge as Node2D
		var side: int = l.get_meta("side", 1)
		if _ledge_taken(l) or (global_position.x - l.global_position.x) * side < -RADIUS * 0.5:
			continue
		var d := l.global_position - global_position - Vector2(0, -44.0)
		if d.y > 40.0:
			continue
		if d.length() < bd:
			bd = d.length()
			best = l
	return best


# --- Chamados pelo anzol ---

func hook_caught_foe(_h: AnzolPesca, _foe: Fighter) -> void:
	pass


func hook_caught_ledge(_h: AnzolPesca) -> void:
	velocity = Vector2.ZERO


## O anzol puxou o jacaré até a borda: pendura (sem ficar sem pulo).
func hook_arrived(ledge: Node2D) -> void:
	_hook = null
	var id := attack_id
	attack = null
	attack_id = ""
	_on_attack_end(id)
	_grab_ledge(ledge, int(ledge.get_meta("side", 1)))


## O adversário chegou à boca: mordida curta e o golpe termina logo.
func hook_bite(foe: Fighter) -> void:
	if foe == null or not is_instance_valid(foe):
		return
	foe.receive_hit(self, _bite_data, facing)
	if attack != null:
		attack_frame = maxi(attack_frame, attack.total_frames() - 10)


# --- Rolamento da morte ---

func _roll_step(frame: int) -> void:
	if holding != null:
		if not _rolling:
			_rolling = true
			_roll_t = 0
		attack_frame = attack.startup + 1   # segura o golpe enquanto gira
		velocity.x = 0.0
		_roll_t += 1
		if _roll_t % ROLL_TICK == 0:
			holding.add_damage(ROLL_DAMAGE)
			if move_fx != null:
				move_fx.event("splash")
		if _roll_t >= ROLL_FRAMES:
			_finish_roll()
		return
	if _rolling:
		# o adversário escapou (ou saiu da luta): vai direto para a recuperação
		_rolling = false
		attack_frame = attack.startup + attack.active + 1
		return
	if attack.is_active(frame):
		_catch_in_hitbox()


func _finish_roll() -> void:
	var t := holding
	throw_held(_roll_throw, facing)
	_rolling = false
	if attack != null:
		attack_frame = attack.startup + attack.active + 1
	if move_fx != null and t != null and is_instance_valid(t):
		move_fx.event("dente", t)


## Prende o primeiro lutador dentro da boca (sem dano; o dano vem do giro e do arremesso).
func _catch_in_hitbox() -> bool:
	var tip := hitbox_center(attack)
	var base := global_position + Vector2(facing * RADIUS, tip.y - global_position.y)
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == self or not target.can_be_hit() or not target.can_be_grabbed():
			continue
		for k in [0.4, 0.7, 1.0]:
			if Combat.circle_hits_rect(base.lerp(tip, k), attack.hitbox_radius, target.hurtbox()):
				hold(target)
				return true
	return false


func _check_hits() -> void:
	if attack_id == "special_down":
		return   # a mordida agarra, não machuca ao encostar
	super._check_hits()


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_down":
		_rolling = false
		if holding != null:
			throw_held(_roll_throw, facing)   # pousou ou foi interrompido no meio: solta e arremessa
	elif move_id == "special_neutral" or move_id == "special_up":
		if has_hook() and _hook.phase != AnzolPesca.Phase.BACK:
			_hook.phase = AnzolPesca.Phase.BACK
			_hook.hooked_foe = null
			_hook.hooked_ledge = null


func respawn() -> void:
	super()
	_rolling = false
	_roll_t = 0
	if has_hook():
		_hook.queue_free()
	_hook = null


## No rolamento o jacaré gira inteiro (quadros 2 e 3 da folha, fixos).
func anim_override() -> Array:
	if _rolling and holding != null:
		return ["especial_baixo", 2 + (_roll_t / 4) % 2, true]
	return []
