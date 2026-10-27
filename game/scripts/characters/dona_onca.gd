class_name DonaOnca
extends Fighter
## Dona Onça: onça-pintada delegada do bairro (design/personagens/onca.md e
## design/revisao/novos_personagens.md §3). Pesada. Especiais:
##  - neutro "Parado aí!": sem dano; quem está no cone à frente é empurrado um pouco,
##    VIRA DE COSTAS para ela (virada travada) e os projéteis dos outros no cone somem.
##    Recarga ROAR_COOLDOWN.
##  - lado "Abordagem": avança com a patada; alvo DE COSTAS para ela leva x1.3 e
##    ganha +2 fichas (combo com o "Parado aí!").
##  - cima "Bote": salto diagonal para a frente; pega a borda de mais longe.
##  - baixo "Interditado!": bate o distintivo e finca a faixa zebrada
##    (FaixaInterditada): barreira que o adversário não atravessa andando e que
##    segura projéteis. Uma por vez.
## Mecânica "Ficha corrida": cada patada que acerta carimba uma ficha no adversário
## (estrelinha em cima dele + carimbo). Com 3 fichas, o próximo golpe dela QUE
## ACERTAR ESSE ALVO é a "voz de prisão": dano x1.5, lançamento x1.6, algema, e a
## ficha zera. A ficha também zera quando o alvo leva KO.

const PATADAS := ["jab", "jab2", "jab3", "ftilt", "dtilt", "fair", "special_side"]
const FICHAS_MAX := 3
const PRISAO_DANO := 1.5
const PRISAO_LANCE := 1.6
const ROAR_RADIUS := 260.0
const ROAR_PUSH := 420.0
const ROAR_TURN_LOCK := 0.4
const ROAR_COOLDOWN := 1.5
const BACK_BONUS := 1.3          # abordagem por trás
const POUNCE_SPEED := 760.0
const LEAP := Vector2(480.0, -1080.0)
const LEDGE_REACH_BOTE := 1.6    # alcance da borda no bote (x o normal)
const FAIXA_AHEAD := 80.0

var fichas := {}   # Fighter -> quantidade de fichas (0..3)
var _roar_cd := 0.0
var _prisao_target: Fighter = null
var _back_targets: Array = []    # alvos pegos de costas pela abordagem neste golpe
var _faixa: Node2D = null


func ficha_de(f: Fighter) -> int:
	return int(fichas.get(f, 0))


func _marca(f: Fighter) -> FichaMarca:
	var m := f.get_node_or_null("FichaMarca") as FichaMarca
	if m == null:
		m = FichaMarca.new()
		m.name = "FichaMarca"
		m.position = Vector2(0, -HEIGHT * 0.5 - 40)
		f.add_child(m)
	return m


func set_ficha(f: Fighter, n: int) -> void:
	fichas[f] = n
	_marca(f).count = n


func _physics_process(delta: float) -> void:
	_roar_cd = maxf(_roar_cd - delta, 0.0)
	# Ficha zera quando o alvo leva KO (está na plataforma de retorno).
	for f in fichas.keys():
		if not is_instance_valid(f):
			fichas.erase(f)
		elif ficha_de(f) > 0 and f.state == State.RESPAWN:
			set_ficha(f, 0)
	super(delta)


## Dados do golpe contra este alvo: abordagem por trás e voz de prisão.
func _attack_for(target: Fighter) -> AttackData:
	var a := attack
	if attack_id == "special_side" and target.facing == facing:
		a = a.duplicate() as AttackData
		a.damage *= BACK_BONUS
		_back_targets.append(target)
	if ficha_de(target) >= FICHAS_MAX:
		a = a.duplicate() as AttackData
		a.damage *= PRISAO_DANO
		a.base_knockback *= PRISAO_LANCE
		a.knockback_growth *= PRISAO_LANCE
		_prisao_target = target
	return a


func _check_hits() -> void:
	if attack_id == "special_neutral":
		return   # "Parado aí!" não machuca (nem ativa contra-ataque)
	super._check_hits()


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == 1:
		_prisao_target = null
		_back_targets.clear()
	match move_id:
		"special_neutral":
			if frame == attack.startup and _roar_cd <= 0.0:
				_parado_ai()
		"special_side":
			if frame >= attack.startup - 2 and frame <= attack.startup + attack.active:
				velocity.x = POUNCE_SPEED * facing
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.2
		"special_up":
			if frame == attack.startup:
				velocity = Vector2(LEAP.x * facing, LEAP.y)
				_attack_in_air = true
				jumped.emit(true)
			elif attack.is_active(frame) and velocity.y > -350.0:
				# bote: agarra a borda de mais longe
				var keep := ledge_reach
				ledge_reach = keep * LEDGE_REACH_BOTE
				_try_grab_ledge()
				ledge_reach = keep
				if state == State.LEDGE:
					attack = null
					attack_id = ""
		"special_down":
			if frame == attack.startup and is_on_floor() and not _attack_in_air:
				_interditar()


func _parado_ai() -> void:
	_roar_cd = ROAR_COOLDOWN
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == self or not f.can_be_hit() or f.state in [State.LEDGE, State.HELD, State.RESPAWN]:
			continue
		var d := f.global_position - global_position
		if absf(d.x) < ROAR_RADIUS and absf(d.y) < 100.0 and signf(d.x) == float(facing):
			if f.state == State.HITSTUN:
				f._launch.x += ROAR_PUSH * facing   # não empilha controle: só empurra
			else:
				f.velocity.x = ROAR_PUSH * facing
				f.lock_facing(facing, ROAR_TURN_LOCK)   # de costas para ela
	for n in get_tree().get_nodes_in_group("projectiles"):
		var p := n as Projectile
		if p == null or p.is_queued_for_deletion() or p.owner_fighter == self:
			continue
		var d := p.global_position - global_position
		if absf(d.x) < ROAR_RADIUS and absf(d.y) < 120.0 and signf(d.x) == float(facing):
			if move_fx != null:
				move_fx.play_at("fx_rugido", p.global_position, 1.0, 0.25, "poof")
			p.queue_free()


func _interditar() -> void:
	if _faixa != null and is_instance_valid(_faixa):
		_faixa.rip()
	_faixa = FaixaInterditada.plant(self, global_position + Vector2(FAIXA_AHEAD * facing, HEIGHT * 0.5))


func _on_hit_landed(target: Fighter, move_id: String) -> void:
	if target == _prisao_target:
		_prisao_target = null
		set_ficha(target, 0)
		if move_fx != null:
			move_fx.event("prisao", target)
		return
	if move_id in PATADAS:
		var add := 2 if target in _back_targets else 1
		var before := ficha_de(target)
		set_ficha(target, mini(FICHAS_MAX, before + add))
		if ficha_de(target) > before and move_fx != null:
			move_fx.event("ficha", target)
