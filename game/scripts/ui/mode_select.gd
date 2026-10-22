extends MenuScreen
## Escolha de modo: 2 jogadores, contra a CPU ou treino.


func _ready() -> void:
	var col := build_column("")
	col.add_theme_constant_override("separation", 18)
	var title := UiArt.ribbon("MODO DE JOGO", 50)
	col.add_child(title)
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 20)
	col.add_child(gap)
	add_button(col, "2 jogadores", func() -> void: _choose("versus"))
	add_button(col, "Contra a CPU", func() -> void: _choose("cpu"))
	add_button(col, "Treino", func() -> void: _choose("training"))
	add_button(col, "Voltar", func() -> void: Game.go_menu(), true)
	for b in buttons:
		b.custom_minimum_size = Vector2(460, 76)
		b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		UiArt.style_button(b)
	focus_first()


func _choose(mode: String) -> void:
	Game.mode = mode
	Game.go_to(Game.SELECT_SCENE)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Sfx.play("ui_back")
		Game.go_menu()
