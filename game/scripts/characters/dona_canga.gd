class_name DonaCanga
extends Fighter
## Dona Canga: arara-canga baiana da escola de samba (design/personagens/arara_canga.md).
## Pesada que dança, com um pulo extra no ar (ave). Especiais (rodada 8, só dela):
##  - neutro "Roda de baiana": gira a saia gigante no lugar; puxa quem está perto
##    para dentro (vários toques) e REBATE projéteis. Segurando, gira mais; girar
##    demais deixa ela tonta.
##  - lado "Estandarte da escola": finca a bandeira da escola no palco (uma por vez).
##    Perto dela, todo golpe da Canga conta como "na batida". O adversário derruba
##    a bandeira com 2 golpes.
##  - cima "Esplendor": abre o leque de plumas e sobe; depois cai planando devagar.
##  - baixo "Paradinha da bateria": levanta a mão e a MÚSICA DO JOGO PARA; na volta,
##    explosão de confete lança quem estiver perto.
## Mecânica "Apoteose": a bateria marca um tempo a cada BEAT s (pulso de plumas no
## chão). Golpe na batida tira +20% e enche a nota do desfile; nota cheia =
## Apoteose por APOTEOSE_TIME s (golpes +35%, todo golpe na batida, confete).

const PIX := "res://assets/characters/arara_canga/pixel/"
const BEAT := 0.6
const BEAT_WINDOW := 0.12
const BEAT_BONUS := 1.2
const FLAP_SPEED := 1050.0
const GLIDE_FALL := 220.0
# Roda de baiana
const SPIN_MIN := 30
const SPIN_MAX := 110          # passando disso fica tonta
const SPIN_PULL := 900.0
const SPIN_RADIUS := 150.0
const SPIN_TICK := 9
const DIZZY_TIME := 0.8
# Paradinha
const PARADINHA_SILENCE := 0.7
# Apoteose
const NOTE_PER_HIT := 25.0
const APOTEOSE_TIME := 6.0
const APOTEOSE_BONUS := 1.35

var beat_flash := 0.0
var note := 0.0               # nota do desfile (0-100)
var apoteose := 0.0           # tempo restante de Apoteose
var _beat_clock := 0.0
var _gliding := false
var _spin := 0
var _estandarte: Estandarte
var _confete_t := 0.0
var _dizzy_t := 0.0           # tontura depois de girar demais (pose "tonto")
var _beat_from_flag := false  # o golpe atual só está "na batida" por causa do estandarte
var _spin_scored := false     # a roda de baiana conta 1 vez só para a nota


func _physics_process(delta: float) -> void:
	var before := _beat_clock
	_beat_clock = fmod(_beat_clock + delta, BEAT)
	beat_flash = maxf(beat_flash - delta, 0.0)
	if _dizzy_t > 0.0:
		_dizzy_t = 0.0 if state != State.HITSTUN else maxf(_dizzy_t - delta, 0.0)
	if apoteose > 0.0:
		apoteose = maxf(apoteose - delta, 0.0)
		_confete_t -= delta
		if _confete_t <= 0.0:
			_confete_t = 1.2
			_fx("fx_confete", global_position + Vector2(randf_range(-30, 30), -110), 0.4, false, 1.5)
		if apoteose <= 0.0:
			note = 0.0
	# Pulso de plumas no chão a cada batida (o jogador VÊ o ritmo): a folha
	# (base na linha 57 de 64) mais larga que a saia, com a base no chão.
	if _beat_clock < before and is_on_floor() and visible and state != State.RESPAWN:
		_fx("fx_plumas", global_position + Vector2(0, HEIGHT * 0.5 - 25.0 * 2.6), 0.3, true, 2.6)
	super._physics_process(delta)
	if _gliding:
		if is_on_floor() or state != State.AIR:
			_gliding = false
		elif velocity.y > GLIDE_FALL:
			velocity.y = GLIDE_FALL
	queue_redraw()


## Perto de uma batida da bateria (ou perto do estandarte, ou em Apoteose)?
func on_beat() -> bool:
	if apoteose > 0.0:
		return true
	if _estandarte != null and is_instance_valid(_estandarte) and _estandarte.covers(global_position):
		return true
	return _beat_clock <= BEAT_WINDOW or _beat_clock >= BEAT - BEAT_WINDOW


