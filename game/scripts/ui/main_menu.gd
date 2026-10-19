extends MenuScreen
## Menu principal: fundo pintado das ilhas de biomas, logotipo em pixel art,
## Juba e Seu Capivas gingando dos lados e botões de placa de madeira.
## Jogar, Como jogar, Opções e Sair.

const FIGHTER_PX := 5.5


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(UiArt.backdrop(0.0))

	# Lutadores dos lados: arte de apresentação (pintada); sem ela, os sprites.
	_add_fighter("res://assets/ui/apresentacao_juba.png", "res://assets/characters/juba/pixel/parado.png", true)
	_add_fighter("res://assets/ui/apresentacao_seu_capivas.png", "res://assets/characters/seu_capivas/pixel/parado.png", false)

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


func _add_fighter(art: String, sprite: String, left: bool) -> void:
	var t := UiArt.tex(art)
	if t == null:
		var f := UiArt.FighterIdle.new().setup(sprite, FIGHTER_PX, 6.0)
		f.flip_h = not left
		f.position = Vector2(110 if left else 1920 - 64 * FIGHTER_PX - 110, 1080 - 64 * FIGHTER_PX + 30)
		add_child(f)
		return
	var r := TextureRect.new()
	r.name = "Apresentacao" + ("Juba" if left else "Capivas")
	r.texture = t
	r.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	r.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	r.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	r.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var h := 720.0
	var w := h * t.get_width() / t.get_height()
	r.size = Vector2(w, h)
	r.position = Vector2(30 if left else 1920 - w - 20, 1080 - h - 12)
	add_child(r)
	# entra deslizando do lado e depois "respira" bem de leve
	var end := r.position
	r.position.x += -260 if left else 260
	r.modulate.a = 0.0
	var tw := r.create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(r, "position", end, 0.45).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).set_delay(0.1)
	tw.parallel().tween_property(r, "modulate:a", 1.0, 0.3).set_delay(0.1)
	r.pivot_offset = Vector2(w * 0.5, h)
	var idle := r.create_tween().set_loops().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	idle.tween_interval(0.6)
	idle.tween_property(r, "scale", Vector2(1.0, 1.012), 1.4).set_trans(Tween.TRANS_SINE)
	idle.tween_property(r, "scale", Vector2.ONE, 1.4).set_trans(Tween.TRANS_SINE)
