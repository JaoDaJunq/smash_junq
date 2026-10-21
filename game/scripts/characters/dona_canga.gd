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


func _physics_process(delta: float) -> void:
	var before := _beat_clock
	_beat_clock = fmod(_beat_clock + delta, BEAT)
	beat_flash = maxf(beat_flash - delta, 0.0)
	if apoteose > 0.0:
		apoteose = maxf(apoteose - delta, 0.0)
		_confete_t -= delta
		if _confete_t <= 0.0:
			_confete_t = 0.45
			_fx("fx_confete", global_position + Vector2(randf_range(-40, 40), -110), 0.5)
		if apoteose <= 0.0:
			note = 0.0
	# Pulso de plumas no chão a cada batida (o jogador VÊ o ritmo).
	if _beat_clock < before and is_on_floor() and visible and state != State.RESPAWN:
		_fx("fx_plumas", global_position + Vector2(0, HEIGHT * 0.5 - 18), 0.35, true, 1.5)
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


func _fx(fx_name: String, at: Vector2, time: float, behind := false, px := 2.0) -> void:
	var path := PIX + fx_name + ".png"
	if has_art and ResourceLoader.exists(path):
		var fx := PixelFx.spawn(get_parent(), load(path), at, time, px)
		if behind:
			fx.z_index = -1


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == attack.startup and attack.active > 0 and attack.damage > 0.0:
		var bonus := 1.0
		if on_beat():
			bonus *= BEAT_BONUS
			beat_flash = 0.3
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
		"special_down":
			if frame == 1 and not _attack_in_air:
				Music.paradinha(PARADINHA_SILENCE)
			if frame == attack.startup:
				_fx("fx_confete", global_position + Vector2(0, -40), 0.6)


## Roda de baiana: gira, puxa, acerta várias vezes e rebate projéteis.
func _spin_step(frame: int) -> void:
	if frame < attack.startup:
		_spin = 0
		return
	_spin += 1
	if _spin >= SPIN_MAX:
		_end_attack()
		hypnotize(DIZZY_TIME)               # girou demais: fica tonta
		return
	if _spin < SPIN_MIN or controls.pressed("special"):
		attack_frame = attack.startup + 1   # segue girando
	velocity.x = move_toward(velocity.x, 0.0, 40.0)
	if _spin % SPIN_TICK == 0:
		_hit_targets.clear()
	var dt := get_physics_process_delta_time()
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit() or foe.state == State.HITSTUN:
			continue
		var d := global_position - foe.global_position
		if d.length() < SPIN_RADIUS * 1.6 and absf(d.x) > 30.0:
			foe.global_position.x += signf(d.x) * SPIN_PULL * 0.3 * dt   # puxada para o redemoinho
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		var p := n as Projectile
		if p == null or p.owner_fighter == self:
			continue
		if p.global_position.distance_to(global_position) < SPIN_RADIUS:
			p.velocity = -p.velocity
			p.owner_fighter = self   # rebatido: agora é dela


func _plant_flag() -> void:
	if _estandarte != null and is_instance_valid(_estandarte):
		_estandarte.knock_down()
	var at := global_position + Vector2(facing * 110.0, HEIGHT * 0.5)
	var q := PhysicsRayQueryParameters2D.create(at + Vector2(0, -60), at + Vector2(0, 400), LAYER_STAGE)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	if not hit.is_empty():
		at = hit.position
	_estandarte = Estandarte.plant(self, at)


func _on_hit_landed(_target: Fighter, _move_id: String) -> void:
	if apoteose > 0.0:
		return
	if beat_flash > 0.0:
		note = minf(note + NOTE_PER_HIT, 100.0)
		if note >= 100.0:
			apoteose = APOTEOSE_TIME
			_confete_t = 0.0
			_fx("fx_confete", global_position + Vector2(0, -70), 0.7)


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_up":
		_gliding = true
	if move_id == "special_neutral":
		_spin = 0


func _draw() -> void:
	super._draw()
	if note <= 0.0 and apoteose <= 0.0:
		return
	# Nota do desfile: barrinha acima da cabeça (dourada na Apoteose).
	var w := 56.0
	var y := -HEIGHT * 0.5 - 44.0
	draw_rect(Rect2(-w * 0.5, y, w, 6), Color(0.1, 0.05, 0.08, 0.7))
	var fill := 1.0 if apoteose > 0.0 else note / 100.0
	var col := Color(1.0, 0.85, 0.2) if apoteose > 0.0 else Color(0.85, 0.15, 0.2)
	draw_rect(Rect2(-w * 0.5 + 1, y + 1, (w - 2) * fill, 4), col)
