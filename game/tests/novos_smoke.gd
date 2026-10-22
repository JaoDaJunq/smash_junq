extends Node
## Teste de fumaça dos 4 personagens da rodada 7 (Dona Canga, Marianinha, Mestra
## Sucuri, Seu Peba): golpes básicos acertam e a mecânica de cada um funciona.
## Personagem sem sprites importados ainda é pulado (aparece como PULADO).
##   godot --headless --path game res://tests/novos_smoke.tscn [-- <id> ...]

const MATCH := preload("res://scenes/match.tscn")

var results: Array[String] = []
var failures := 0
var me: Fighter
var foe: Fighter
var _match: Node


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var only := OS.get_cmdline_user_args()
	for id in ["arara_canga", "marianinha", "sucuri", "tatu_peba", "tucano", "onca", "cutia", "calango"]:
		if not only.is_empty() and id not in only:
			continue
		var idx := -1
		for i in Game.CHARACTERS.size():
			if Game.CHARACTERS[i].get("id", "") == id:
				idx = i
		_check("%s está no elenco" % id, idx >= 0, str(idx))
		if idx < 0:
			continue
		if not Game.character_ready(idx):
			results.append("[PULADO] %s: sprites ainda não importados" % id)
			continue
		await _start(idx)
		await _basics(id)
		match id:
			"arara_canga": await _canga()
			"marianinha": await _marianinha()
			"sucuri": await _sucuri()
			"tatu_peba": await _peba()
			"tucano": await _tucao()
			"onca": await _onca()
			"cutia": await _cutia()
			"calango": await _calango()
		_match.queue_free()
		await _frames(5)
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _start(idx: int) -> void:
	Game.set_character("p1", idx)
	Game.set_character("p2", 0)
	_match = MATCH.instantiate()
	add_child(_match)
	await _frames(240)
	for f in _match.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f
		else:
			foe = f
	_check("%s com arte" % me.display_name, me.has_art, "")


