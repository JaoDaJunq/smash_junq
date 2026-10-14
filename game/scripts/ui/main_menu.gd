extends MenuScreen
## Menu principal: Jogar e Sair.


func _ready() -> void:
	var col := build_column("SMASH JUNQ", "Platform fighter 2D", false, 96)
	add_button(col, "Jogar", func() -> void: Game.go_to(Game.MODE_SCENE))
	add_button(col, "Sair", func() -> void: get_tree().quit(), true)
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 30)
	col.add_child(gap)
	col.add_child(make_label("Navegue com direcional / WASD / setas  ·  Confirme com Ataque, Pulo ou Enter", "HintLabel"))
	focus_first()
