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
	for id in ["arara_canga", "marianinha", "sucuri", "tatu_peba", "tucano", "onca", "cutia", "calango", "bugio"]:
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
			"bugio": await _berrante()
			"tucano":
				await _tucao()
				await _tucao_r12()
			"onca":
				await _onca()
				await _onca_r12()
			"cutia":
				await _cutia()
				await _cutia_r12()
			"calango":
				await _calango()
				await _calango_r12()
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
	# Laço interrompido pelo pouso: a Sucuri laça no ar, pousa no meio do puxão
	# e o laçado tem de ficar livre (antes ficava seguro até o fim da partida).
	await _face_off(170.0)
	s.global_position.y -= 70.0
	s.state = Fighter.State.AIR
	await _frames(1)
	s.start_special("side")
	var caught := false
	var landed_mid := false
	for i in 60:
		await get_tree().physics_frame
		if s.holding == foe and s.attack_id == "special_side":
			caught = true
		if caught and s.attack_id != "special_side" and s.state != Fighter.State.HOLDING:
			landed_mid = true
			break
		if s.state == Fighter.State.HOLDING:
			break   # o puxão terminou antes do pouso
	print("Sucuri laço: pouso natural no meio do laço = %s" % landed_mid)
	if caught and not landed_mid and s.attack_id == "special_side" and s.holding == foe:
		s._land_during_attack()   # garante o caminho do pouso no meio do laço
		landed_mid = true
	await _frames(30)
	_check("Sucuri: pouso no meio do laço solta o laçado", caught and landed_mid and foe.held_by == null \
		and foe.state != Fighter.State.HELD and s.holding == null and foe.can_be_hit(),
		"pegou=%s pousou=%s estado=%s" % [caught, landed_mid, Fighter.State.keys()[foe.state]])
	await _frames(60)
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
	# "Parado aí!" (antigo rugido) empurra para trás — agora empurra pouco (ROAR_PUSH 420)
	await _face_off(150.0)
	var x0 := foe.global_position.x
	me.start_special("neutral")
	await _frames(40)
	_check("Onça: rugido empurra", foe.global_position.x > x0 + 15.0, "%.0f px" % (foe.global_position.x - x0))
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
	# Tomar sol: fica mais rápido (segurando o botão junta os 3 níveis)
	await _face_off(400.0)
	var base: float = c._base_speeds.y
	Input.action_press("p1_special")
	me.start_special("down")
	await _frames(70)
	Input.action_release("p1_special")
	await _frames(10)
	_check("Calango: sol acelera", c.has_sun() and me.run_speed > base * 1.2, "%.0f -> %.0f" % [base, me.run_speed])


func _berrante() -> void:
	var b := me as Berrante
	b.set_volume(0)
	b.rouco_time = 0.0
	# Berro empurra e sobe o volume
	await _face_off(150.0)
	var x0 := foe.global_position.x
	me.start_special("neutral")
	await _frames(40)
	_check("Berrante: berro empurra", foe.global_position.x > x0 + 50.0, "%.0f px" % (foe.global_position.x - x0))
	_check("Berrante: berro sobe o volume", b.volume == 1, str(b.volume))
	# Volume no máximo: próximo berro deixa rouco
	await _face_off(400.0)
	b.set_volume(4)
	me.start_special("down")
	await _frames(40)
	_check("Berrante: no máximo fica rouco", b.is_rouco() and b.volume == 0, "rouco=%s vol=%d" % [b.is_rouco(), b.volume])
	b.rouco_time = 0.0
	# Teste do som: susto faz pular, sem dano
	await _face_off(120.0)
	var fy := foe.global_position.y
	me.start_special("down")
	var top := fy
	for i in 30:
		await _frames(1)
		top = minf(top, foe.global_position.y)
	_check("Berrante: teste do som faz pular sem dano", foe.damage_percent == 0.0 and top < fy - 15.0,
		"dano %.1f subiu %.0f px" % [foe.damage_percent, fy - top])
	# Berro foguete sobe
	await _face_off(400.0)
	b.set_volume(0)
	var y0 := me.global_position.y
	me.start_special("up")
	await _frames(20)
	_check("Berrante: berro foguete sobe", me.global_position.y < y0 - 100.0, "%.0f px" % (y0 - me.global_position.y))
	b.set_volume(0)