func _basics(id: String) -> void:
	for mv in ["jab", "ftilt", "dtilt"]:
		await _face_off()
		me.start_attack(mv)
		await _frames(45)
		_check("%s: %s acerta" % [id, mv], foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for kind in ["neutral", "side", "up", "down"]:
		await _face_off()
		me.start_special(kind)
		await _frames(90)
		_check("%s: especial %s roda sem travar" % [id, kind], me.state != Fighter.State.ATTACK or me.attack_frame < 400, Fighter.State.keys()[me.state])


func _canga() -> void:
	var c := me as DonaCanga
	# Roda de baiana: puxa quem está perto e rebate projétil
	await _face_off(200.0)
	var x0 := foe.global_position.x
	Input.action_press("p1_special")
	c.start_special("neutral")
	await _frames(40)
	_check("Canga: roda de baiana puxa o adversário", foe.global_position.x < x0 - 20.0 or foe.damage_percent > 0.0,
		"%.0f px, %.1f%%" % [x0 - foe.global_position.x, foe.damage_percent])
	foe.global_position = Vector2(3000, -3000)   # longe: o rebatido não acerta ninguém
	var shot := AttackData.new()
	shot.damage = 3.0
	shot.hitbox_radius = 10.0
	var p := Projectile.spawn(load("res://scenes/combat/projectile.tscn"), foe, shot, c.global_position + Vector2(120, -20), Vector2(-500, 0), 2.0)
	await _frames(12)
	_check("Canga: roda rebate projétil", is_instance_valid(p) and p.owner_fighter == c and p.velocity.x > 0.0, "")
	await _frames(130)
	Input.action_release("p1_special")
	_check("Canga: girar demais deixa tonta", c.state == Fighter.State.HITSTUN or c.state == Fighter.State.IDLE, Fighter.State.keys()[c.state])
	await _frames(70)
	# Estandarte: fica no palco e perto dele todo golpe é na batida
	await _face_off(300.0)
	c.start_special("side")
	await _frames(40)
	var flags := get_tree().get_nodes_in_group("estandartes").filter(func(e: Node) -> bool: return e._fall < 0.0)
	_check("Canga: estandarte fincado no palco", flags.size() == 1, str(flags.size()))
	c._beat_clock = DonaCanga.BEAT * 0.5
	_check("Canga: perto do estandarte está sempre no ritmo", c.on_beat(), "")
	# Golpe na batida tira mais
	var off := await _jab_damage(false)
	var on := await _jab_damage(true)
	_check("Canga: golpe na batida tira mais", on > off * 1.15, "%.1f x %.1f" % [on, off])
	# Apoteose: 4 golpes na batida enchem a nota
	for e in get_tree().get_nodes_in_group("estandartes"):
		e.queue_free()
	await _frames(2)
	c.note = 0.0
	for i in 4:
		await _jab_damage(true)
	_check("Canga: 4 golpes na batida = Apoteose", c.apoteose > 0.0, "nota %.0f" % c.note)
	c.apoteose = 0.0
	c.note = 0.0
	# Paradinha: roda sem travar e lança
	await _face_off(80.0)
	c.start_special("down")
	await _frames(70)
	_check("Canga: paradinha lança quem está perto", foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	# Esplendor: sobe e depois cai planando
	await _place(c, Vector2(-200, -300))
	c.start_special("up")
	await _frames(60)
	var vy := 0.0
	for i in 40:
		await get_tree().physics_frame
		vy = maxf(vy, c.velocity.y)
	_check("Canga: depois do esplendor cai planando", vy <= DonaCanga.GLIDE_FALL + 1.0, "%.0f" % vy)


func _jab_damage(on_beat: bool) -> float:
	await _face_off()
	var c := me as DonaCanga
	if not on_beat:
		for e in get_tree().get_nodes_in_group("estandartes"):
			e.queue_free()
		await _frames(2)
	# acerta a batida (ou o meio entre duas) exatamente no primeiro quadro ativo
	var lead := float(c.moveset.ftilt.startup + 1) / 60.0
	c._beat_clock = fposmod((0.0 if on_beat else DonaCanga.BEAT * 0.5) - lead, DonaCanga.BEAT)
	c.start_attack("ftilt")
	await _frames(45)
	return foe.damage_percent


func _marianinha() -> void:
	var m := me as Marianinha
	_check("Marianinha: 3 pulos no ar", m.air_jumps == 3, str(m.air_jumps))
	# Quique: cai em cima da cabeça do outro e sobe de novo
	await _face_off(0.0)
	await _frames(20)
	m.global_position = foe.global_position + Vector2(0, -170)
	m.velocity = Vector2(0, 400)
	m.state = Fighter.State.AIR
	m.jumps_left = 0
	var bounced := false
	for i in 40:
		await get_tree().physics_frame
		if m.velocity.y < -500.0:
			bounced = true
			break
	_check("Marianinha: quica na cabeça e recupera os pulos", bounced and m.jumps_left == 3 and foe.damage_percent > 0.0,
		"quicou=%s pulos=%d dano=%.1f" % [bounced, m.jumps_left, foe.damage_percent])
	# Fita: alcance longo e vários toques
	await _face_off(140.0)
	Input.action_press("p1_special")
	m.start_special("neutral")
	await _frames(5)
	var started := "%s me=%s foe=%s %s hit=%s inv=%.2f" % [m.attack_id, m.global_position.round(), foe.global_position.round(), Fighter.State.keys()[foe.state], foe.can_be_hit(), foe.invincible_time]
	await _frames(45)
	Input.action_release("p1_special")
	await _frames(30)
	_check("Marianinha: fita acerta de longe várias vezes", foe.damage_percent >= 5.0, "%.1f%% (%s)" % [foe.damage_percent, started])
	# Arco: no chão rola e volta
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	m.start_special("side")
	var far := 0.0
	var back := false
	for i in 200:
		await get_tree().physics_frame
		var ps := get_tree().get_nodes_in_group("match_cleanup").filter(func(n: Node) -> bool: return n is Projectile)
		if not ps.is_empty():
			far = maxf(far, absf((ps[0] as Node2D).global_position.x - m.global_position.x))
		elif far > 100.0:
			back = true
			break
	_check("Marianinha: arco vai e volta", back and far > 200.0, "%.0f px" % far)
	# Cama elástica: fica no palco e lança quem pisar
	await _face_off(400.0)
	m.start_special("up")
	await _frames(10)
	var camas := get_tree().get_nodes_in_group("camas_elasticas")
	_check("Marianinha: cama elástica no palco", camas.size() == 1, str(camas.size()))
	if camas.size() == 1:
		var cama := camas[0] as Node2D
		await _frames(60)
		foe.global_position = cama.global_position + Vector2(0, -Fighter.HEIGHT * 0.5 - 60)
		foe.velocity = Vector2(0, 300)
		foe.state = Fighter.State.AIR
		var launched := false
		for i in 30:
			await get_tree().physics_frame
			if foe.velocity.y < -900.0:
				launched = true
				break
		_check("Marianinha: adversário que pisa na cama é lançado", launched, "%.0f" % foe.velocity.y)
	await _frames(60)
	# Magnésio: quem está perto escorrega
	await _face_off(70.0)
	m.start_special("down")
	await _frames(20)
	_check("Marianinha: magnésio faz escorregar", foe.slip_time > 0.5, "%.2f" % foe.slip_time)
	# Nota dos jurados: golpes diferentes sobem a nota
	m.score = Marianinha.NOTE_MIN
	m._last_scored = ""
	for mv in ["jab", "ftilt", "dtilt"]:
		await _face_off()
		m.start_attack(mv)
		await _frames(45)
	_check("Marianinha: 3 golpes diferentes = nota 10", m.score == 10 and m._perfect_ready, "nota %d" % m.score)
	await _face_off()
	m.start_attack("jab")
	await _frames(45)
	_check("Marianinha: nota 10 dá golpe turbinado", foe.damage_percent > 3.0, "%.1f%%" % foe.damage_percent)


func _sucuri() -> void:
	var s := me as MestraSucuri
	# Hipnose: quem está à frente fica parado sem dano
	await _face_off(150.0)
	s.start_special("neutral")
	await _frames(16)
	_check("Sucuri: hipnose para o adversário sem dano", foe.state == Fighter.State.HITSTUN and foe.damage_percent == 0.0, Fighter.State.keys()[foe.state])
	await _frames(60)
	# Laço: pega de longe e puxa para o agarrão
	await _face_off(170.0)
	s.start_special("side")
	var grabbed := false
	for i in 40:
		await get_tree().physics_frame
		if s.state == Fighter.State.HOLDING and s.holding == foe:
			grabbed = true
			break
	_check("Sucuri: laço pega de longe e puxa para o agarrão", grabbed and absf(foe.global_position.x - s.global_position.x) < 120.0,
		"%s, dist %.0f" % [Fighter.State.keys()[s.state], absf(foe.global_position.x - s.global_position.x)])
	# Aperto: segura bastante e cada Ataque tira mais
	if grabbed:
		var d0 := foe.damage_percent
		for i in 3:
			Input.action_press("p1_attack")
			await _frames(2)
			Input.action_release("p1_attack")
			await _frames(18)
		_check("Sucuri: apertos tiram dano", foe.damage_percent >= d0 + 5.0, "%.1f -> %.1f" % [d0, foe.damage_percent])
	await _frames(240)
	# Abraço: quem encosta fica preso e é apertado
	await _face_off(50.0)
	s.start_special("down")
	await _frames(14)
	_check("Sucuri: abraço prende quem encosta", s.holding == foe, str(s.holding))
	await _frames(80)
	_check("Sucuri: abraço aperta e arremessa", foe.damage_percent >= 8.0 and s.holding == null, "%.1f%%" % foe.damage_percent)


func _peba() -> void:
	# Casco: pelas costas tira metade
	await _face_off()
	me.facing = -1   # de costas para o adversário (que está à direita)
	foe.start_attack("ftilt")
	await _frames(40)
	var back := me.damage_percent
	await _face_off()
	foe.start_attack("ftilt")
	await _frames(40)
	var front := me.damage_percent
	_check("Peba: pelas costas o casco segura metade", back > 0.0 and back <= front * 0.6, "costas %.1f x frente %.1f" % [back, front])
	# Toca: reaparece mais à frente sem sair do palco
	await _place(me, Vector2(-200, -60), 1)
	foe.global_position = Vector2(3000, -3000)
	await _frames(15)
	var x0 := me.global_position.x
	me.start_special("down")
	await _frames(60)
	_check("Peba: toca reaparece mais à frente, no chão", me.global_position.x > x0 + 120.0 and me.is_on_floor() and me.visible,
		"%.0f px, chão=%s" % [me.global_position.x - x0, me.is_on_floor()])


func _tucao() -> void:
	# Bico blindado: apanha durante a bicada forte, mas não é interrompido
	await _face_off(70.0)
	me.start_attack("ftilt")
	await _frames(1)
	foe.facing = -1
	foe.start_attack("jab")
	await _frames(6)
	_check("Tucão: bico blindado aguenta o golpe sem parar", me.damage_percent > 0.0 and me.attack_id == "ftilt",
		"dano %.1f, golpe=%s" % [me.damage_percent, me.attack_id])
	# Fora do bico, apanha normal
	await _face_off()
	foe.start_attack("ftilt")
	await _frames(20)
	_check("Tucão: fora do bico apanha normal", me.state == Fighter.State.HITSTUN or me.damage_percent > 0.0, Fighter.State.keys()[me.state])
	# Pipoca: 3 pipocas em leque
	await _face_off(400.0)
	me.start_special("neutral")
	await _frames(16)
	var n := 0
	for c in _match.find_children("*", "Projectile", true, false):
		if c.owner_fighter == me:
			n += 1
	_check("Tucão: punhado solta 3 pipocas", n == 3, str(n))
	# Voo de bico sobe
	await _face_off(400.0)
	var y0 := me.global_position.y
	me.start_special("up")
	await _frames(20)
	_check("Tucão: voo de bico sobe", me.global_position.y < y0 - 120.0, "%.0f px" % (y0 - me.global_position.y))


func _onca() -> void:
	var o := me as DonaOnca
	# Ficha corrida: patada carimba ficha
	await _face_off()
	o.set_ficha(foe, 0)
	me.start_attack("ftilt")
	await _frames(40)
	var normal := foe.damage_percent
	_check("Onça: patada carimba ficha", o.ficha_de(foe) == 1, str(o.ficha_de(foe)))
	# Com 3 fichas, a voz de prisão bate mais forte e zera
	await _face_off()
	o.set_ficha(foe, 3)
	me.start_attack("ftilt")
	await _frames(40)
	_check("Onça: voz de prisão bate mais forte e zera a ficha", foe.damage_percent > normal * 1.3 and o.ficha_de(foe) == 0,
		"%.1f x %.1f, ficha %d" % [foe.damage_percent, normal, o.ficha_de(foe)])
	# Rugido empurra para trás
	await _face_off(150.0)
	var x0 := foe.global_position.x
	me.start_special("neutral")
	await _frames(40)
	_check("Onça: rugido empurra", foe.global_position.x > x0 + 60.0, "%.0f px" % (foe.global_position.x - x0))
	o.set_ficha(foe, 0)


func _cutia() -> void:
	# Enterra castanha: vira armadilha que estoura quando o adversário pisa
	await _face_off(400.0)
	me.start_special("down")
	await _frames(40)
	var n := get_tree().get_nodes_in_group("castanhas_enterradas").size()
	_check("Cutia: enterra castanha", n == 1, str(n))
	await _frames(30)
	var trap: Node2D = get_tree().get_nodes_in_group("castanhas_enterradas")[0] if n > 0 else null
	if trap != null:
		await _place(foe, Vector2(trap.global_position.x, -60), -1)
		await _frames(25)
		_check("Cutia: castanha estoura em quem pisa", foe.damage_percent > 0.0 and get_tree().get_nodes_in_group("castanhas_enterradas").is_empty(),
			"%.1f%%" % foe.damage_percent)
	# Saquinho voa em arco e acerta de longe
	await _face_off(260.0)
	me.start_special("neutral")
	await _frames(60)
	_check("Cutia: saquinho acerta de longe", foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for c in get_tree().get_nodes_in_group("castanhas_enterradas"):
		c.queue_free()


func _calango() -> void:
	var c := me as Calango
	# Areia: o próximo golpe do adversário erra
	await _face_off(120.0)
	me.start_special("neutral")
	await _frames(30)
	_check("Calango: areia nos olhos", foe.sand_time > 0.0, "%.1f s" % foe.sand_time)
	await _face_off()
	foe.sand_time = 2.0
	foe.facing = -1
	foe.start_attack("ftilt")
	await _frames(40)
	_check("Calango: com areia o golpe erra", me.damage_percent == 0.0, "%.1f%%" % me.damage_percent)
	# Rabo solto: golpe forte com dano alto não lança
	await _face_off()
	c.tail_ready = true
	me.damage_percent = 150.0
	foe.facing = -1
	foe.start_attack("ftilt")
	await _frames(30)
	_check("Calango: rabo solto segura o lançamento", not c.tail_ready and absf(me.global_position.x + 200.0) < 200.0,
		"rabo=%s x=%.0f" % [c.tail_ready, me.global_position.x])
	# Tomar sol: fica mais rápido
	await _face_off(400.0)
	var base: float = c._base_speeds.y
	me.start_special("down")
	await _frames(40)
	_check("Calango: sol acelera", c.has_sun() and me.run_speed > base * 1.2, "%.0f -> %.0f" % [base, me.run_speed])


func _face_off(gap := 70.0) -> void:
	for n in get_tree().get_nodes_in_group("camas_elasticas") + get_tree().get_nodes_in_group("estandartes"):
		n.queue_free()
	await _place(me, Vector2(-200, -60), 1)
	await _place(foe, Vector2(-200 + gap, -60), -1)
	await _frames(20)
	me.damage_percent = 0.0
	foe.damage_percent = 0.0


func _place(f: Fighter, pos: Vector2, face := 1) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstop = 0
	f._hitstun = 0.0
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	f.slip_time = 0.0
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1
