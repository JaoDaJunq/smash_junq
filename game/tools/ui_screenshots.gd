extends Node
## Tira screenshots das telas de interface em evidence/etapa-3/ui-*.png e encerra.
## Precisa de renderização (não use --headless). Para não abrir janela visível:
##   godot --path game --position -10000,-10000 res://tools/ui_screenshots.tscn

const MAIN_MENU := preload("res://scenes/ui/main_menu.tscn")
const MODE_SELECT := preload("res://scenes/ui/mode_select.tscn")
const CHAR_SELECT := preload("res://scenes/ui/character_select.tscn")
const MATCH := preload("res://scenes/match.tscn")

var out_dir := ""


func _ready() -> void:
	out_dir = ProjectSettings.globalize_path("res://").path_join("../evidence/etapa-3")
	DirAccess.make_dir_recursive_absolute(out_dir)
	Game.suppress_scene_changes = true
	Sfx.muted = true
	await _run()
	Game.suppress_scene_changes = false
	get_tree().paused = false
	get_tree().quit()


func _run() -> void:
	# Menu principal: durante a entrada e já assentado (com o foco no segundo botão)
	var menu := MAIN_MENU.instantiate()
	add_child(menu)
	await _wait(0.07)
	await _shot("ui-menu-entrada")
	await _wait(0.5)
	await _shot("ui-menu-principal")
	menu.buttons[1].grab_focus()
	await _wait(0.3)
	await _shot("ui-menu-foco-sair")
	menu.queue_free()

	var mode := MODE_SELECT.instantiate()
	add_child(mode)
	await _wait(0.6)
	await _shot("ui-modo")
	mode.queue_free()

	Game.mode = "versus"
	var sel := CHAR_SELECT.instantiate()
	add_child(sel)
	await _wait(0.6)
	sel._toggle_lock("p1")
	await _wait(0.5)
	await _shot("ui-selecao")
	sel.queue_free()

	Game.mode = "cpu"
	var sel_cpu := CHAR_SELECT.instantiate()
	add_child(sel_cpu)
	await _wait(0.6)
	await _shot("ui-selecao-cpu")
	sel_cpu.queue_free()
	Game.mode = "versus"

	# Luta: contagem, HUD com dano alto, aviso, pausa e resultado
	var m := MATCH.instantiate() as MatchManager
	m.countdown_step = 0.6
	add_child(m)
	await _wait(0.4)
	await _shot("ui-hud-contagem")
	m.skip_countdown()
	await _wait(0.3)
	var p1: Fighter = m.fighters["p1"]
	var p2: Fighter = m.fighters["p2"]
	p1.damage_percent = 35.0
	p1.damage_changed.emit(35.0)
	p2.damage_percent = 80.0
	p2.damage_changed.emit(80.0)
	m.kos = {"p1": 2, "p2": 1}
	m.hud.set_kos(m.kos)
	await _wait(0.06)
	await _shot("ui-hud-dano-pop")
	await _wait(0.6)
	await _shot("ui-hud-luta")
	m.hud.show_banner("MORTE SÚBITA", 0.0, Color(0.95, 0.2, 0.15))
	await _wait(0.5)
	await _shot("ui-hud-morte-subita")
	m.hud.hide_banner()
	p2.damage_percent = 165.0
	p2.damage_changed.emit(165.0)
	await _wait(0.5)
	await _shot("ui-hud-dano-alto")

	m.pause_menu.open()
	await _wait(0.5)
	await _shot("ui-pausa")
	m.pause_menu.close()

	Game.last_result = {"winner": "p1", "winner_name": "Jogador 1", "winner_character": "Ágil",
		"kos": {"p1": 3, "p2": 1}, "labels": {"p1": "Jogador 1", "p2": "Jogador 2"},
		"characters": {"p1": "Ágil", "p2": "Pesado"}}
	m.results.show_result(Game.last_result)
	await _wait(ResultsScreen.INPUT_LOCK + 0.6)
	await _shot("ui-resultado")


func _wait(seconds: float) -> void:
	await get_tree().create_timer(seconds, true).timeout


func _shot(name: String) -> void:
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	img.save_png(out_dir.path_join(name + ".png"))
	print("salvo ", name)
