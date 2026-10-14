extends MenuScreen
## Menu principal: Jogar e Sair.


func _ready() -> void:
	var col := build_column("SMASH JUNQ", "Platform fighter 2D")
	add_button(col, "Jogar", func() -> void: Game.go_to(Game.MODE_SCENE))
	add_button(col, "Sair", func() -> void: get_tree().quit())
	var hint := make_label("Navegue com direcional / WASD / setas  ·  Confirme com Ataque, Pulo ou Enter", 20, Color(0.6, 0.66, 0.78))
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 30)
	col.add_child(gap)
	col.add_child(hint)
	focus_first()
