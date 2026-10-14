extends Node
## Teste de fumaça do modo treino e do registro do playtest (sem janela):
##   godot --headless --path game res://tests/training_smoke.tscn

const MATCH_SCENE := preload("res://scenes/match.tscn")
const TEST_DIR := "user://playtest_teste"

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	PlaytestLog.dir = TEST_DIR
	_clear_dir()
	Game.suppress_scene_changes = true
	await _training()
	await _match_log()
	_clear_dir()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _training() -> void:
	Game.mode = "training"
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	var m := MATCH_SCENE.instantiate()
	add_child(m)
	await _frames(3)
	var t: TrainingMode = m.training
	var p1: Fighter = m.fighters["p1"]
	var dummy: Fighter = m.fighters["p2"]
	_check("Treino começa sem contagem", m.phase == m.Phase.FIGHT, str(m.phase))
	_check("P2 é o boneco", dummy.brain is DummyBrain, str(dummy.brain))
	_check("Rótulo do P2 é Boneco", Game.player_label("p2") == "Boneco", Game.player_label("p2"))

	# Golpe no boneco: quadro de informações
	await _place(p1, Vector2(-70, -56), 1)
	await _place(dummy, Vector2(0, -56), -1)
	dummy.receive_hit(p1, p1.moveset.ftilt, 1)
	await _frames(40)
	_check("Quadro mostra o golpe", "ftilt" in t._info.text, t._info.text)
	_check("Mede a distância do lançamento", int(t.last_hit.get("distancia", 0)) > 0, str(t.last_hit.get("distancia")))

	# Dano do boneco e manter dano
	t.change_damage(10)  # +100%
	_check("Ajusta o dano do boneco", is_equal_approx(dummy.damage_percent, 100.0), "%.0f%%" % dummy.damage_percent)
	t.toggle_lock()
	await _place(dummy, Vector2(0, -56), -1)
	dummy.receive_hit(p1, p1.moveset.jab, 1)
	for i in 120:
		await get_tree().physics_frame
		if dummy.state != Fighter.State.HITSTUN:
			break
	await _frames(2)
	_check("Manter dano volta ao valor escolhido", is_equal_approx(dummy.damage_percent, 100.0), "%.1f%%" % dummy.damage_percent)

	# Comportamentos
	t.change_behavior(2)  # Parado -> Escudo
	await _place(dummy, Vector2(0, -56), -1)
	await _frames(10)
	_check("Boneco com escudo segura o escudo", dummy.state == Fighter.State.SHIELD, Fighter.State.keys()[dummy.state])
	t.change_behavior(-2)

	# Áreas de acerto
	t.toggle_hitboxes()
	_check("Mostrar áreas de acerto liga a depuração", p1.show_debug_label and dummy.show_debug_label, "")
	t.toggle_hitboxes()

	# KO do boneco não acaba o treino nem conta ponto
	dummy.global_position = Vector2(1600, -300)
	await _frames(3)
	_check("KO no treino não conta ponto", m.kos["p1"] == 0 and m.phase == m.Phase.FIGHT, str(m.kos))
	_check("Boneco volta com o dano escolhido", is_equal_approx(dummy.damage_percent, 100.0), "%.0f%%" % dummy.damage_percent)

	# Painel abre com a pausa e pausa o jogo
	Input.action_press("p1_pause")
	await get_tree().process_frame
	await get_tree().process_frame
	Input.action_release("p1_pause")
	_check("Pausa abre o painel de treino", t._panel.visible and get_tree().paused, "")
	t.close_panel()
	_check("Painel fecha e o jogo segue", not t._panel.visible and not get_tree().paused, "")

	# Registro do treino
	var lines := _read_lines("treino.jsonl")
	_check("Treino registra golpes em treino.jsonl", lines.size() >= 2 and "ftilt" in lines[0], "%d linha(s)" % lines.size())
	m.queue_free()
	await _frames(2)


func _match_log() -> void:
	Game.mode = "versus"
	Game.suppress_scene_changes = false  # liga o registro (sem trocar de cena neste teste)
	var m := MATCH_SCENE.instantiate()
	add_child(m)
	Game.suppress_scene_changes = true
	await _frames(2)
	m.skip_countdown()
	var p1: Fighter = m.fighters["p1"]
	var p2: Fighter = m.fighters["p2"]
	p2.damage_percent = 130.0
	p2.receive_hit(p1, p1.moveset.fair, 1)
	await _frames(2)
	for i in 3:
		m.resolve_kos(["p2"] as Array[String])
		await _frames(2)
	var lines := _read_lines("partidas.jsonl")
	var kos := lines.filter(func(l: String) -> bool: return "\"ko\"" in l)
	var end := lines.filter(func(l: String) -> bool: return "\"fim\"" in l)
	_check("Partida registra cada KO", kos.size() == 3, "%d KO(s)" % kos.size())
	_check("KO registra dano e último golpe", kos.size() > 0 and "fair" in kos[0] and "\"dano\":13" in kos[0], kos[0] if kos.size() > 0 else "")
	_check("Partida registra o fim", end.size() == 1, "%d" % end.size())
	m.queue_free()
	await _frames(2)


func _place(f: Fighter, pos: Vector2, face: int) -> void:
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.state = Fighter.State.AIR
	f.facing = face
	f._hitstun = 0.0
	f._hitstop = 0
	await _frames(8)


func _read_lines(file: String) -> Array[String]:
	var out: Array[String] = []
	var f := FileAccess.open(TEST_DIR.path_join(file), FileAccess.READ)
	if f == null:
		return out
	while not f.eof_reached():
		var line := f.get_line()
		if line != "":
			out.append(line)
	return out


func _clear_dir() -> void:
	for file in ["treino.jsonl", "partidas.jsonl"]:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_DIR.path_join(file)))


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
