class_name Marianinha
extends Fighter
## Marianinha: marianinha-de-cabeça-amarela ginasta (design/personagens/marianinha.md).
## Versátil, pequena e leve, 3 pulos no ar. Especiais (rodada 8: aparelhos de ginástica):
##  - neutro "Fita rítmica": gira a fita longa à frente (vários toques, alcance
##    longo); segurando, segue girando e a fita destrói projéteis.
##  - lado "Arco": lança o arco de ginástica; no chão rola e volta para a mão, no ar
##    voa reto.
##  - cima "Cama elástica": deixa uma mini cama elástica no palco por 6 s e quica
##    nela; QUALQUER um que pisar é lançado para o alto.
##  - baixo "Magnésio": bate palma e solta pó de magnésio; quem estiver na nuvem
##    escorrega (quase sem atrito nem controle no chão).
## Mecânicas: "Quique" (cair na cabeça de alguém: dano leve e pulos de volta) e
## "Nota dos jurados": golpes DIFERENTES que acertam em sequência sobem a nota
## (7 a 10); repetir golpe baixa. Com 10, o próximo golpe tira +50% e solta confete.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PIX := "res://assets/characters/marianinha/pixel/"
const BOUNCE_SPEED := 820.0
const BOUNCE_DAMAGE := 2.0
const BOUNCE_COOLDOWN := 0.35
const RIBBON_TICK := 7
const RIBBON_MAX := 70
const HOOP_SPEED := 760.0
const MAGNESIO_RADIUS := 120.0
const MAGNESIO_SLIP := 1.6
const NOTE_MIN := 7
const NOTE_MAX := 10
const PERFECT_BONUS := 1.5
## Fita: pontos de acerto ao longo da fita desenhada (folha "fita": vai da mão,
## ~40 px à frente, até a ponta, ~530 px; a fita corre baixa, ~20 px abaixo do centro).
const RIBBON_FROM := 40.0
const RIBBON_TO := 530.0
const RIBBON_Y := 20.0
const RIBBON_RADIUS := 36.0
const CONFETE := "res://assets/characters/arara_canga/pixel/fx_confete.png"

var score := NOTE_MIN          # nota dos jurados (7-10)
var _last_scored := ""
var _perfect_ready := false
var _bounce_cooldown := 0.0
var _ribbon := 0
var _cama: CamaElastica
var _use := 0                  # conta cada golpe começado (uma fita inteira = 1 golpe para a nota)
var _scored_use := -1
var _perfect_use := -1         # golpe que gastou o 10 (confete quando acertar)
var _score_pop := 0.0          # plaquinha "pula" quando a nota muda
var _hoop: Projectile
var _hoop_use := -1
var _hooked := {}


func _physics_process(delta: float) -> void:
	_bounce_cooldown = maxf(_bounce_cooldown - delta, 0.0)
	_score_pop = maxf(_score_pop - delta * 4.0, 0.0)
	_hook_foes()
	super._physics_process(delta)
	_try_bounce()
	_guide_hoop(delta)
	queue_redraw()


## O arco é projétil: o acerto dele não passa por _on_hit_landed. Escuta o
## "levei golpe" dos outros para o arco também entrar na nota dos jurados.
func _hook_foes() -> void:
	for f in get_tree().get_nodes_in_group("fighters"):
		if f != self and not _hooked.has(f):
			_hooked[f] = true
			(f as Fighter).hit_taken.connect(_on_foe_hit.bind(f))


func _on_foe_hit(attacker: Node2D, data: AttackData, _launch: Vector2, foe: Fighter) -> void:
	if attacker == self and _hoop_use >= 0 and data != null and data.has_meta("arco"):
		_score_hit(foe, "arco", int(data.get_meta("arco")))