func _face_off(gap := 70.0) -> void:
	for n in get_tree().get_nodes_in_group("camas_elasticas") + get_tree().get_nodes_in_group("estandartes") \
			+ get_tree().get_nodes_in_group("faixas") + get_tree().get_nodes_in_group("iscas"):
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
	f.turn_lock = 0.0
	f.sand_time = 0.0
	f.invincible_time = 0.0
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1


# --- Rodada 12: mecânicas novas dos 4 (design/revisao/novos_personagens.md) ---

func _tucao_r12() -> void:
	var t := me as Tucao
	_check("Tucão: 2 pulos no ar (ave)", t.air_jumps == 2, str(t.air_jumps))
	_check("Tucão: bicada final do jab (jab3) é blindada", "jab3" in Tucao.BICO and not "jab_c" in Tucao.BICO and not "special_up" in Tucao.BICO, str(Tucao.BICO))
	# Blindagem tem limite: golpe de 20% atravessa
	await _face_off(300.0)
	me.start_attack("ftilt")
	await _frames(2)
	var big := AttackData.new()
	big.damage = 20.0
	big.angle = 45.0
	big.base_knockback = 300.0
	big.knockback_growth = 3.0
	me.receive_hit(foe, big, -1)
	_check("Tucão: blindagem para em 12% (smash de 20% derruba)", me.state == Fighter.State.HITSTUN, Fighter.State.keys()[me.state])
	# Blindagem aguentou: estalo visível (evento armor)
	await _face_off(300.0)
	me.start_attack("ftilt")
	await _frames(2)
	var small := AttackData.new()
	small.damage = 3.0
	small.base_knockback = 100.0
	me.receive_hit(foe, small, -1)
	await _frames(1)
	_check("Tucão: blindagem mostra o estalo", _fx_count("tranco") + _fx_count("fx_trave_tranco") > 0 and me.attack_id == "ftilt", me.attack_id)
	# Pipoca em arco que acerta e estoura
	await _face_off(260.0)
	me.start_special("neutral")
	await _frames(14)
	var arc := false
	for p in _projectiles(me):
		arc = arc or (p.gravity > 0.0 and p.bounces == 1)
	var hit := false
	var pop := false
	for i in 60:
		await get_tree().physics_frame
		hit = hit or foe.damage_percent > 0.0
		pop = pop or _fx_count("fx_pipoca_estouro") > 0
	_check("Tucão: pipocas em arco (gravidade + 1 quique)", arc, "")
	_check("Tucão: pipoca acerta e estoura (gancho de projétil)", hit and pop, "dano %.1f, estouro %s" % [foe.damage_percent, pop])
	# Gol de peixinho: parede alta à frente = trave (para e fica tonto)
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	var wall := _wall(Vector2(me.global_position.x + 170.0, -300.0))
	await _frames(2)
	var n0 := t.trave_count
	me.start_special("side")
	await _frames(40)
	_check("Tucão: peixinho bate na trave (parede) e fica tonto", t.trave_count == n0 + 1, "traves %d, %s" % [t.trave_count - n0, Fighter.State.keys()[me.state]])
	wall.queue_free()
	await _frames(2)
	# Faixa "Interditado" também é trave
	await _face_off(600.0)
	var fx := FaixaInterditada.plant(foe, me.global_position + Vector2(220.0, Fighter.HEIGHT * 0.5))
	foe.global_position = Vector2(3000, -3000)
	await _frames(2)
	n0 = t.trave_count
	me.start_special("side")
	await _frames(40)
	_check("Tucão: faixa da Onça conta como trave", fx != null and t.trave_count == n0 + 1, "traves %d" % (t.trave_count - n0))
	# Peixinho no ar vai reto (não cai)
	await _place(me, Vector2(-200, -400), 1)
	foe.global_position = Vector2(3000, -3000)
	me.start_special("side")
	await _frames(12)
	var y1 := me.global_position.y
	await _frames(8)
	_check("Tucão: peixinho no ar vai reto", absf(me.global_position.y - y1) < 6.0, "%.0f px" % (me.global_position.y - y1))
	await _frames(40)
	# Cabeceio rebate projétil para a frente
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	var shot := AttackData.new()
	shot.damage = 4.0
	shot.hitbox_radius = 10.0
	var p := Projectile.spawn(load("res://scenes/combat/projectile.tscn"), foe, shot, me.global_position + Vector2(90, -110), Vector2(-260, 0), 2.0)
	me.start_special("up")
	var headed := false
	for i in 30:
		await get_tree().physics_frame
		if is_instance_valid(p) and p.owner_fighter == me and p.velocity.x > 0.0:
			headed = true
			break
	_check("Tucão: cabeceio rebate o projétil (vira dele, 1.5x)", headed and p.data.damage > 5.0, "")
	if is_instance_valid(p):
		p.queue_free()
	await _frames(60)
	# Pilão no chão: 4 pipocas sobem; errou = bico entala (castigo)
	await _face_off(500.0)
	foe.global_position = Vector2(3000, -3000)
	me.start_special("down")
	var a: AttackData = me.attack
	var normal_len := a.startup + a.active + a.recovery
	var up := 0
	var len := 0
	for i in 140:
		await get_tree().physics_frame
		if me.attack_id == "special_down":
			len += 1
		for q in _projectiles(me):
			if q.velocity.y < -300.0:
				up = maxi(up, _projectiles(me).size())
	_check("Tucão: pilão no chão solta 4 pipocas", up == 4, str(up))
	_check("Tucão: bico entala quando erra (+%d quadros)" % Tucao.STUCK_EXTRA, len >= normal_len + Tucao.STUCK_EXTRA - 2, "%d x %d" % [len, normal_len])


