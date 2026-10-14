class_name MenuScreen
extends Control
## Base das telas de menu: visual vem do tema do projeto (assets/ui/theme.tres),
## navegação por foco com as ações dos jogadores (p1_/p2_), além do teclado/gamepad
## padrão do Godot e do mouse. Cuida também dos sons (mover, confirmar, voltar) e
## das animações curtas de entrada e de foco, que funcionam com a árvore pausada.

const PLAYERS := ["p1", "p2"]
const THEME_PATH := "res://assets/ui/theme.tres"
const BG_TOP := Color("2a2f4f")
const BG_BOTTOM := Color("0f121c")
const DIM := Color(0.03, 0.04, 0.09, 0.74)
const ACCENT := Color("ffc83d")
const MUTED := Color("a9b1c8")
const GOOD := Color("7dffa0")

const INTRO_TIME := 0.22
const FOCUS_TIME := 0.12
const FOCUS_SCALE := 1.05

static var _theme: Theme

## Botões na ordem vertical da tela; a navegação anda por esta lista.
var buttons: Array[Button] = []

## Conteúdo central (entra com fade + deslize + escala quando a tela aparece).
var _content: Control
var _intro_tween: Tween
## Quando true, mudar o foco não toca som (foco inicial da tela).
var _silent_focus := false


static func theme_shared() -> Theme:
	if _theme == null:
		_theme = load(THEME_PATH) as Theme
	return _theme


## Cria o esqueleto padrão: fundo e uma coluna centralizada. Devolve a coluna.
func build_column(title: String, subtitle := "", dim_background := false, title_size := 0) -> VBoxContainer:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	if dim_background:
		var dim := ColorRect.new()
		dim.color = DIM
		dim.set_anchors_preset(Control.PRESET_FULL_RECT)
		dim.mouse_filter = Control.MOUSE_FILTER_STOP
		add_child(dim)
	else:
		add_child(_make_backdrop())
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)
	_content = center
	var col := VBoxContainer.new()
	col.add_theme_constant_override("separation", 16)
	center.add_child(col)
	if title != "":
		var t := make_label(title, "TitleLabel")
		if title_size > 0:
			t.add_theme_font_size_override("font_size", title_size)
		col.add_child(t)
		col.add_child(_make_rule())
	if subtitle != "":
		col.add_child(make_label(subtitle, "SubtitleLabel"))
	if title != "" or subtitle != "":
		var gap := Control.new()
		gap.custom_minimum_size = Vector2(0, 24)
		col.add_child(gap)
	# Entrada da tela (depois do primeiro layout; ignora se a tela nasce escondida)
	play_intro.call_deferred()
	return col


## Fundo em degradê vertical (anoitecer), com a cor sólida como reserva.
func _make_backdrop() -> Control:
	var grad := Gradient.new()
	grad.set_color(0, BG_TOP)
	grad.set_color(1, BG_BOTTOM)
	var tex := GradientTexture2D.new()
	tex.gradient = grad
	tex.fill_from = Vector2(0.5, 0.0)
	tex.fill_to = Vector2(0.5, 1.0)
	var rect := TextureRect.new()
	rect.texture = tex
	rect.stretch_mode = TextureRect.STRETCH_SCALE
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.mouse_filter = Control.MOUSE_FILTER_STOP
	return rect


## Filete dourado curto sob o título.
func _make_rule() -> Control:
	var bar := Panel.new()
	var style := StyleBoxFlat.new()
	style.bg_color = ACCENT
	style.set_corner_radius_all(3)
	bar.add_theme_stylebox_override("panel", style)
	bar.custom_minimum_size = Vector2(160, 6)
	bar.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	bar.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return bar


## variation: tipo do tema (TitleLabel, SubtitleLabel, HintLabel, HeadingLabel...).
## color: se informada, troca só a cor do texto.
func make_label(text: String, variation := "", color := Color(0, 0, 0, 0)) -> Label:
	var l := Label.new()
	l.text = text
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if variation != "":
		l.theme_type_variation = variation
	if color.a > 0.0:
		l.add_theme_color_override("font_color", color)
	return l


## is_back: o botão cancela/volta (toca o som de voltar em vez do de confirmar).
func add_button(parent: Control, text: String, on_press: Callable, is_back := false) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(440, 70)
	setup_button_fx(b)
	b.pressed.connect(_on_button_pressed.bind(b, is_back))
	b.pressed.connect(on_press)
	parent.add_child(b)
	buttons.append(b)
	return b