func _fx(fx_name: String, at: Vector2, time: float, behind := false, px := 2.0) -> PixelFx:
	var path := PIX + fx_name + ".png"
	if not has_art or not ResourceLoader.exists(path):
		return null
	var fx := PixelFx.spawn(get_parent(), load(path), at, time, px)
	if behind:
		# atrás dela mas na frente do cenário (z -1 sumia atrás do fundo da Ruínas)
		fx.z_index = 0
		get_parent().move_child(fx, get_index())
	if facing < 0:
		fx.scale.x = -1.0
	return fx


## Enquanto a roda gira, a folha do especial roda em loop (sem isso, o quadro de
## impacto ficava parado porque o giro reinicia attack_frame a cada passo).
func anim_override() -> Array:
	if attack_id == "special_neutral" and attack != null and attack_frame > attack.startup:
		return ["especial_neutro", 14.0]
	if _dizzy_t > 0.0 and state == State.HITSTUN:
		return ["tonto", 6.0]   # girou demais: tonta (não é "levou golpe")
	return []


func is_dizzy() -> bool:
	return _dizzy_t > 0.0


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == attack.startup and attack.active > 0 and attack.damage > 0.0:
		var bonus := 1.0
		_beat_from_flag = false
		if on_beat():
			bonus *= BEAT_BONUS
			beat_flash = 0.3
			_beat_from_flag = apoteose <= 0.0 and not (_beat_clock <= BEAT_WINDOW or _beat_clock >= BEAT - BEAT_WINDOW)
		if apoteose > 0.0:
			bonus *= APOTEOSE_BONUS
		if bonus > 1.0:
			var scaled := attack.duplicate() as AttackData
			scaled.damage *= bonus
			attack = scaled
	match move_id:
		"special_neutral":
			_spin_step(frame)
		"special_side":
			if frame == attack.startup:
				_plant_flag()
		"special_up":
			if frame == attack.startup:
				velocity.y = -FLAP_SPEED
				_attack_in_air = true
				jumped.emit(true)
				# o leque de plumas abre: penas soltas ficam para trás
				_fx("fx_plumas", global_position + Vector2(0, HEIGHT * 0.5 - 50.0), 0.45, true, 2.0)
		"special_down":
			if frame == 1 and not _attack_in_air:
				Music.paradinha(PARADINHA_SILENCE)
			if frame == attack.startup:
				# a bateria volta: explosão de confete do tamanho da área do golpe
				# e onda de plumas saindo do salto
				_fx("fx_confete", global_position + Vector2(0, -30), 0.5, false, 3.6)
				if is_on_floor():
					_fx("fx_plumas", global_position + Vector2(0, HEIGHT * 0.5 - 25.0 * 3.4), 0.4, false, 3.4)


## Roda de baiana: gira, puxa, acerta várias vezes e rebate projéteis.
func _spin_step(frame: int) -> void:
	if frame < attack.startup:
		_spin = 0
		_spin_scored = false
		return
	_spin += 1
	if _spin >= SPIN_MAX:
		_end_attack()
		hypnotize(DIZZY_TIME)               # girou demais: fica tonta
		_dizzy_t = DIZZY_TIME
		return
	if _spin < SPIN_MIN or controls.pressed("special"):
		attack_frame = attack.startup + 1   # segue girando
	velocity.x = move_toward(velocity.x, 0.0, 40.0)
	if _spin % SPIN_TICK == 0:
		_hit_targets.clear()
	var dt := get_physics_process_delta_time()
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit() or foe.state in [State.HITSTUN, State.LEDGE, State.HELD, State.HOLDING, State.RESPAWN]:
			continue
		var d := global_position - foe.global_position
		if d.length() < SPIN_RADIUS * 1.6 and absf(d.x) > 30.0:
			# puxada para o redemoinho (move_and_collide: não atravessa parede/laje)
			foe.move_and_collide(Vector2(signf(d.x) * SPIN_PULL * 0.3 * dt, 0.0))
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		var p := n as Projectile
		if p == null or p.owner_fighter == self or p.is_queued_for_deletion():
			continue
		if p.global_position.distance_to(global_position) < SPIN_RADIUS:
			# rebatido pela saia: volta mais rápido e agora é dela (o arco da
			# Marianinha não "volta para a mão" de quem rebateu)
			p.velocity = -p.velocity * 1.2
			p.return_after = -1.0
			p.lifetime = maxf(p.lifetime, 1.0)
			p.owner_fighter = self
			_fx("fx_plumas", p.global_position + Vector2(0, -20), 0.25, false, 1.2)