func _onca_r12() -> void:
	var o := me as DonaOnca
	_check("Onça: patadas do jab são jab2/jab3 (sem nair)", "jab2" in DonaOnca.PATADAS and "jab3" in DonaOnca.PATADAS and not "nair" in DonaOnca.PATADAS and not "jab_b" in DonaOnca.PATADAS, "")
	# Prisão só turbina contra quem tem a ficha cheia
	await _face_off()
	o.set_ficha(foe, 0)
	me.start_attack("ftilt")
	var plain := o._attack_for(foe)
	_check("Onça: sem ficha cheia o golpe é normal (prisão não vaza)", plain == me.attack, "")
	me._end_attack()
	# Ficha zera no KO do alvo
	o.set_ficha(foe, 2)
	foe.start_respawn_hold(1.0)
	await _frames(3)
	_check("Onça: ficha zera quando o alvo leva KO", o.ficha_de(foe) == 0, str(o.ficha_de(foe)))
	# "Parado aí!": vira o alvo de costas, trava a virada e apaga projétil
	await _face_off(150.0)
	o._roar_cd = 0.0
	var shot := AttackData.new()
	shot.damage = 3.0
	shot.hitbox_radius = 10.0
	var p := Projectile.spawn(load("res://scenes/combat/projectile.tscn"), foe, shot, me.global_position + Vector2(230, -20), Vector2(-120, 0), 3.0)
	var x0 := foe.global_position.x
	me.start_special("neutral")
	await _frames(16)
	_check("Onça: Parado aí! vira o adversário de costas (trava a virada)", foe.facing == me.facing and foe.turn_lock > 0.0, "facing %d lock %.2f" % [foe.facing, foe.turn_lock])
	_check("Onça: Parado aí! apaga projétil no cone", not is_instance_valid(p) or p.is_queued_for_deletion(), "")
	await _frames(30)
	_check("Onça: Parado aí! empurra um pouco e não machuca", foe.global_position.x > x0 + 15.0 and foe.damage_percent == 0.0,
		"%.0f px, %.1f%%" % [foe.global_position.x - x0, foe.damage_percent])
	_check("Onça: Parado aí! tem recarga", o._roar_cd > 0.0, "%.2f" % o._roar_cd)
	# Abordagem: de costas = x1.3 e +2 fichas
	await _face_off(140.0)
	o.set_ficha(foe, 0)
	me.start_special("side")
	await _frames(45)
	var front := foe.damage_percent
	var f_front := o.ficha_de(foe)
	await _face_off(140.0)
	o.set_ficha(foe, 0)
	foe.lock_facing(1, 2.0)   # de costas para ela
	me.start_special("side")
	await _frames(45)
	_check("Onça: abordagem por trás bate x1.3 e dá +2 fichas", foe.damage_percent > front * 1.2 and o.ficha_de(foe) == 2 and f_front == 1,
		"%.1f x %.1f, fichas %d/%d" % [foe.damage_percent, front, o.ficha_de(foe), f_front])
	foe.turn_lock = 0.0
	o.set_ficha(foe, 0)
	# Bote: salto diagonal para a frente
	await _face_off(500.0)
	var bx := me.global_position.x
	me.start_special("up")
	await _frames(14)
	_check("Onça: bote vai na diagonal para a frente", me.global_position.x > bx + 60.0 and me.velocity.y < 0.0, "%.0f px" % (me.global_position.x - bx))
	await _frames(80)
	# Interditado: barreira que não se atravessa andando, segura projétil, rasga com 2 golpes
	await _face_off(500.0)
	me.start_special("down")
	await _frames(30)
	var faixas := get_tree().get_nodes_in_group("faixas")
	_check("Onça: Interditado finca a faixa", faixas.size() == 1, str(faixas.size()))
	if faixas.size() == 1:
		var fx := faixas[0] as FaixaInterditada
		await _place(foe, Vector2(fx.global_position.x + 160.0, -60), -1)
		await _frames(20)
		for i in 40:
			foe.global_position.x -= 8.0
			await get_tree().physics_frame
		await _frames(2)
		var limit := fx.global_position.x + FaixaInterditada.WIDTH * 0.5 + Fighter.RADIUS - 4.0
		_check("Onça: adversário não atravessa a faixa andando", foe.global_position.x >= limit, "%.0f >= %.0f" % [foe.global_position.x, limit])
		var p2 := Projectile.spawn(load("res://scenes/combat/projectile.tscn"), foe, shot, fx.global_position + Vector2(140, -30), Vector2(-500, 0), 2.0)
		await _frames(30)
		_check("Onça: faixa segura projétil", not is_instance_valid(p2) and me.damage_percent == 0.0, "%.1f%%" % me.damage_percent)
		for i in 2:
			await _place(foe, Vector2(fx.global_position.x + 120.0, -60), -1)
			await _frames(15)
			foe.start_attack("ftilt")
			await _frames(30)
		await _frames(30)
		_check("Onça: 2 golpes rasgam a faixa", get_tree().get_nodes_in_group("faixas").is_empty(), str(get_tree().get_nodes_in_group("faixas").size()))