## Arco: não atravessa parede (quica e volta) e, rolando no chão, volta
## quando o chão acaba (não sai voando reto para fora do palco).
func _guide_hoop(delta: float) -> void:
	if _hoop == null or not is_instance_valid(_hoop) or _hoop.is_queued_for_deletion():
		_hoop = null
		return
	if _hoop.owner_fighter != self:
		_hoop = null   # rebatido (roda da Canga): não é mais dela
		return
	var p := _hoop
	var space := get_world_2d().direct_space_state
	var ahead := p.global_position + Vector2(signf(p.velocity.x) * 30.0 + p.velocity.x * delta, 0)
	var wall := space.intersect_ray(PhysicsRayQueryParameters2D.create(p.global_position, ahead, LAYER_STAGE))
	var returning := p.return_after >= 0.0 and p._flight >= p.return_after
	if not wall.is_empty():
		p.velocity.x = -p.velocity.x * 0.8
		if p.return_after < 0.0 or not returning:
			p.return_after = p._flight   # bateu na parede: volta para a mão
		return
	if p.get_meta("chao", false) and not returning:
		var front := p.global_position + Vector2(signf(p.velocity.x) * 34.0, 0)   # borda do arco
		var below := space.intersect_ray(PhysicsRayQueryParameters2D.create(front, front + Vector2(0, 70), LAYER_STAGE | LAYER_PLATFORM))
		if below.is_empty():
			p.velocity.x = -p.velocity.x * 0.8   # o chão acabou: o arco volta na hora
			p.return_after = p._flight


## Quique: pés caindo em cima da cabeça de outro lutador.
func _try_bounce() -> void:
	if _bounce_cooldown > 0.0 or velocity.y <= 50.0 or is_on_floor():
		return
	if state != State.AIR and not (state == State.ATTACK and _attack_in_air):
		return
	var feet := global_position + Vector2(0, HEIGHT * 0.5)
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		var head := foe.hurtbox()
		if feet.x >= head.position.x - 6.0 and feet.x <= head.end.x + 6.0 \
				and feet.y >= head.position.y - 6.0 and feet.y <= head.position.y + 26.0:
			foe.add_damage(BOUNCE_DAMAGE)
			velocity.y = -BOUNCE_SPEED
			jumps_left = air_jumps
			_bounce_cooldown = BOUNCE_COOLDOWN
			if state == State.ATTACK:
				_end_attack()
			state = State.AIR
			jumped.emit(true)
			return


func _fx(fx_name: String, at: Vector2, time: float, px := 2.0) -> PixelFx:
	var path := PIX + fx_name + ".png"
	if not has_art or not ResourceLoader.exists(path):
		return null
	var fx := PixelFx.spawn(get_parent(), load(path), at, time, px)
	if facing < 0:
		fx.scale.x = -1.0
	return fx


## Folha larga da fita enquanto ela está girando (corpo + fita no mesmo desenho).
func anim_override() -> Array:
	if attack_id == "special_neutral" and attack != null and attack_frame > attack.startup:
		return ["fita", 8.0]
	return []


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == 1:
		_use += 1
	# Nota 10: o PRÓXIMO golpe (um só) sai turbinado; o 10 é gasto aqui, no começo
	# dele (antes era gasto no acerto: a fita gastava sem bônus e o arco nunca gastava).
	if frame == attack.startup and attack.active > 0 and attack.damage > 0.0 and _perfect_ready:
		var scaled := attack.duplicate() as AttackData
		scaled.damage *= PERFECT_BONUS
		scaled.base_knockback *= 1.2
		attack = scaled
		_perfect_ready = false
		_perfect_use = _use
		score = NOTE_MIN
		_last_scored = move_id.trim_suffix("_b").trim_suffix("_c")
		_scored_use = _use
		_score_pop = 1.0
	match move_id:
		"special_neutral":
			_ribbon_step(frame)
		"special_side":
			if frame == attack.startup + 1:   # quando a mão já soltou (quadro de impacto)
				_throw_hoop()
		"special_up":
			if frame == attack.startup:
				_place_trampoline()
		"special_down":
			if frame == attack.startup:
				_magnesio()


func _ribbon_step(frame: int) -> void:
	if frame <= attack.startup:
		_ribbon = 0
		return
	_ribbon += 1
	if controls.pressed("special") and _ribbon < RIBBON_MAX:
		attack_frame = attack.startup + 1
	if _ribbon % RIBBON_TICK == 0:
		_hit_targets.clear()
	# Pontos ao longo da fita DESENHADA (da mão até a ponta).
	var base := global_position + Vector2(facing * RIBBON_FROM, RIBBON_Y)
	var tip := global_position + Vector2(facing * RIBBON_TO, RIBBON_Y)
	var pts: Array[Vector2] = []
	for i in 6:
		pts.append(base.lerp(tip, i / 5.0))
	# A fita girando destrói projéteis que encostam nela.
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		var p := n as Projectile
		if p == null or p.owner_fighter == self or p.is_queued_for_deletion():
			continue
		for q in pts:
			if p.global_position.distance_to(q) < RIBBON_RADIUS + 10.0:
				_fx("fx_magnesio", p.global_position, 0.25, 1.0)   # poeirinha: projétil desfeito
				p.queue_free()
				break
	# A fita acerta ao longo dela toda, não só na ponta.
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit() or _hit_targets.has(foe):
			continue
		for q in pts:
			if Combat.circle_hits_rect(q, RIBBON_RADIUS, foe.hurtbox()):
				_hit_targets.append(foe)
				if foe.receive_hit(self, attack, facing):
					_on_hit_landed(foe, "special_neutral")
				break