## Finca a bandeira até 110 px à frente, sem atravessar parede (laje da
## Caatinga) e sem ficar no vazio: recua de 10 em 10 px até achar chão (palco ou
## plataforma) logo abaixo (até 80 px atrás dela, se o avanço passou da quina).
## Sem lugar nenhum (no ar), a bandeira cai até o chão (ver Estandarte._settle).
func _plant_flag() -> void:
	if _estandarte != null and is_instance_valid(_estandarte):
		_estandarte.knock_down()
	var space := get_world_2d().direct_space_state
	var feet := global_position + Vector2(0, HEIGHT * 0.5 - 6.0)
	var at := Vector2.INF
	var d := 110.0
	while d >= -80.0:   # negativo: ela já passou da quina no avanço; finca atrás dela
		var p := feet + Vector2(facing * d, 0)
		var wall := space.intersect_ray(PhysicsRayQueryParameters2D.create(feet, p, LAYER_STAGE))
		if wall.is_empty():
			var hit := space.intersect_ray(PhysicsRayQueryParameters2D.create(p, p + Vector2(0, 40), LAYER_STAGE | LAYER_PLATFORM))
			# o mastro fica pelo menos 30 px para dentro da quina (a vitória-régia
			# é oval: na pontinha o desenho fica abaixo da colisão e a bandeira "flutua")
			var q := p + Vector2(facing * 30.0, 0)
			var margin := space.intersect_ray(PhysicsRayQueryParameters2D.create(q, q + Vector2(0, 40), LAYER_STAGE | LAYER_PLATFORM))
			if not hit.is_empty() and not margin.is_empty():
				at = hit.position
				break
		d -= 10.0
	if at == Vector2.INF:
		at = feet if not is_on_floor() else feet + Vector2(0, 6)
	_estandarte = Estandarte.plant(self, at)
	_fx("fx_confete", at + Vector2(0, -70), 0.35, false, 1.2)


func _on_hit_landed(target: Fighter, move_id: String) -> void:
	if beat_flash > 0.0 or apoteose > 0.0:
		# brilho de confete no alvo: o golpe entrou na batida
		_fx("fx_confete", target.global_position + Vector2(0, -30), 0.3, false, 1.3)
	if apoteose > 0.0:
		return
	if beat_flash > 0.0:
		if move_id == "special_neutral":
			if _spin_scored:
				return          # a roda inteira conta como 1 golpe para a nota
			_spin_scored = true
		# Só no ritmo do estandarte (fora da batida de verdade) a nota sobe metade.
		note = minf(note + NOTE_PER_HIT * (0.5 if _beat_from_flag else 1.0), 100.0)
		if note >= 100.0:
			apoteose = APOTEOSE_TIME
			_confete_t = 0.0
			_fx("fx_confete", global_position + Vector2(0, -70), 0.45, false, 1.5)


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_up":
		_gliding = true
	if move_id == "special_neutral":
		_spin = 0


func _draw() -> void:
	super._draw()
	# A coroa pisca no ritmo da bateria (ficha: "a coroa pisca a cada 0,6 s"):
	# brilho dourado em cima da coroa logo depois de cada batida.
	if has_art and visible and state != State.RESPAWN and _beat_clock < 0.15:
		var k := 1.0 - _beat_clock / 0.15
		var c := Vector2(facing * 4.0, -HEIGHT * 0.5 + 2.0)   # no alto do turbante, abaixo da setinha P1
		var r := 5.0 + 5.0 * k
		var gold := Color(1.0, 0.85, 0.25, k)
		draw_colored_polygon(PackedVector2Array([c + Vector2(0, -r * 1.6), c + Vector2(r * 0.35, 0), c + Vector2(0, r * 1.6), c + Vector2(-r * 0.35, 0)]), gold)
		draw_colored_polygon(PackedVector2Array([c + Vector2(-r * 1.6, 0), c + Vector2(0, r * 0.35), c + Vector2(r * 1.6, 0), c + Vector2(0, -r * 0.35)]), gold)
		draw_circle(c, 2.0 + k, Color(1, 1, 1, k))
	if note <= 0.0 and apoteose <= 0.0:
		return
	# Nota do desfile: barrinha acima da cabeça (dourada na Apoteose).
	var w := 56.0
	var y := -HEIGHT * 0.5 - 112.0   # acima do "P1/CPU" (não cobre o texto)
	draw_rect(Rect2(-w * 0.5, y, w, 6), Color(0.1, 0.05, 0.08, 0.7))
	var fill := 1.0 if apoteose > 0.0 else note / 100.0
	var col := Color(1.0, 0.85, 0.2) if apoteose > 0.0 else Color(0.85, 0.15, 0.2)
	draw_rect(Rect2(-w * 0.5 + 1, y + 1, (w - 2) * fill, 4), col)
