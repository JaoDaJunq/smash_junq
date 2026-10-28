extends Node
## Prints de revisão das telas fora da luta (COM janela; sem --headless não desenha):
## menu, modo, seleção (cada jogável nos dois painéis), arenas (cada opção),
## HUD de uma partida para cada par de jogáveis e tela de resultado.
## Saída em evidence/ui/.
##   godot --path game --resolution 1920x1080 res://tests/ui_revisao_shots.tscn [-- so=menu,selecao,arena,hud,resultado]

var out := ""
var only: Array = []


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	out = ProjectSettings.globalize_path("res://").path_join("../evidence/ui")
	DirAccess.make_dir_recursive_absolute(out)
	for a in OS.get_cmdline_user_args():
		if a.begins_with("so="):
			only = a.trim_prefix("so=").split(",")
	if _want("menu"):
		await _screen("menu", "res://scenes/ui/main_menu.tscn")
		await _screen("modo", "res://scenes/ui/mode_select.tscn")
	if _want("selecao"):
		await _selection()
	if _want("arena"):
		await _arenas()
	if _want("hud"):
		await _hud()
	if _want("resultado"):
		await _results()
	if _want("outras"):
		await _screen("como_jogar", "res://scenes/ui/how_to_play.tscn")
		await _screen("opcoes", "res://scenes/ui/options.tscn")
		await _screen("controles", "res://scenes/ui/controls.tscn")
		var m := await _new_match(4, 8)
		m.pause_menu.open()
		await _frames(30)
		await _shot("pausa")
		m.pause_menu.close()
		m.queue_free()
		await _frames(5)
	Game.suppress_scene_changes = false
	print("RESULTADO: OK (prints em ", out, ")")
	get_tree().quit()


func _want(k: String) -> bool:
	return only.is_empty() or k in only


func _playable() -> Array[int]:
	var r: Array[int] = []
	for i in Game.CHARACTERS.size():
		if Game.character_ready(i):
			r.append(i)
	return r


func _screen(key: String, path: String) -> void:
	var s: Node = (load(path) as PackedScene).instantiate()
	add_child(s)
	await _frames(45)
	await _shot(key)
	s.queue_free()
	await _frames(3)


func _selection() -> void:
	var ids := _playable()
	var s: Node = (load("res://scenes/ui/character_select.tscn") as PackedScene).instantiate()
	add_child(s)
	await _frames(30)
	await _shot("selecao_inicio")
	# navegação: o cursor pula os "?" (Juba -> direita -> Berrante -> baixo -> Capivas)
	s._move("p1", Vector2i.RIGHT)
	await _frames(20)
	await _shot("selecao_nav_1_direita_pula")
	s._move("p1", Vector2i.DOWN)
	s._move("p2", Vector2i.DOWN)
	await _frames(20)
	await _shot("selecao_nav_2_baixo_pula")
	# cada jogável: P1 nele, P2 no próximo
	for k in ids.size():
		s._set_cursor("p1", Roster.cell_of(ids[k]))
		s._set_cursor("p2", Roster.cell_of(ids[(k + 1) % ids.size()]))
		s._refresh()
		await _frames(25)
		await _shot("selecao_%02d_%s" % [ids[k], Game.CHARACTERS[ids[k]]["id"]])
	# "?" e confirmado
	s._set_cursor("p2", Vector2i(1, 0))
	s._refresh()
	s._toggle_lock("p1")
	await _frames(20)
	await _shot("selecao_trava_e_interrogacao")
	s._set_cursor("p2", Roster.cell_of(8))
	s._refresh()
	s._toggle_lock("p2")
	await _frames(12)
	await _shot("selecao_prontos")
	s.queue_free()
	await _frames(3)
	# modo CPU
	Game.mode = "cpu"
	s = (load("res://scenes/ui/character_select.tscn") as PackedScene).instantiate()
	add_child(s)
	await _frames(30)
	await _shot("selecao_cpu")
	s.queue_free()
	Game.mode = "versus"
	await _frames(3)


func _arenas() -> void:
	var s: Node = (load("res://scenes/ui/arena_select.tscn") as PackedScene).instantiate()
	add_child(s)
	await _frames(30)
	for i in s.cards.size():
		s._select(i, false)
		await _frames(20)
		await _shot("arena_%d" % i)
	s.queue_free()
	await _frames(3)


func _new_match(p1: int, p2: int) -> Node:
	Game.set_character("p1", p1)
	Game.set_character("p2", p2)
	Game.arena_index = 0
	var m: Node = (load("res://scenes/match.tscn") as PackedScene).instantiate()
	m.countdown_step = 0.05
	m.results_delay = 0.2
	add_child(m)
	await _frames(2)
	m.skip_countdown()
	await _frames(10)
	return m


func _hud() -> void:
	var ids := _playable()
	for k in range(0, ids.size(), 2):
		var a := ids[k]
		var b := ids[(k + 1) % ids.size()]
		var m := await _new_match(a, b)
		m.fighters["p1"].add_damage(37.0 + k * 9)
		m.fighters["p2"].add_damage(118.0 + k * 7)
		m.kos = {"p1": 1, "p2": 2}
		m.hud.set_kos(m.kos)
		await _frames(30)
		await _shot("hud_%s_x_%s" % [Game.CHARACTERS[a]["id"], Game.CHARACTERS[b]["id"]])
		m.queue_free()
		await _frames(5)
	# Estrelas da ficha da Dona Onça x setinha P1/CPU em cima do alvo (não podem
	# se cobrir): Onça P1 contra CPU com 2 fichas; depois CPU-Onça marca o P1 com 3.
	var onca := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i]["id"] == "onca":
			onca = i
	if onca >= 0 and Game.character_ready(onca):
		Game.mode = "cpu"
		for side in ["p1", "p2"]:
			var m := await _new_match(onca if side == "p1" else 0, 0 if side == "p1" else onca)
			var dona: Node = m.fighters[side]
			var alvo: Fighter = m.fighters["p2" if side == "p1" else "p1"]
			await _frames(50)
			m.fighters["p2"].set_physics_process(false)
			m.fighters["p1"].set_physics_process(false)
			dona.set_ficha(alvo, 2 if side == "p1" else 3)
			m.kos = {"p1": 0, "p2": 1}
			m.hud.set_kos(m.kos)
			await _frames(30)
			await _shot("hud_ficha_onca_%s" % side)
			m.queue_free()
			await _frames(5)
		Game.mode = "versus"


func _results() -> void:
	var ids := _playable()
	var pairs := [[ids[0], ids[1], "p1"], [ids[2], ids[3], "p2"]]
	if ids.size() > 8:
		pairs.append([ids[7], ids[8], "p2"])
	for pr in pairs:
		var m := await _new_match(pr[0], pr[1])
		m.kos = {"p1": 3 if pr[2] == "p1" else 1, "p2": 3 if pr[2] == "p2" else 2}
		m.end_match(pr[2])
		await get_tree().create_timer(1.2).timeout
		await _shot("resultado_%s_vence_%s" % [pr[2], Game.CHARACTERS[pr[0] if pr[2] == "p1" else pr[1]]["id"]])
		m.queue_free()
		await _frames(5)


func _shot(key: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(out.path_join(key + ".png"))
	print("print: ", key)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().process_frame