func _cutia_r12() -> void:
	var c := me as CutiaLigeira
	for n in get_tree().get_nodes_in_group("castanhas_enterradas"):
		n.queue_free()
	# Saquinho que erra planta castanha
	await _face_off(260.0)
	await _place(me, Vector2(-520, -60), 1)   # do outro lado: o saquinho para no palco
	foe.global_position = Vector2(3000, -3000)
	await _frames(15)
	me.start_special("neutral")
	await _frames(120)
	var n := get_tree().get_nodes_in_group("castanhas_enterradas").size()
	_check("Cutia: saquinho que erra rasga e planta castanha", n == 1, str(n))
	for k in get_tree().get_nodes_in_group("castanhas_enterradas"):
		k.queue_free()
	# Distância mínima entre castanhas
	await _face_off(400.0)
	var feet := me.global_position + Vector2(100, Fighter.HEIGHT * 0.5)
	var first := CastanhaEnterrada.bury(me, CastanhaEnterrada.free_spot(me, feet), c._trap_data())
	var spot := CastanhaEnterrada.free_spot(me, feet)
	_check("Cutia: castanhas ficam a 90 px uma da outra", spot != Vector2.INF and absf(spot.x - first.global_position.x) >= CastanhaEnterrada.MIN_GAP - 1.0, str(spot))
	first.queue_free()
	await _frames(2)
	# Carrinhada colhedora: recolhe as castanhas do caminho e despeja em leque
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	feet = me.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
	for dx in [90.0, 190.0]:
		CastanhaEnterrada.bury(me, CastanhaEnterrada.free_spot(me, feet + Vector2(dx, 0)), c._trap_data())
	await _frames(2)
	var got0 := c.collected_total
	me.start_special("side")
	var shots := 0
	for i in 50:
		await get_tree().physics_frame
		shots = maxi(shots, _projectiles(me).size())
	_check("Cutia: carrinhada recolhe as castanhas do caminho", c.collected_total - got0 == 2 and get_tree().get_nodes_in_group("castanhas_enterradas").is_empty(),
		"recolheu %d" % (c.collected_total - got0))
	_check("Cutia: carrinho despeja as castanhas em leque", shots == 2, "%d projéteis" % shots)
	# Para na beirada
	var edge := _edge_x()
	await _place(me, Vector2(edge - 160.0, -60), 1)
	await _frames(20)
	me.start_special("side")
	await _frames(45)
	_check("Cutia: carrinho para na beirada", me.is_on_floor() and me.global_position.x < edge + 10.0, "x %.0f borda %.0f" % [me.global_position.x, edge])
	# Pulo de susto: intocável no começo e derruba castanha para baixo
	await _face_off(500.0)
	foe.global_position = Vector2(3000, -3000)
	me.start_special("up")
	await _frames(4)
	var ghost := not me.can_be_hit()
	var down := false
	for q in _projectiles(me):
		down = down or q.velocity.y > 300.0
	await _frames(6)
	_check("Cutia: pulo de susto é intocável no começo", ghost and me.can_be_hit(), "")
	_check("Cutia: pulo de susto derruba castanha para baixo", down, "")
	await _frames(80)
	for k in get_tree().get_nodes_in_group("castanhas_enterradas"):
		k.queue_free()


