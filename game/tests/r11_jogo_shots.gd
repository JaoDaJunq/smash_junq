extends Node
## Revisão R11 (jogo como um todo): prints de todas as telas e estados da
## partida em evidence/revisao-r11/. COM janela:
##   godot --path game --resolution 1920x1080 res://tests/r11_jogo_shots.tscn

const MATCH := preload("res://scenes/match.tscn")
var out := ""


func _ready() -> void:
	Game.suppress_scene_changes = true
	out = ProjectSettings.globalize_path("res://").path_join("../evidence/revisao-r11")
	DirAccess.make_dir_recursive_absolute(out)

	Game.mode = "versus"
	await _screen("01_menu", "res://scenes/ui/main_menu.tscn")
	await _screen("02_modo", "res://scenes/ui/mode_select.tscn")
	await _screen("03_como_jogar", "res://scenes/ui/how_to_play.tscn")
	await _screen("04_opcoes", "res://scenes/ui/options.tscn")
	await _screen("05_controles", "res://scenes/ui/controls.tscn")

	# Seleção 2 jogadores: Tucão x Dona Onça
	Game.set_character("p1", 7)
	Game.set_character("p2", 8)
	var s := await _open("res://scenes/ui/character_select.tscn")
	await _shot("10_selecao_tucao_onca")
	s._toggle_lock("p1")
	await _frames(20)
	await _shot("11_selecao_p1_pronto")
	s.queue_free()
	await _frames(3)
	# Seleção: P1 num "?" e P2 no mesmo quadro que P1
	Game.set_character("p1", 0)
	Game.set_character("p2", 0)
	s = await _open("res://scenes/ui/character_select.tscn")
	await _shot("12_selecao_mesmo_quadro")
	s._set_cursor("p1", Vector2i(1, 0))
	s._set_cursor("p2", Vector2i(0, 4))
	s._refresh()
	await _frames(30)
	await _shot("13_selecao_em_breve")
	# todos os personagens no painel (para ver nome/descrição longos)
	for i in Game.CHARACTERS.size():
		s._set_cursor("p1", Roster.cell_of(i))
		s._refresh()
		await _frames(12)
		await _shot("14_painel_%02d_%s" % [i, Game.CHARACTERS[i]["id"]])
	s.queue_free()
	await _frames(3)
	# Seleção contra a CPU
	Game.mode = "cpu"
	s = await _open("res://scenes/ui/character_select.tscn")
	s._toggle_lock("p1")
	await _frames(20)
	await _shot("15_selecao_cpu")
	s.queue_free()
	await _frames(3)

	# Arenas (todas as opções)
	var a := await _open("res://scenes/ui/arena_select.tscn")
	for i in a.cards.size():
		a._select(i, false)
		await _frames(25)
		await _shot("20_arena_%d" % i)
	a.queue_free()
	await _frames(3)

	# Partida contra a CPU: contagem, HUD com dano, pausa, morte súbita, resultado
	Game.mode = "cpu"
	Game.arena_index = 0
	Game.set_character("p1", 5)   # Mestra Sucuri (nome longo)
	Game.set_character("p2", 8)   # Dona Onça
	var m: Node = MATCH.instantiate()
	add_child(m)
	await _pframes(50)
	await _shot("30_contagem")
	await _pframes(150)
	m.fighters["p1"].add_damage(137.0)
	m.fighters["p2"].add_damage(48.0)
	m.kos = {"p1": 2, "p2": 1}
	m.hud.set_kos(m.kos)
	await _pframes(40)
	await _shot("31_hud_luta")
	m.pause_menu.open()
	await _frames(20)
	await _shot("32_pausa")
	m.pause_menu.close()
	m.kos = {"p1": 2, "p2": 2}
	m.hud.set_kos(m.kos)
	m.hud.show_banner("MORTE SÚBITA", 2.0, Color(0.95, 0.2, 0.15))
	await _frames(25)
	await _shot("33_morte_subita")
	m.kos = {"p1": 3, "p2": 2}
	m.hud.set_kos(m.kos)
	m.end_match("p1")
	await _frames(20)
	await _shot("34_fim_banner")
	await get_tree().create_timer(2.2).timeout
	await _shot("35_resultado")
	m.queue_free()
	await _frames(5)

	# Versus no Pantanal com nomes curtos + resultado do P2
	Game.mode = "versus"
	Game.arena_index = 1
	Game.set_character("p1", 7)
	Game.set_character("p2", 4)
	m = MATCH.instantiate()
	add_child(m)
	await _pframes(260)
	await _shot("36_hud_versus_pantanal")
	m.end_match("p2")
	await get_tree().create_timer(2.2).timeout
	await _shot("37_resultado_p2")
	m.queue_free()
	await _frames(5)

	# Treino
	Game.mode = "training"
	Game.arena_index = 0
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	m = MATCH.instantiate()
	add_child(m)
	await _pframes(80)
	await _shot("40_treino")
	m.training.open_panel()
	await _frames(20)
	await _shot("41_treino_painel")
	m.training.close_panel()
	m.queue_free()
	await _frames(5)
	get_tree().paused = false
	print("FIM r11 shots")
	get_tree().quit()


func _open(path: String) -> Node:
	var s: Node = (load(path) as PackedScene).instantiate()
	add_child(s)
	await _frames(40)
	return s


func _screen(key: String, path: String) -> void:
	var s := await _open(path)
	await _shot(key)
	s.queue_free()
	await _frames(3)


func _shot(key: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(out.path_join(key + ".png"))
	print("print: ", key)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().process_frame


func _pframes(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
