class_name OptionsScreen
extends MenuScreen
## Tela de Opções: três volumes (deslizantes), tela cheia e tremor de tela
## (liga/desliga) e Voltar. Tudo vale na hora e é salvo pelo autoload Settings.
##
## Navegação por teclado e gamepad (ui_* e p1_/p2_): cima/baixo troca de linha,
## esquerda/direita ajusta o deslizante em passos de 10% (segurar repete),
## confirmar liga/desliga ou aperta Voltar, cancelar volta. O Godot não move o
## foco sozinho aqui: as teclas de interface são engolidas em _input e tudo passa
## por _process, para um aperto valer uma vez só (e para testes poderem simular).

const STEP := 0.1
const REPEAT_DELAY := 0.4
const REPEAT_RATE := 0.1
const SOUND_GAP_MS := 70
const LABEL_WIDTH := 380.0
const CONTROL_WIDTH := 460.0
const NAV_ACTIONS := ["ui_up", "ui_down", "ui_left", "ui_right", "ui_accept"]

static var _grabber: Texture2D
static var _grabber_hot: Texture2D

## Todos os controles com foco, de cima para baixo (deslizantes, botões, Voltar).
var focusables: Array[Control] = []
## chave da opção -> HSlider / Button de liga-desliga (usado também pelos testes).
var sliders := {}
var toggles := {}

var _row_labels := {}  # controle -> Label do nome (destaca a linha em foco)
var _value_labels := {}  # HSlider -> Label com a porcentagem
var _hold_dir := 0
var _hold_time := 0.0
var _last_sound_ms := 0


func _ready() -> void:
	var col := build_column("Opções")
	col.add_theme_constant_override("separation", 14)
	_add_slider(col, "Volume geral", "master_volume")
	_add_slider(col, "Efeitos sonoros", "sfx_volume")
	_add_slider(col, "Música", "music_volume")
	_add_toggle(col, "Tela cheia", "fullscreen")
	_add_toggle(col, "Tremor de tela", "screen_shake")
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 12)
	col.add_child(gap)
	var controls := add_button(col, "Controles", func() -> void: Game.go_to(Game.CONTROLS_SCENE))
	controls.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	focusables.append(controls)
	var back := add_button(col, "Voltar", _go_back, true)
	back.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	focusables.append(back)
	col.add_child(make_label("Cima/baixo escolhe  ·  Esquerda/direita ajusta  ·  Confirmar liga/desliga  ·  Esc volta", "HintLabel"))
	focus_first()


# --- Montagem ---

func _make_row(parent: Control, text: String) -> HBoxContainer:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 24)
	row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	parent.add_child(row)
	var name_label := make_label(text)
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	name_label.custom_minimum_size = Vector2(LABEL_WIDTH, 60)
	row.add_child(name_label)
	return row


func _add_slider(parent: Control, text: String, key: String) -> void:
	var row := _make_row(parent, text)
	var slider := HSlider.new()
	slider.min_value = 0.0
	slider.max_value = 1.0
	slider.step = STEP
	slider.scrollable = false
	slider.custom_minimum_size = Vector2(CONTROL_WIDTH, 60)
	slider.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	_style_slider(slider)
	slider.set_value_no_signal(float(Settings.get(key)))
	row.add_child(slider)
	var value_label := make_label("", "AccentLabel")
	value_label.custom_minimum_size = Vector2(110, 60)
	value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	value_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(value_label)
	_value_labels[slider] = value_label
	_row_labels[slider] = row.get_child(0)
	_show_percent(slider)
	slider.value_changed.connect(_on_slider_changed.bind(slider, key))
	slider.focus_entered.connect(_on_row_focus.bind(slider, true))
	slider.focus_exited.connect(_on_row_focus.bind(slider, false))
	sliders[key] = slider
	focusables.append(slider)


func _add_toggle(parent: Control, text: String, key: String) -> void:
	var row := _make_row(parent, text)
	var b := Button.new()
	b.toggle_mode = true
	b.custom_minimum_size = Vector2(CONTROL_WIDTH, 60)
	b.set_pressed_no_signal(bool(Settings.get(key)))
	b.text = _toggle_text(b.button_pressed)
	row.add_child(b)
	setup_button_fx(b)
	b.toggled.connect(_on_toggled.bind(b, key))
	b.focus_entered.connect(_on_row_focus.bind(b, true))
	b.focus_exited.connect(_on_row_focus.bind(b, false))
	_row_labels[b] = row.get_child(0)
	toggles[key] = b
	focusables.append(b)


func _style_slider(slider: HSlider) -> void:
	slider.add_theme_stylebox_override("slider", _track(Color(0.20, 0.23, 0.35), 14))
	slider.add_theme_stylebox_override("grabber_area", _track(Color(0.75, 0.58, 0.20), 14))
	slider.add_theme_stylebox_override("grabber_area_highlight", _track(ACCENT, 14))
	slider.add_theme_icon_override("grabber", _grabber_icon(false))
	slider.add_theme_icon_override("grabber_highlight", _grabber_icon(true))
	slider.add_theme_icon_override("grabber_disabled", _grabber_icon(false))


func _track(color: Color, height: int) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = color
	s.set_corner_radius_all(int(height * 0.5))
	s.content_margin_top = height * 0.5
	s.content_margin_bottom = height * 0.5
	return s