func _throw_hoop() -> void:
	var at := global_position + Vector2(facing * 40.0, 30.0 if is_on_floor() else -10.0)
	# cópia dos dados: marca o acerto do arco (para a nota) sem confundir com o golpe do corpo
	var data := attack.duplicate() as AttackData
	data.set_meta("arco", _use)
	_hoop_use = _use
	var p := Projectile.spawn(PROJECTILE, self, data, at, Vector2(HOOP_SPEED * facing, 0.0), 1.8)
	if is_on_floor():
		p.return_after = 0.5   # rola pelo chão e volta para a mão
		p.set_meta("chao", true)
	if has_art and ResourceLoader.exists(PIX + "arco.png"):
		p.set_sprite(load(PIX + "arco.png"))
	_hoop = p


func _place_trampoline() -> void:
	if _cama != null and is_instance_valid(_cama):
		_cama.queue_free()
	var at := global_position + Vector2(0, HEIGHT * 0.5)
	# palco OU plataforma (antes atravessava as plataformas e caía no chão de baixo)
	var q := PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, 260), LAYER_STAGE | LAYER_PLATFORM)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	if not hit.is_empty():
		at = hit.position
	_cama = CamaElastica.place(self, at)
	# Ela já sai quicando (é a recuperação); no ar, a cama fica flutuando um instante embaixo.
	velocity.y = -CamaElastica.BOUNCE * 0.85
	_attack_in_air = true
	jumped.emit(true)


func _magnesio() -> void:
	var center := global_position + Vector2(facing * 50.0, 0)
	_fx("fx_magnesio", center + Vector2(0, -10), 0.7, 3.0)   # nuvem do tamanho da área (raio 120)
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		if foe.global_position.distance_to(center) <= MAGNESIO_RADIUS:
			foe.slip(MAGNESIO_SLIP, facing * 260.0)


## Nota dos jurados.
func _on_hit_landed(target: Fighter, move_id: String) -> void:
	_score_hit(target, move_id, _use)


## Cada golpe (uma fita inteira, um arco) conta UMA vez para a nota.
func _score_hit(target: Fighter, move_id: String, use: int) -> void:
	if use == _perfect_use:
		_perfect_use = -1   # o golpe turbinado acertou: confete dos jurados
		if has_art and ResourceLoader.exists(CONFETE):
			PixelFx.spawn(get_parent(), load(CONFETE), target.global_position + Vector2(0, -40), 0.6, 2.5)
		return
	if use == _scored_use:
		return
	_scored_use = use
	var base := move_id.trim_suffix("_b").trim_suffix("_c")
	if base == "arco":
		base = "special_side"
	var before := score
	if base == _last_scored:
		score = maxi(NOTE_MIN, score - 1)
	else:
		score = mini(NOTE_MAX, score + 1)
		if score >= NOTE_MAX:
			_perfect_ready = true
	_last_scored = base
	if score != before:
		_score_pop = 1.0


func _draw() -> void:
	super._draw()
	if score <= NOTE_MIN and not _perfect_ready:
		return
	# Plaquinha do jurado acima da cabeça (dá um pulinho quando a nota muda).
	var y := -HEIGHT * 0.5 - 86.0   # acima da setinha "P1"
	var col := Color(1.0, 0.85, 0.2) if _perfect_ready else Color(1, 1, 1)
	var s := 1.0 + 0.35 * _score_pop
	draw_set_transform(Vector2(0, y + 11), 0.0, Vector2(s, s))
	draw_line(Vector2(0, 11), Vector2(0, 17), Color(0.16, 0.06, 0.1, 0.9), 3.0)   # cabinho da plaquinha
	draw_rect(Rect2(-17, -11, 34, 22), Color(0.16, 0.06, 0.1, 0.9))
	draw_rect(Rect2(-15, -9, 30, 18), col)
	draw_string(ThemeDB.fallback_font, Vector2(-16, 6), "%d" % score if score < 10 else "10", HORIZONTAL_ALIGNMENT_CENTER, 32, 16, Color(0.16, 0.06, 0.1))
	draw_set_transform(Vector2.ZERO)
