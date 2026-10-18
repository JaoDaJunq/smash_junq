class_name ControlsScreen
extends MenuScreen
## Tela de controles (Opções → Controles): para cada ação, um botão por jogador
## mostrando a tecla (ou botão do mouse) e o botão do controle. Clicar (ou
## confirmar) num botão e apertar a tecla, o botão do mouse ou o botão do
## controle desejado troca aquela vaga. Esc cancela. Salvo pelo autoload Controles.
##
## Navegação: setas/analógico andam pela grade, confirmar escolhe, Esc volta.

const CELL_W := 330.0
const NAME_W := 300.0
const ARM_DELAY := 0.2   # ignora o próprio aperto que começou a escuta

## [ação, jogador] -> Button
var cells := {}
var grid: GridContainer
var hint: Label
var reset_button: Button
var back_button: Button
## Botão esperando uma tecla ("" = nenhum).
var listening_action := ""
var _listen_button: Button
var _armed_at := 0.0
var _clock := 0.0
var _rows: Array[Array] = []   # linhas de botões navegáveis (grade + rodapé)


func _ready() -> void:
	var col := build_column("Controles")
	col.add_theme_constant_override("separation", 12)
	grid = GridContainer.new()
	grid.columns = 3
	grid.add_theme_constant_override("h_separation", 18)
	grid.add_theme_constant_override("v_separation", 6)
	grid.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	col.add_child(grid)
	grid.add_child(_head("Ação", ACCENT, NAME_W))
	grid.add_child(_head("Jogador 1", Game.PLAYER_COLORS["p1"], CELL_W))
	grid.add_child(_head("Jogador 2", Game.PLAYER_COLORS["p2"], CELL_W))
	for a in Controles.ACTIONS:
		var name_label := make_label(a[1])
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		name_label.custom_minimum_size = Vector2(NAME_W, 44)
		grid.add_child(name_label)
		var row: Array = []
		for p in ["p1", "p2"]:
			var action := "%s_%s" % [p, a[0]]
			var b := Button.new()
			b.custom_minimum_size = Vector2(CELL_W, 44)
			b.add_theme_font_size_override("font_size", 22)
			b.focus_mode = Control.FOCUS_ALL
			b.pressed.connect(_start_listen.bind(action, b))
			grid.add_child(b)
			cells[action] = b
			row.append(b)
		_rows.append(row)
	hint = make_label("", "HintLabel")
	hint.custom_minimum_size = Vector2(0, 34)
	col.add_child(hint)
	var footer := HBoxContainer.new()
	footer.add_theme_constant_override("separation", 24)
	footer.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	col.add_child(footer)
	reset_button = add_button(footer, "Restaurar padrão", _reset)
	back_button = add_button(footer, "Voltar", _go_back, true)
	_rows.append([reset_button, back_button])
	col.add_child(make_label("Escolha uma ação e aperte a tecla, botão do mouse ou do controle  ·  Esc cancela/volta", "HintLabel"))
	_refresh()
	_rows[0][0].grab_focus()


func _head(text: String, color: Color, width: float) -> Label:
	var l := make_label(text, "", color)
	l.custom_minimum_size = Vector2(width, 40)
	return l


func _refresh() -> void:
	for action in cells:
		var key := Controles.describe(action, "teclado")
		var pad := Controles.describe(action, "controle")
		cells[action].text = key if pad == "—" else "%s  ·  %s" % [key, pad]


func _start_listen(action: String, b: Button) -> void:
	listening_action = action
	_listen_button = b
	_armed_at = _clock + ARM_DELAY
	b.text = "Aperte uma tecla…"
	hint.text = ""


func _stop_listen() -> void:
	listening_action = ""
	_listen_button = null
	_refresh()


func _input(event: InputEvent) -> void:
	if not is_visible_in_tree():
		return
	if listening_action != "":
		get_viewport().set_input_as_handled()  # nada mais reage enquanto escuta
		if _clock < _armed_at or not Controles.is_bindable(event):
			return
		if event is InputEventKey and (event as InputEventKey).physical_keycode == KEY_ESCAPE \
				and not listening_action.ends_with("_pause"):
			Sfx.play("ui_back")
			_stop_listen()
			return
		apply_binding(listening_action, event)
		return
	# Navegação própria (a grade tem duas colunas).
	for a in ["ui_up", "ui_down", "ui_left", "ui_right", "ui_accept", "ui_cancel"]:
		if event.is_action_pressed(a) and not event is InputEventMouse:
			get_viewport().set_input_as_handled()
			_nav(a)
			return


## Troca a vaga da ação pelo evento e mostra aviso se o botão já era usado.
func apply_binding(action: String, event: InputEvent) -> void:
	var b := _listen_button
	var conflicts := Controles.rebind(action, event)
	_stop_listen()
	Sfx.play("ui_confirm")
	if not conflicts.is_empty():
		var names: Array[String] = []
		for c in conflicts:
			names.append(_label(c))
		hint.text = "Atenção: %s também usa %s" % [", ".join(names), Controles.event_name(event)]
		hint.add_theme_color_override("font_color", ACCENT)
	else:
		hint.text = "%s: %s" % [_label(action), Controles.event_name(event)]
		hint.add_theme_color_override("font_color", GOOD)
	if b:
		b.grab_focus()


func _label(action: String) -> String:
	var p := "J1" if action.begins_with("p1") else "J2"
	var key := action.substr(3)
	for a in Controles.ACTIONS:
		if a[0] == key:
			return "%s %s" % [p, a[1]]
	return action


func _nav(a: String) -> void:
	var focus := get_viewport().gui_get_focus_owner()
	var r := -1
	var c := 0
	for i in _rows.size():
		var j: int = _rows[i].find(focus)
		if j >= 0:
			r = i
			c = j
	if a == "ui_cancel":
		Sfx.play("ui_back")
		_go_back()
		return
	if a == "ui_accept":
		if focus is Button:
			(focus as Button).pressed.emit()
		return
	if r < 0:
		_rows[0][0].grab_focus()
		return
	match a:
		"ui_up": r = maxi(r - 1, 0)
		"ui_down": r = mini(r + 1, _rows.size() - 1)
		"ui_left": c -= 1
		"ui_right": c += 1
	c = clampi(c, 0, _rows[r].size() - 1)
	_rows[r][c].grab_focus()
	Sfx.play("ui_move")


func _process(delta: float) -> void:
	_clock += delta


func _reset() -> void:
	Controles.reset_to_defaults()
	_refresh()
	hint.text = "Controles de volta ao padrão"
	hint.add_theme_color_override("font_color", GOOD)


func _go_back() -> void:
	Game.go_to(Game.OPTIONS_SCENE)
