class_name Mourisco
extends Fighter
## Mourisco: gato-mourisco jogador de vôlei de praia (design/personagens/mourisco.md,
## design/proposta-rodada11.md). Versátil. Especiais:
##  - neutro "Saque": joga a bola para cima; apertar Especial de novo (ou Ataque)
##    dá a cortada na direção segurada. A bola fica quicando no palco.
##  - lado "Manchete": rebate projéteis dos outros de volta (viram dele) e a bola.
##  - cima "Levantada e cortada": salto altíssimo; no topo, apertar Especial/Ataque
##    crava para baixo (meteoro: joga para baixo, mata fora do palco).
##  - baixo "Peixinho": mergulho rasante na areia; se a bola está perto, levanta.
## Mecânica própria "a bola de vôlei" (bola_volei.gd): fica no palco depois do saque;
## ele (e o adversário!) bate nela com qualquer golpe. Cada golpe dele rebate de um
## jeito (ball_hit): levantar (sem dano), cortar (bola "viva" que machuca) ou rebater.

const SERVE_TOSS_FRAME := 8
const SERVE_TOSS := Vector2(28.0, -640.0)      # x vezes o facing; sai da mão levantada
const SPIKE_SPEED := 1250.0
const SPIKE_REACH := Vector2(40.0, -100.0)     # onde a mão encontra a bola na cortada
const SPIKE_RANGE := 130.0
const REFLECT_REACH := Vector2(60.0, -20.0)
const REFLECT_RADIUS := 90.0
const RISE_SPEED := 1400.0
const DIVE_SPEED := 1500.0
const SLIDE_SPEED := 600.0
const LIFT_RANGE := 170.0

var _ball: BolaVolei = null
var _spike := false
var _crava := false


func ball() -> BolaVolei:
	return _ball if is_instance_valid(_ball) else null


## Como cada golpe dele rebate a bola (chamado pela própria bola quando a área de
## acerto encosta nela). Vazio = usa o ângulo do golpe; {"skip": true} = não rebate.
func ball_hit(_b: BolaVolei, move_id: String, _a: AttackData) -> Dictionary:
	var f := float(facing)
	match move_id:
		"jab", "jab2": return {"v": Vector2(f * 520.0, -430.0), "live": false}       # tapa
		"jab3": return {"v": Vector2(f * 640.0, -820.0), "live": false}              # manchete
		"ftilt": return {"v": Vector2(f * 1350.0, 170.0), "live": true}              # cortada
		"utilt": return {"v": Vector2(f * 70.0, -1080.0), "live": false}             # levantamento
		"dtilt": return {"v": Vector2(f * 720.0, -520.0), "live": true}              # peixinho rasteiro
		"nair": return {"v": Vector2(f * 250.0, -560.0), "live": false}              # bloqueio
		"fair": return {"v": Vector2(f * 1250.0, 340.0), "live": true}               # cortada no ar
		"bair": return {"v": Vector2(-f * 1200.0, -260.0), "live": true}             # bicicleta
		"uair": return {"v": Vector2(f * 60.0, -980.0), "live": false}               # bloqueio para cima
		"dair": return {"v": Vector2(f * 140.0, 1300.0), "live": true}               # cortada para baixo
		"special_side": return {"v": Vector2(f * 1000.0, -520.0), "live": true}      # manchete rebatida
		"special_neutral", "special_down": return {"skip": true}                     # o script cuida
	return {}


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == 1:
		_spike = false
		_crava = false
	match move_id:
		"special_neutral":
			_serve(frame)
		"special_side":
			if frame > attack.startup and frame <= attack.startup + attack.active:
				_reflect()
		"special_up":
			_rise_and_slam(frame)
		"special_down":
			_dive(frame)


