class_name MenuScreen
extends Control
## Base das telas de menu: tema simples gerado em código e navegação por foco com
## as ações dos jogadores (p1_/p2_), além do teclado/gamepad padrão do Godot e do mouse.

const PLAYERS := ["p1", "p2"]
const BG := Color(0.105, 0.12, 0.16)
const PANEL := Color(0.16, 0.18, 0.24)
const ACCENT := Color(1.0, 0.82, 0.25)

static var _theme: Theme

## Botões na ordem vertical da tela; a navegação anda por esta lista.
var buttons: Array[Button] = []


static func theme_shared() -> Theme:
	if _theme != null:
		return _theme
	var t := Theme.new()
	t.default_font_size = 26
	t.set_stylebox("normal", "Button", _box(Color(0.2, 0.23, 0.3), Color(0.35, 0.4, 0.5)))
	t.set_stylebox("hover", "Button", _box(Color(0.26, 0.3, 0.4), Color(0.5, 0.56, 0.7)))
	t.set_stylebox("pressed", "Button", _box(Color(0.3, 0.34, 0.46), ACCENT))
	t.set_stylebox("focus", "Button", _box(Color(0.28, 0.32, 0.43), ACCENT, 4))
	t.set_stylebox("disabled", "Button", _box(Color(0.15, 0.16, 0.2), Color(0.25, 0.27, 0.33)))
	t.set_color("font_color", "Button", Color(0.92, 0.94, 1.0))
	t.set_color("font_focus_color", "Button", Color.WHITE)
	t.set_color("font_hover_color", "Button", Color.WHITE)
	t.set_stylebox("panel", "PanelContainer", _box(PANEL, Color(0.3, 0.34, 0.44), 2))
	_theme = t
	return t


static func _box(fill: Color, border: Color, border_width := 2) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = fill
	s.border_color = border
	s.set_border_width_all(border_width)
	s.set_corner_radius_all(10)
	s.content_margin_left = 24
	s.content_margin_right = 24
	s.content_margin_top = 10
	s.content_margin_bottom = 10
	return s


## Cria o esqueleto padrão: fundo e uma coluna centralizada. Devolve a coluna.
func build_column(title: String, subtitle := "", dim_background := false) -> VBoxContainer:
	theme = theme_shared()
	set_anchors_preset(Control.PRESET_FULL_RECT)
	var bg := ColorRect.new()
	bg.color = Color(0, 0, 0, 0.65) if dim_background else BG
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(bg)
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)
	var col := VBoxContainer.new()
	col.add_theme_constant_override("separation", 16)
	center.add_child(col)
	if title != "":
		col.add_child(make_label(title, 72, ACCENT))
	if subtitle != "":
		col.add_child(make_label(subtitle, 26, Color(0.75, 0.8, 0.9)))
	if title != "" or subtitle != "":
		var gap := Control.new()
		gap.custom_minimum_size = Vector2(0, 24)
		col.add_child(gap)
	return col


func make_label(text: String, size := 26, color := Color.WHITE) -> Label:
	var l := Label.new()
	l.text = text
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	return l


func add_button(parent: Control, text: String, on_press: Callable) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(420, 68)
	b.pressed.connect(on_press)
	parent.add_child(b)
	buttons.append(b)
	return b


func focus_first() -> void:
	if not buttons.is_empty():
		buttons[0].grab_focus()


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
