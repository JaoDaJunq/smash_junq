extends Node
## Teste do Papo-Amarelo (jacaré pescador): golpes básicos e a mecânica do anzol:
## fisgada puxa o adversário, rede prende 1 s e solta apertando, anzol na borda
## puxa de volta ao palco, rolamento da morte agarra e arremessa.
##   godot --headless --path game res://tests/jacare_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const ID := "jacare"

var results: Array[String] = []
var failures := 0
var me: PapoAmarelo
var foe: Fighter
var _match: Node


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var idx := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i].get("id", "") == ID:
			idx = i
	_check("%s está no elenco" % ID, idx >= 0, str(idx))
	if idx >= 0 and Game.character_ready(idx):
		await _start(idx)
		await _basics()
		await _fisgada()
		await _rede()
		await _borda()
		await _rolamento()
		_match.queue_free()
		await _frames(5)
	else:
		results.append("[PULADO] %s: sprites ainda não importados" % ID)
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
			me = f as PapoAmarelo
		else:
			foe = f
	foe.brain = null   # o boneco vira "jogador 2" de teclado: os botões vêm do Input (rede, apertar para soltar)
	foe.controls = FighterControls.new("p2")
	_check("Papo-Amarelo com arte", me != null and me.has_art, "")
	_check("Papo-Amarelo é mais pesado que o Seu Capivas (125)", me.weight > 125.0, "%.0f" % me.weight)
	var roster_ok: bool = Roster.slot(Roster.cell_of(idx))["name"] == "Papo-Amarelo"
	_check("Papo-Amarelo está na grade de seleção", roster_ok, str(Roster.cell_of(idx)))


func _basics() -> void:
	for mv in ["jab", "ftilt", "utilt", "dtilt"]:
		await _face_off()
		me.start_attack(mv)
		await _frames(50)
		_check("%s acerta" % mv, foe.damage_percent > 0.0, "%.1f%% (eu %s, ele %s)" % [foe.damage_percent, str(me.global_position), str(foe.global_position)])
	for mv in ["nair", "fair", "bair", "uair", "dair"]:
		await _face_off()
		me.global_position.y -= 70.0
		me.start_attack(mv)
		await _frames(60)
		_check("aéreo %s roda sem travar" % mv, me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])
	# sequência do jab: 3 golpes
	await _face_off()
	me.start_attack("jab")
	await _frames(20)
	me.start_attack("jab2")
	await _frames(25)
	me.start_attack("jab3")
	await _frames(40)
	_check("jab 1-2-3 acertam", foe.damage_percent >= 6.5, "%.1f%%" % foe.damage_percent)


func _fisgada() -> void:
	# sem direção: anzol para a frente, fisga e puxa até a boca (mordida)
	await _face_off(300.0)
	me.start_special("neutral")
	var min_gap := 999.0
	for i in 70:
		await _frames(1)
		min_gap = minf(min_gap, absf(foe.global_position.x - me.global_position.x))
	_check("Fisgada: puxa o adversário até a boca", min_gap < 90.0, "gap mínimo %.0f px" % min_gap)
	_check("Fisgada: fisgou e mordeu (2% + 4.5%)", foe.damage_percent >= 6.0, "%.1f%%" % foe.damage_percent)
	await _frames(60)
	# alcance: longe demais, o anzol volta sem pegar
	await _face_off(700.0)
	me.start_special("neutral")
	await _frames(60)
	_check("Fisgada: longe demais não pega", foe.damage_percent == 0.0, "%.1f%%" % foe.damage_percent)
	_check("Fisgada: o anzol some sozinho", get_tree().get_nodes_in_group("anzois").is_empty(), str(get_tree().get_nodes_in_group("anzois").size()))
	await _frames(40)
	# mira: segurando para cima depois do toque, o anzol sobe
	await _face_off(300.0)
	me.start_special("neutral")
	await _frames(6)
	Input.action_press("p1_up")
	await _frames(12)
	var hooks := get_tree().get_nodes_in_group("anzois")
	_check("Fisgada: segurando para cima o anzol sobe", hooks.size() == 1 and hooks[0].dir.y < -0.9,
		str(hooks[0].dir) if hooks.size() > 0 else "sem anzol")
	Input.action_release("p1_up")
	await _frames(80)