func _calango_r12() -> void:
	var c := me as Calango
	# Areia só como projétil: 1 acerto, 1%, e cega
	await _face_off(80.0)
	me.start_special("neutral")
	await _frames(30)
	_check("Calango: areia acerta 1 vez só (projétil) e cega", is_equal_approx(foe.damage_percent, 1.0) and foe.sand_time > 0.0,
		"%.1f%%, areia %.1f s" % [foe.damage_percent, foe.sand_time])
	_check("Calango: areia nos olhos mostra o efeito", _fx_count("areia_olho") + _fx_count("fx_areia_olho") > 0, "")
	# Corrida acelera enquanto segura
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	Input.action_press("p1_special")
	me.start_special("side")
	var vmax := 0.0
	var v_early := 0.0
	for i in 45:
		await get_tree().physics_frame
		if i == 8:
			v_early = absf(me.velocity.x)
		vmax = maxf(vmax, absf(me.velocity.x))
	Input.action_release("p1_special")
	_check("Calango: corrida acelera enquanto segura", vmax > 1100.0 and v_early < vmax - 200.0, "%.0f -> %.0f" % [v_early, vmax])
	await _frames(40)
	# Sobe parede alta correndo (1 vez por pulo)
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	var wall := _wall(Vector2(me.global_position.x + 200.0, -300.0))
	await _frames(2)
	var y0 := me.global_position.y
	var w0 := c.wall_runs
	me.start_special("side")
	var top := y0
	for i in 40:
		await get_tree().physics_frame
		top = minf(top, me.global_position.y)
	_check("Calango: sobe a parede correndo", c.wall_runs == w0 + 1 and top < y0 - 100.0, "subiu %.0f px" % (y0 - top))
	wall.queue_free()
	await _frames(60)
	# Sol em 3 níveis (segurando) e só um toque = nível 1
	await _face_off(400.0)
	var base: float = c._base_speeds.y
	Input.action_press("p1_special")
	me.start_special("down")
	var sol := 0
	for i in 75:
		await get_tree().physics_frame
		sol = maxi(sol, _fx_count("fx_sol"))
	Input.action_release("p1_special")
	await _frames(20)
	_check("Calango: sol segurando chega ao nível 3 (+30%)", c.sun_level == 3 and me.run_speed > base * 1.25, "nível %d, %.0f -> %.0f" % [c.sun_level, base, me.run_speed])
	_check("Calango: sol mostra o efeito (fx_sol)", sol > 0, str(sol))
	c._set_sun(0)
	await _face_off(400.0)
	me.start_special("down")
	await _frames(30)
	_check("Calango: um toque no sol = nível 1", c.sun_level == 1, str(c.sun_level))
	c._set_sun(0)
	await _face_off(400.0)
	Input.action_press("p1_special")
	me.start_special("down")
	await _frames(25)
	var tap := AttackData.new()
	tap.damage = 2.0
	tap.base_knockback = 80.0
	me.receive_hit(foe, tap, -1)
	Input.action_release("p1_special")
	await _frames(60)
	_check("Calango: levar golpe deitado perde o sol", c.sun_level == 0, str(c.sun_level))
	# Rabo solto: encerra o golpe, sem_rabo, 1 vez por vida, isca
	await _face_off(300.0)
	c.tail_ready = true
	me.damage_percent = 150.0
	me.start_attack("ftilt")
	await _frames(2)
	var big := AttackData.new()
	big.damage = 14.0
	big.angle = 40.0
	big.base_knockback = 400.0
	big.knockback_growth = 8.0
	me.receive_hit(foe, big, -1)
	_check("Calango: rabo solto encerra o golpe que ele fazia", me.attack == null and not c.tail_ready, me.attack_id)
	await _frames(40)
	var o: Array = c.anim_override()
	_check("Calango: sem rabo usa a folha sem_rabo", not o.is_empty() and o[0] == "sem_rabo", str(o))
	var iscas := get_tree().get_nodes_in_group("iscas")
	_check("Calango: rabo no chão é isca", iscas.size() == 1, str(iscas.size()))
	if iscas.size() == 1:
		var r := iscas[0] as Node2D
		await _place(me, r.global_position + Vector2(-260, -80), 1)
		await _place(foe, r.global_position + Vector2(70, -60), -1)
		await _frames(15)
		me.damage_percent = 0.0
		foe.start_attack("dtilt")
		await _frames(30)
		_check("Calango: golpe que acerta a isca é gasto nela", get_tree().get_nodes_in_group("iscas").is_empty() and me.damage_percent == 0.0, "")
	await _face_off()
	me.damage_percent = 150.0
	me.receive_hit(foe, big, -1)
	_check("Calango: rabo solta só 1 vez por vida", me.state == Fighter.State.HITSTUN, Fighter.State.keys()[me.state])
	me.respawn()
	_check("Calango: rabo volta no KO (respawn)", c.tail_ready, "")
	await _frames(30)