## Bolinha do botão do deslizante (desenhada em código, sem arquivo de imagem).
static func _grabber_icon(hot: bool) -> Texture2D:
	if hot and _grabber_hot != null:
		return _grabber_hot
	if not hot and _grabber != null:
		return _grabber
	var size := 40
	var color := ACCENT if hot else Color("f3efe6")
	var img := Image.create_empty(size, size, false, Image.FORMAT_RGBA8)
	var c := (size - 1) * 0.5
	for y in size:
		for x in size:
			var d := Vector2(x - c, y - c).length()
			var edge := clampf(c - d + 0.5, 0.0, 1.0)
			var ring := clampf(d - (c - 4.0), 0.0, 1.0)  # contorno escuro fino
			var px := color.lerp(Color(0.05, 0.06, 0.10), ring * 0.6)
			px.a = edge
			img.set_pixel(x, y, px)
	var tex := ImageTexture.create_from_image(img)
	if hot:
		_grabber_hot = tex
	else:
		_grabber = tex
	return tex


# --- Reações ---

func _on_slider_changed(value: float, slider: HSlider, key: String) -> void:
	Settings.set_value(key, snappedf(value, 0.01))
	_show_percent(slider)
	# Ouve o volume novo ao mexer (no próprio deslizante de efeitos, já com ele)
	var now := Time.get_ticks_msec()
	if now - _last_sound_ms >= SOUND_GAP_MS:
		_last_sound_ms = now
		Sfx.play("ui_move")


func _show_percent(slider: HSlider) -> void:
	(_value_labels[slider] as Label).text = "%d%%" % roundi(slider.value * 100.0)


func _on_toggled(on: bool, b: Button, key: String) -> void:
	b.text = _toggle_text(on)
	Settings.set_value(key, on)
	Sfx.play("ui_confirm")


func _toggle_text(on: bool) -> String:
	return "Ligado" if on else "Desligado"


## Destaca o nome da linha em foco.
func _on_row_focus(c: Control, focused: bool) -> void:
	var l: Label = _row_labels[c]
	if focused:
		l.add_theme_color_override("font_color", ACCENT)
		if c is HSlider and not _silent_focus:
			Sfx.play("ui_move")
	else:
		l.remove_theme_color_override("font_color")


func _go_back() -> void:
	Game.go_menu()


# --- Foco e entrada ---

func focus_first() -> void:
	if focusables.is_empty():
		return
	_silent_focus = true
	focusables[0].grab_focus()
	_silent_focus = false


func _input(event: InputEvent) -> void:
	# Teclas/botões de interface passam só por _process (veja o comentário no topo).
	if not is_visible_in_tree() or event is InputEventMouse:
		return
	for a in NAV_ACTIONS:
		if event.is_action(a):
			get_viewport().set_input_as_handled()
			return


func _process(delta: float) -> void:
	if focusables.is_empty() or not is_visible_in_tree():
		return
	if _just(["ui_cancel"]):
		Sfx.play("ui_back")
		_go_back()
		return
	var vertical := int(_just(_actions("down"))) - int(_just(_actions("up")))
	if vertical != 0:
		move_focus(vertical)
		return
	var held := int(_held(_actions("right"))) - int(_held(_actions("left")))
	var pressed := int(_just(_actions("right"))) - int(_just(_actions("left")))
	if pressed != 0:
		_hold_dir = pressed
		_hold_time = 0.0
		adjust(pressed)
	elif held != 0 and held == _hold_dir:
		_hold_time += delta
		if _hold_time >= REPEAT_DELAY:
			_hold_time -= REPEAT_RATE
			adjust(held)
	else:
		_hold_dir = held
		_hold_time = 0.0
	if _just(["ui_accept", "p1_attack", "p1_jump", "p2_attack", "p2_jump"]):
		activate()


func _actions(suffix: String) -> Array:
	return ["ui_" + suffix, "p1_" + suffix, "p2_" + suffix]


func _just(actions: Array) -> bool:
	for a in actions:
		if Input.is_action_just_pressed(a):
			return true
	return false


func _held(actions: Array) -> bool:
	for a in actions:
		if Input.is_action_pressed(a):
			return true
	return false


func focused_index() -> int:
	return focusables.find(get_viewport().gui_get_focus_owner())


## Anda o foco para a linha de cima (-1) ou de baixo (+1), sem dar a volta.
func move_focus(step: int) -> void:
	var i := focused_index()
	focusables[clampi(i + step, 0, focusables.size() - 1)].grab_focus()


## Esquerda/direita no controle em foco: deslizante muda 10%; liga/desliga vai
## para Desligado (esquerda) ou Ligado (direita).
func adjust(direction: int) -> void:
	var c := focusables[maxi(focused_index(), 0)]
	if c is HSlider:
		(c as HSlider).value = snappedf((c as HSlider).value + direction * STEP, 0.01)
	elif c is Button and (c as Button).toggle_mode:
		(c as Button).button_pressed = direction > 0


## Confirmar no controle em foco: inverte o liga/desliga ou aperta Voltar.
func activate() -> void:
	var c := focusables[maxi(focused_index(), 0)]
	if c is Button:
		if (c as Button).toggle_mode:
			(c as Button).button_pressed = not (c as Button).button_pressed
		else:
			(c as Button).pressed.emit()
