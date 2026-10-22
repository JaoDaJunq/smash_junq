class_name PauseMenu
extends MenuScreen
## Menu de pausa da luta. Fica sempre ativo (process_mode ALWAYS) e usa
## get_tree().paused para congelar o resto. Pausa com p1_pause ou p2_pause.

## Quem controla a partida (MatchManager) — define quando pode pausar e reinicia.
var match_manager: Node


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var col := build_column("", "", true)
	col.add_theme_constant_override("separation", 18)
	col.add_child(UiArt.ribbon("PAUSA", 56))
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 16)
	col.add_child(gap)
	add_button(col, "Continuar", close, true)
	add_button(col, "Reiniciar", _restart)
	add_button(col, "Sair para o menu", _quit_to_menu, true)
	for b in buttons:
		b.custom_minimum_size = Vector2(460, 76)
		b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		UiArt.style_button(b)
	visible = false


func _process(delta: float) -> void:
	for p in PLAYERS:
		if Controles.menu_pressed(p + "_pause"):
			toggle()
			return
	super._process(delta)


func toggle() -> void:
	if visible:
		Sfx.play("ui_back")
		close()
	else:
		open()


func open() -> void:
	if match_manager != null and not match_manager.can_pause():
		return
	Sfx.play("ui_confirm", -3.0)
	visible = true
	get_tree().paused = true
	focus_first()


func close() -> void:
	visible = false
	get_tree().paused = false


func _restart() -> void:
	close()
	if match_manager != null:
		match_manager.restart()


func _quit_to_menu() -> void:
	visible = false
	Game.go_menu()