## Saque: joga a bola no quadro do arremesso; apertar de novo corta na direção segurada.
func _serve(frame: int) -> void:
	if frame == SERVE_TOSS_FRAME:
		if is_instance_valid(_ball):
			_ball.queue_free()
		_ball = BolaVolei.spawn(self, global_position + Vector2(facing * SERVE_TOSS.x, -48.0), Vector2(facing * 50.0, SERVE_TOSS.y))
	if frame > SERVE_TOSS_FRAME and frame <= attack.startup + attack.active and controls.take("special"):
		_spike = true
	if _spike and frame > attack.startup and frame <= attack.startup + attack.active and is_instance_valid(_ball):
		var hand := global_position + Vector2(SPIKE_REACH.x * facing, SPIKE_REACH.y)
		if _ball.global_position.distance_to(hand) <= SPIKE_RANGE:
			_ball.knock(self, _spike_vector() * SPIKE_SPEED, true)
			_spike = false
			if move_fx != null:
				move_fx.play_at("fx_poof", _ball.global_position, 2.0, 0.3, "poof")


## Direção da cortada: a alavanca; sem alavanca, para frente e um pouco para baixo.
func _spike_vector() -> Vector2:
	var s := controls.stick()
	if s.length() < 0.4:
		return Vector2(facing, 0.35).normalized()
	return s.normalized()


## Manchete: devolve projéteis que chegam na frente dele (passam a ser dele).
func _reflect() -> void:
	var at := global_position + Vector2(REFLECT_REACH.x * facing, REFLECT_REACH.y)
	for n in get_tree().get_nodes_in_group("projectiles"):
		var p := n as Projectile
		if p == null or p.owner_fighter == self or p.is_queued_for_deletion():
			continue
		if p.global_position.distance_to(at) < REFLECT_RADIUS:
			p.velocity = -p.velocity * 1.15
			p.return_after = -1.0
			p.lifetime = maxf(p.lifetime, 1.0)
			p.owner_fighter = self
			if move_fx != null:
				move_fx.play_at("fx_poof", p.global_position, 1.5, 0.25, "poof")


## Levantada e cortada: sobe alto; Especial/Ataque no caminho pula para a cravada.
func _rise_and_slam(frame: int) -> void:
	if frame == 4:
		velocity.y = -RISE_SPEED
		_attack_in_air = true
		jumped.emit(true)
	if frame > 5 and frame < attack.startup and not _crava and (controls.take("special") or controls.take("attack")):
		_crava = true
		attack_frame = attack.startup   # vai direto para o quadro da cravada
		return
	if frame == attack.startup + 1 and _crava:
		var a := attack.duplicate() as AttackData
		a.damage = 11.0
		a.angle = -78.0
		a.base_knockback = 330.0
		a.knockback_growth = 5.5
		a.hitbox_radius = 42.0
		attack = a
	if _crava and frame > attack.startup and frame <= attack.startup + attack.active:
		velocity.y = DIVE_SPEED
		velocity.x = 100.0 * facing


## Peixinho: desliza rasante; no quadro do impacto, levanta a bola se estiver perto.
func _dive(frame: int) -> void:
	if frame == 1 and _attack_in_air:
		velocity.y = maxf(velocity.y, 350.0)
	if frame <= attack.startup + attack.active:
		velocity.x = (SLIDE_SPEED if not _attack_in_air else SLIDE_SPEED * 0.85) * facing
	if frame == attack.startup + 1:
		var b := _ball_near(global_position + Vector2(60.0 * facing, 30.0), LIFT_RANGE)
		if b != null:
			b.knock(self, Vector2(facing * 180.0, -1000.0), false)
			if move_fx != null:
				move_fx.play_at("fx_poof", b.global_position, 2.0, 0.3, "poof")


## A bola de vôlei mais perto de um ponto (qualquer dono), se estiver dentro do alcance.
func _ball_near(at: Vector2, reach: float) -> BolaVolei:
	var best: BolaVolei = null
	var bd := reach
	for n in get_tree().get_nodes_in_group("bolas_volei"):
		var b := n as BolaVolei
		if b == null or b.is_queued_for_deletion():
			continue
		var d := b.global_position.distance_to(at)
		if d <= bd:
			best = b
			bd = d
	return best


func _on_attack_end(_move_id: String) -> void:
	_spike = false
	_crava = false
