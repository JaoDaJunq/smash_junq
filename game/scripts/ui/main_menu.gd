extends MenuScreen
## Menu principal: fundo pintado das ilhas de biomas, logotipo em pixel art,
## Juba e Seu Capivas gingando dos lados e botões de placa de madeira.
## Jogar, Como jogar, Opções e Sair.

const FIGHTER_PX := 5.5


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(UiArt.backdrop(0.0))

	# Lutadores nos cantos de baixo, um olhando para o outro
	var juba := UiArt.FighterIdle.new().setup("res://assets/characters/juba/pixel/parado.png", FIGHTER_PX, 6.0)
	juba.name = "Juba"
	juba.position = Vector2(110, 1080 - 64 * FIGHTER_PX + 30)
	add_child(juba)
	var capi := UiArt.FighterIdle.new().setup("res://assets/characters/seu_capivas/pixel/parado.png", FIGHTER_PX, 5.0)
	capi.name = "Capivas"
	capi.flip_h = true
	capi.position = Vector2(1920 - 64 * FIGHTER_PX - 110, 1080 - 64 * FIGHTER_PX + 30)
	add_child(capi)

	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(center)
	_content = center
	var col := VBoxContainer.new()
	col.add_theme_constant_override("separation", 18)
	center.add_child(col)

	# Logotipo (pixel art) balançando de leve; sem arte, uma faixa com o nome
	var logo_tex := UiArt.tex(UiArt.LOGO)
	var logo_box := Control.new()
	logo_box.custom_minimum_size = Vector2(980, 400)
	logo_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	col.add_child(logo_box)
	var logo: Control
	if logo_tex != null:
		var r := TextureRect.new()
		r.texture = logo_tex
		r.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		r.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		r.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		r.size = logo_box.custom_minimum_size
		logo = r
	else:
		logo = UiArt.ribbon("SMASH JUNQ", 110)
		logo.position = Vector2(100, 130)
	logo.name = "Logo"
	logo_box.add_child(logo)
	logo.pivot_offset = logo_box.custom_minimum_size * 0.5
	# parado: o criador não gostou do balanço

	for entry in [["Jogar", func() -> void: Game.go_to(Game.MODE_SCENE), false],
			["Como jogar", func() -> void: Game.go_to(Game.HOW_TO_PLAY_SCENE), false],
			["Opções", func() -> void: Game.go_to(Game.OPTIONS_SCENE), false],
			["Sair", func() -> void: get_tree().quit(), true]]:
		var b := add_button(col, entry[0], entry[1], entry[2])
		b.custom_minimum_size = Vector2(460, 76)
		b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		UiArt.style_button(b)

	var hint := make_label("Direcional, WASD ou setas  ·  Ataque, Pulo ou Enter confirma", "HintLabel")
	UiArt.outlined(hint, 22, UiArt.CREAM, 6)
	hint.position = Vector2(460, 1080 - 52)
	hint.size = Vector2(1000, 40)
	add_child(hint)
	play_intro.call_deferred()
	focus_first()