func _rede() -> void:
	await _face_off(250.0)
	me.start_special("side")
	var trapped := false
	for i in 70:
		await _frames(1)
		if foe.state == Fighter.State.HITSTUN and _nets_trapping() == 1:
			trapped = true
			break
	_check("Rede: prende o adversário", trapped, Fighter.State.keys()[foe.state])
	var held := 0
	for i in 40:
		await _frames(1)
		if foe.state == Fighter.State.HITSTUN and _nets_trapping() == 1:
			held += 1
	_check("Rede: segura mais de meio segundo", held >= 30, "%d quadros" % held)
	await _frames(50)
	_check("Rede: solta sozinha em ~1 s", foe.state != Fighter.State.HITSTUN and _nets_trapping() == 0, Fighter.State.keys()[foe.state])
	await _frames(40)
	# apertando botões solta mais cedo
	await _face_off(250.0)
	me.start_special("side")
	for i in 70:
		await _frames(1)
		if _nets_trapping() == 1:
			break
	var t0 := 0
	while foe.state == Fighter.State.HITSTUN and _nets_trapping() == 1 and t0 < 70:
		Input.action_press("p2_attack")
		await _frames(1)
		Input.action_release("p2_attack")
		await _frames(1)
		t0 += 2
	_check("Rede: apertar botões solta mais cedo", t0 < 40, "%d quadros" % t0)
	await _frames(60)
	# arco curto: longe demais a rede cai no chão e some
	await _face_off(900.0)
	me.start_special("side")
	await _frames(100)
	_check("Rede: arco curto, não acerta longe", foe.damage_percent == 0.0 and get_tree().get_nodes_in_group("redes").is_empty(),
		"%.1f%%" % foe.damage_percent)


func _borda() -> void:
	var ledge: Node2D = null
	for l in get_tree().get_nodes_in_group("ledges"):
		if l.get_meta("side", 1) == 1:
			ledge = l
	_check("existe uma borda para testar", ledge != null, "")
	if ledge == null:
		return
	var side: int = ledge.get_meta("side", 1)
	# fora do palco, abaixo e longe da borda, sem pulo: o anzol puxa de volta
	await _face_off(400.0)
	foe.global_position = Vector2(3000, -3000)
	await _place(me, ledge.global_position + Vector2(side * 220.0, 150.0), -side)
	me.jumps_left = 0
	me.start_special("up")
	var hung := false
	for i in 90:
		await _frames(1)
		if me.state == Fighter.State.LEDGE:
			hung = true
			break
	_check("Anzol na borda: pega a borda e pendura", hung and me._ledge == ledge, Fighter.State.keys()[me.state])
	await _frames(20)
	_check("Anzol na borda: depois pode subir (não fica sem pulo)", me.state == Fighter.State.LEDGE and not me.helpless, str(me.helpless))
	# sem borda ao alcance: fica sem poder agir até pousar
	await _place(me, ledge.global_position + Vector2(side * 560.0, 100.0), -side)
	me.jumps_left = 0
	me.start_special("up")
	await _frames(55)
	_check("Anzol na borda: sem borda ao alcance fica indefeso", me.helpless, "helpless=%s" % me.helpless)
	me.respawn()
	await _frames(30)


func _rolamento() -> void:
	await _face_off(70.0)
	me.start_special("down")
	var caught := false
	for i in 40:
		await _frames(1)
		if me.is_rolling() and foe.state == Fighter.State.HELD:
			caught = true
			break
	_check("Rolamento: a mordida agarra", caught, Fighter.State.keys()[foe.state])
	await _frames(20)
	_check("Rolamento: gira com o adversário", me.is_rolling() and foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	var o := me.anim_override()
	_check("Rolamento: usa os quadros de giro", not o.is_empty() and o[0] == "especial_baixo" and int(o[1]) >= 2, str(o))
	var stars := 0
	for i in 60:
		await _frames(1)
		stars = maxi(stars, _fx_count("estrelas"))
	_check("Rolamento: arremessa longe com dente quebrado", foe.damage_percent >= 11.0 and foe.state != Fighter.State.HELD and stars >= 1,
		"%.1f%% estado %s estrelas %d" % [foe.damage_percent, Fighter.State.keys()[foe.state], stars])
	await _frames(80)
	# errou (adversário longe): não agarra
	await _face_off(400.0)
	me.start_special("down")
	await _frames(40)
	_check("Rolamento: errando não agarra ninguém", foe.state != Fighter.State.HELD and not me.is_rolling(), Fighter.State.keys()[foe.state])
	await _frames(60)


func _nets_trapping() -> int:
	var n := 0
	for r in get_tree().get_nodes_in_group("redes"):
		if r.is_trapping() and not r.is_queued_for_deletion():
			n += 1
	return n


func _face_off(gap := 70.0) -> void:
	for g in ["anzois", "redes"]:
		for n in get_tree().get_nodes_in_group(g):
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
	f._launch = Vector2.ZERO
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	f.slip_time = 0.0
	f.turn_lock = 0.0
	f.sand_time = 0.0
	f.invincible_time = 0.0
	f._ledge = null
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1


## Efeitos vivos (PixelFx pela folha, CodeFx pelo tipo) cujo nome contém `what`.
func _fx_count(what: String) -> int:
	var n := 0
	for node in get_tree().get_nodes_in_group("match_cleanup"):
		if node is PixelFx and node.texture != null and node.texture.resource_path.contains(what):
			n += 1
		elif node is CodeFx and node.kind.contains(what):
			n += 1
	return n
