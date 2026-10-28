extends Node
## Teste de fumaça do Beija (beija-flor skatista, rodada 11): golpes básicos acertam,
## pairar (até 1,5 s por pulo), rajada de bicadas do jab 3 e cada especial
## (néctar, manobra com skate, voo, grind/cravada).
##   godot --headless --path game res://tests/beija_flor_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const ID := "beija_flor"

var results: Array[String] = []
var failures := 0
var me: Fighter
var foe: Fighter
var _match: Node
var _hits: Array[AttackData] = []


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
		_check("roster aponta para o Beija", Roster.slot(Roster.cell_of(idx))["name"] == "Beija", str(Roster.cell_of(idx)))
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
		foe.hit_taken.connect(func(_a: Node2D, d: AttackData, _l: Vector2) -> void:
			_hits.append(d))
		_check("Beija com arte", me.has_art, "")
		await _basics()
		await _pairar()
		await _jab3()
		await _nectar()
		await _manobra()
		await _voo()
		await _grind()
	else:
		results.append("[PULADO] sprites ainda não importados")
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _basics() -> void:
	_check("Beija é do tipo Rápido e leve", me.weight < 70.0 and me.run_speed >= 680.0, "peso %.0f corrida %.0f" % [me.weight, me.run_speed])
	_check("Beija (ave) tem 2 pulos no ar", me.air_jumps == 2, str(me.air_jumps))
	await _face_off()
	var hb := me.hurtbox()
	_check("Beija: caixa de acerto menor e nos pés", hb.size.y < Fighter.HEIGHT and absf(hb.end.y - (me.global_position.y + Fighter.HEIGHT * 0.5)) < 0.1,
		"%.0fx%.0f" % [hb.size.x, hb.size.y])
	for mv in ["jab", "ftilt", "utilt", "dtilt"]:
		await _face_off()
		if mv == "utilt":
			foe.global_position.x = me.global_position.x + 6.0
		me.start_attack(mv)
		await _frames(45)
		_check("%s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for mv in ["nair", "fair", "bair", "uair", "dair"]:
		await _face_off()
		await _place(me, Vector2(-200, -140), 1)
		await _place(foe, Vector2(-200 + (-60 if mv == "bair" else 60), -140), 1)
		if mv == "uair":
			foe.global_position = me.global_position + Vector2(4, -60)
		elif mv == "dair":
			foe.global_position = me.global_position + Vector2(0, 62)
		foe.velocity = Vector2.ZERO
		me.start_attack(mv)
		await _frames(24)
		_check("%s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for kind in ["neutral", "side", "up", "down"]:
		await _face_off()
		me.start_special(kind)
		await _frames(120)
		_check("especial %s roda sem travar" % kind, me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])
		await _place(me, Vector2(-200, -60), 1)
		await _frames(60)


## Pairar: segurando o pulo no ar para parado por até 1,5 s por pulo.
func _pairar() -> void:
	var b := me as Beija
	await _face_off(400.0)
	await _place(me, Vector2(-200, -380), 1)
	await _place(foe, Vector2(300, -60), -1)
	b.jumps_left = 2
	Input.action_press("p1_jump")
	var hover := 0
	var y_hover := 0.0
	var drift := 0.0
	for i in 160:
		await _frames(1)
		if b.is_hovering():
			if hover == 0:
				y_hover = me.global_position.y
			hover += 1
			drift = maxf(drift, absf(me.global_position.y - y_hover))
	_check("Pairar: fica parado no ar enquanto segura o pulo", hover > 40 and drift < 2.0, "%d quadros, variou %.1f px" % [hover, drift])
	_check("Pairar: no máximo 1,5 s por pulo", hover >= 85 and hover <= 94, "%d quadros (90 = 1,5 s)" % hover)
	_check("Pairar: depois de gastar, cai", me.velocity.y > 100.0 or me.global_position.y > y_hover + 30.0, "%.0f" % (me.global_position.y - y_hover))
	# outro pulo (2º no ar) dá mais 1,5 s
	Input.action_release("p1_jump")
	await _frames(3)
	Input.action_press("p1_jump")
	var hover2 := 0
	for i in 150:
		await _frames(1)
		if b.is_hovering():
			hover2 += 1
	Input.action_release("p1_jump")
	_check("Pairar: cada pulo ganha seu próprio fôlego", hover2 >= 80, "%d quadros no 2º pulo" % hover2)
	# soltar o pulo para de pairar na hora
	await _place(me, Vector2(-200, -380), 1)
	b.jumps_left = 0
	b.hover_left = Beija.HOVER_TIME
	me.velocity.y = 0.0
	Input.action_press("p1_jump")
	await _frames(20)
	var hovering := b.is_hovering()
	Input.action_release("p1_jump")
	await _frames(6)
	_check("Pairar: soltar o pulo volta a cair", hovering and not b.is_hovering() and me.velocity.y > 50.0, "pairou=%s vy=%.0f" % [hovering, me.velocity.y])
	# no chão o fôlego volta cheio
	await _frames(120)
	_check("Pairar: fôlego volta ao pousar", is_equal_approx(b.hover_left, Beija.HOVER_TIME), "%.2f" % b.hover_left)


## Jab 3 = 4 bicadas: 3 fracas e a última lança.
func _jab3() -> void:
	await _face_off(64.0)
	_hits.clear()
	me.start_attack("jab3")
	await _frames(60)
	_check("Jab 3: rajada de 4 bicadas", _hits.size() == 4, "%d acertos" % _hits.size())
	var dmg := 0.0
	for h in _hits:
		dmg += h.damage
	_check("Jab 3: dano total ~5,4%", absf(foe.damage_percent - dmg) < 0.01 and foe.damage_percent > 4.5 and foe.damage_percent < 6.5, "%.1f%%" % foe.damage_percent)
	_check("Jab 3: última bicada é a mais forte", not _hits.is_empty() and _hits[-1].base_knockback > _hits[0].base_knockback * 1.5,
		"%.0f x %.0f" % [_hits[-1].base_knockback if not _hits.is_empty() else 0.0, _hits[0].base_knockback if not _hits.is_empty() else 0.0])


## Néctar: parado ~1 s no ar; cura 4% se ninguém interromper.
func _nectar() -> void:
	await _face_off(500.0)
	await _place(me, Vector2(-200, -300), 1)
	me.damage_percent = 20.0
	var y0 := me.global_position.y
	me.start_special("neutral")
	await _frames(14)
	_check("Néctar: tem efeito de brilho", _fx_count("fx_nectar") >= 1, str(_fx_count("fx_nectar")))
	await _frames(26)
	_check("Néctar: para no ar", absf(me.global_position.y - y0) < 2.0 and me.state == Fighter.State.ATTACK, "dy %.1f" % (me.global_position.y - y0))
	await _frames(45)
	_check("Néctar: cura 4% sem interrupção", absf(me.damage_percent - 16.0) < 0.01, "20 -> %.1f" % me.damage_percent)
	await _frames(30)
	# interrompido por um golpe: não cura
	await _face_off(500.0)
	me.damage_percent = 20.0
	me.start_special("neutral")
	await _frames(30)
	var shot := AttackData.new()
	shot.damage = 3.0
	me.receive_hit(foe, shot, 1)
	await _frames(100)
	_check("Néctar: golpe no meio interrompe a cura", me.damage_percent >= 22.9, "20 -> %.1f" % me.damage_percent)
	# nunca cura abaixo de zero
	await _face_off(500.0)
	me.damage_percent = 1.0
	me.start_special("neutral")
	await _frames(90)
	_check("Néctar: cura no máximo o que tem", me.damage_percent == 0.0, "%.1f" % me.damage_percent)


## Manobra: skate sai sozinho, rente ao chão, acerta e some na borda; pular sai do skate.
func _manobra() -> void:
	await _face_off(500.0)
	await _frames(2)
	_hits.clear()
	var x0 := me.global_position.x
	me.start_special("side")
	var skate: Node2D = null
	for i in 40:
		await _frames(1)
		var s := get_tree().get_nodes_in_group("skates")
		if not s.is_empty():
			skate = s[0]
			break
	_check("Manobra: o skate sai do Beija", skate != null and skate.owner_fighter == me, str(skate))
	_check("Manobra: Beija andou de skate", me.global_position.x > x0 + 60.0, "%.0f px" % (me.global_position.x - x0))
	var sx := skate.global_position.x if skate != null else 0.0
	await _frames(20)
	_check("Manobra: o skate segue sozinho", skate != null and is_instance_valid(skate) and skate.global_position.x > sx + 80.0, "%.0f px" % ((skate.global_position.x - sx) if is_instance_valid(skate) else -1.0))
	await _frames(40)
	_check("Manobra: skate acerta quem está na frente", foe.damage_percent > 0.0 and _hits.size() >= 1, "%.1f%% (%d acerto(s))" % [foe.damage_percent, _hits.size()])
	# some na borda: sem ninguém pelo caminho
	await _face_off(500.0)
	await _place(foe, Vector2(2000, -3000), -1)
	await _place(me, Vector2(300, -60), 1)
	await _frames(40)
	me.start_special("side")
	var went_off := false
	for i in 220:
		await _frames(1)
		var s2 := get_tree().get_nodes_in_group("skates")
		if not s2.is_empty() and s2[0].gravity > 0.0:
			went_off = true
	_check("Manobra: o skate cai na borda do palco", went_off, "")
	await _frames(120)
	_check("Manobra: skate some depois da borda", get_tree().get_nodes_in_group("skates").filter(func(n: Node) -> bool: return not n.is_queued_for_deletion()).is_empty(),
		str(get_tree().get_nodes_in_group("skates").size()))
	# pular do skate no meio
	await _face_off(500.0)
	me.start_special("side")
	await _frames(12)
	Input.action_press("p1_jump")
	await _frames(4)
	Input.action_release("p1_jump")
	await _frames(3)
	_check("Manobra: dá para pular do skate", me.global_position.y < me.spawn_point.y - 400.0 or not me.is_on_floor() or me.velocity.y < 0.0,
		"y %.0f vy %.0f" % [me.global_position.y, me.velocity.y])
	_check("Manobra: o skate sai ao pular", not get_tree().get_nodes_in_group("skates").is_empty(), "")


## Voo de beija-flor: sem dano, na direção da alavanca (padrão: para cima).
func _voo() -> void:
	await _face_off(500.0)
	await _place(me, Vector2(-200, -200), 1)
	await _place(foe, Vector2(2000, -3000), -1)
	var p0 := me.global_position
	me.start_special("up")
	await _frames(6 + 16 + 2)
	var d := me.global_position - p0
	_check("Voo: sem alavanca vai para cima", d.y < -250.0 and absf(d.x) < 30.0, "%.0f,%.0f" % [d.x, d.y])
	_check("Voo: sem dano", me.attack == null or me.attack.damage == 0.0, "")
	await _frames(80)
	await _place(me, Vector2(-200, -200), 1)
	p0 = me.global_position
	Input.action_press("p1_right")
	Input.action_press("p1_up")
	me.start_special("up")
	await _frames(6 + 16 + 2)
	Input.action_release("p1_right")
	Input.action_release("p1_up")
	d = me.global_position - p0
	_check("Voo: vai na diagonal da alavanca", d.x > 180.0 and d.y < -180.0, "%.0f,%.0f" % [d.x, d.y])
	await _frames(10)
	await _place(me, Vector2(-200, -200), 1)
	p0 = me.global_position
	Input.action_press("p1_left")
	me.start_special("up")
	await _frames(6 + 16 + 2)
	Input.action_release("p1_left")
	d = me.global_position - p0
	_check("Voo: vai para o lado e vira", d.x < -250.0 and absf(d.y) < 40.0 and me.facing == -1, "%.0f,%.0f facing %d" % [d.x, d.y, me.facing])
	await _frames(60)
	_check("Voo: depois fica sem golpe até pousar (recuperação)", me.helpless or me.is_on_floor() or me.state == Fighter.State.AIR, Fighter.State.keys()[me.state])


## Grind: no chão desliza e derruba; no ar cai rápido e crava.
func _grind() -> void:
	await _face_off(130.0)
	_hits.clear()
	var x0 := me.global_position.x
	me.start_special("down")
	await _frames(45)
	_check("Grind: desliza para a frente", me.global_position.x > x0 + 60.0, "%.0f px" % (me.global_position.x - x0))
	_check("Grind: derruba quem está no caminho", foe.damage_percent >= 5.9 and _hits.size() >= 1, "%.1f%%" % foe.damage_percent)
	_check("Grind: lança para cima (derruba)", not _hits.is_empty() and _hits[0].angle > 45.0, str(_hits[0].angle if not _hits.is_empty() else 0))
	await _frames(40)
	await _face_off(500.0)
	await _place(me, Vector2(0, -400), 1)
	await _place(foe, Vector2(0, -60), -1)
	_hits.clear()
	var vmax := 0.0
	me.start_special("down")
	for i in 40:
		await _frames(1)
		vmax = maxf(vmax, me.velocity.y)
	_check("Cravada: cai rápido no ar", vmax >= 1100.0, "%.0f px/s" % vmax)
	_check("Cravada: acerta quem está embaixo", foe.damage_percent >= 6.9, "%.1f%%" % foe.damage_percent)
	_check("Cravada: manda para baixo", not _hits.is_empty() and _hits[0].angle < 0.0, str(_hits[0].angle if not _hits.is_empty() else 0))


func _face_off(gap := 70.0) -> void:
	for n in get_tree().get_nodes_in_group("skates"):
		n.queue_free()
	await _place(me, Vector2(-200, -60), 1)
	await _place(foe, Vector2(-200 + gap, -60), -1)
	await _frames(20)
	me.damage_percent = 0.0
	foe.damage_percent = 0.0
	_hits.clear()


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


## Efeitos vivos (PixelFx pela folha) cujo nome contém `what`.
func _fx_count(what: String) -> int:
	var n := 0
	for node in get_tree().get_nodes_in_group("match_cleanup"):
		if node is PixelFx and node.texture != null and node.texture.resource_path.contains(what):
			n += 1
		elif node is CodeFx and node.kind.contains(what):
			n += 1
	return n