## Parede de teste alta (como no maracaja_smoke), centro em `at`.
func _wall(at: Vector2) -> StaticBody2D:
	var wall := StaticBody2D.new()
	wall.collision_layer = 1
	var ws := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(60, 600)
	ws.shape = rect
	wall.add_child(ws)
	_match.add_child(wall)
	wall.global_position = at
	return wall


## Beirada direita do palco principal (onde o chão de palco acaba).
func _edge_x() -> float:
	var space := me.get_world_2d().direct_space_state
	var x := me.global_position.x
	while x < 3000.0:
		var q := PhysicsRayQueryParameters2D.create(Vector2(x, -200), Vector2(x, 300), Fighter.LAYER_STAGE)
		if space.intersect_ray(q).is_empty():
			return x - 10.0
		x += 10.0
	return x


func _projectiles(owner_f: Fighter) -> Array:
	var out := []
	for p in get_tree().get_nodes_in_group("projectiles"):
		if p.owner_fighter == owner_f and not p.is_queued_for_deletion():
			out.append(p)
	return out


## Efeitos vivos (PixelFx pela folha, CodeFx pelo tipo) cujo nome contém `what`.
func _fx_count(what: String) -> int:
	var n := 0
	for node in get_tree().get_nodes_in_group("match_cleanup"):
		if node is PixelFx and node.texture != null and node.texture.resource_path.contains(what):
			n += 1
		elif node is CodeFx and node.kind.contains(what):
			n += 1
	return n
