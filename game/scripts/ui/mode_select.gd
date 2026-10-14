extends MenuScreen
## Escolha de modo: 2 jogadores ou contra a CPU.


func _ready() -> void:
	var col := build_column("Modo de jogo")
	add_button(col, "2 jogadores", func() -> void: _choose("versus"))
	add_button(col, "Contra a CPU", func() -> void: _choose("cpu"))
	add_button(col, "Voltar", func() -> void: Game.go_menu(), true)
	focus_first()


func _choose(mode: String) -> void:
	Game.mode = mode
	Game.go_to(Game.SELECT_SCENE)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Sfx.play("ui_back")
		Game.go_menu()