## Liga som de foco e animação de foco/mouse a um botão (também usado por botões fora da lista).
func setup_button_fx(b: Button) -> void:
	b.resized.connect(func() -> void: b.pivot_offset = b.size * 0.5)
	b.focus_entered.connect(_on_button_focus.bind(b, true))
	b.focus_exited.connect(_on_button_focus.bind(b, false))
	# Mouse passando por cima leva o foco junto: um só destaque na tela
	b.mouse_entered.connect(func() -> void:
		if not b.disabled and b.focus_mode != Control.FOCUS_NONE and not b.has_focus():
			b.grab_focus())


func _on_button_focus(b: Button, focused: bool) -> void:
	if focused and not _silent_focus:
		Sfx.play("ui_move")
	_tween_button(b, FOCUS_SCALE if focused else 1.0, Color(1.12, 1.12, 1.12) if focused else Color.WHITE, FOCUS_TIME)


func _on_button_pressed(b: Button, is_back: bool) -> void:
	Sfx.play("ui_back" if is_back else "ui_confirm")
	# Aperto: afunda um instante e volta ao tamanho de foco
	var tw := _tween_button(b, 0.96, Color(1.25, 1.25, 1.25), 0.05)
	if tw != null:
		tw.chain().tween_property(b, "scale", Vector2.ONE * FOCUS_SCALE, 0.09)


func _tween_button(b: Button, target_scale: float, target_modulate: Color, time: float) -> Tween:
	if not b.is_inside_tree():
		return null
	if b.has_meta("fx_tween"):
		var old := b.get_meta("fx_tween") as Tween
		if old != null and old.is_valid():
			old.kill()
	b.pivot_offset = b.size * 0.5
	var tw := b.create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(b, "scale", Vector2.ONE * target_scale, time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tw.tween_property(b, "modulate", target_modulate, time)
	b.set_meta("fx_tween", tw)
	return tw


## Entrada da tela: fade + deslize curto + escala leve (rápida; roda mesmo pausado).
func play_intro() -> void:
	if _content == null or not is_visible_in_tree():
		return
	if _intro_tween != null and _intro_tween.is_valid():
		_intro_tween.kill()
	_content.pivot_offset = _content.size * 0.5
	_content.scale = Vector2(0.96, 0.96)
	_content.position = Vector2(0, 24)
	modulate.a = 0.0
	_intro_tween = create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_intro_tween.tween_property(self, "modulate:a", 1.0, INTRO_TIME * 0.8)
	_intro_tween.tween_property(_content, "scale", Vector2.ONE, INTRO_TIME).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_intro_tween.tween_property(_content, "position", Vector2.ZERO, INTRO_TIME).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


## Pequeno "pulo" de escala num controle (troca de lutador, confirmação...).
func pop(c: Control, strength := 1.15, time := 0.18) -> void:
	if c == null or not c.is_inside_tree():
		return
	c.pivot_offset = c.size * 0.5
	c.scale = Vector2.ONE * strength
	c.create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).tween_property(c, "scale", Vector2.ONE, time).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED and _content != null and is_visible_in_tree():
		play_intro()


## Foco inicial da tela: sem som de "mover".
func focus_first() -> void:
	if buttons.is_empty():
		return
	_silent_focus = true
	buttons[0].grab_focus()
	_silent_focus = false


func _process(_delta: float) -> void:
	if buttons.is_empty() or not is_visible_in_tree():
		return
	_poll_buttons()


## O Godot já move o foco com setas/direcional/Enter (ui_*). Aqui só entram as
## ações que ele não conhece (WASD, Ataque, Numpad), sem repetir o que ele fez.
func _poll_buttons() -> void:
	var index := -1
	for i in buttons.size():
		if buttons[i].has_focus():
			index = i
	var step := 0
	if not Input.is_action_just_pressed("ui_down") and not Input.is_action_just_pressed("ui_up"):
		for p in PLAYERS:
			if Input.is_action_just_pressed(p + "_down"):
				step += 1
			if Input.is_action_just_pressed(p + "_up"):
				step -= 1
	if step != 0:
		buttons[clampi(index + signi(step), 0, buttons.size() - 1)].grab_focus()
		return
	if index < 0 or Input.is_action_just_pressed("ui_accept"):
		return
	for p in PLAYERS:
		if Input.is_action_just_pressed(p + "_attack") or Input.is_action_just_pressed(p + "_jump"):
			buttons[index].pressed.emit()
			return
