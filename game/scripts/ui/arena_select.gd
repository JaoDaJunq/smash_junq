extends MenuScreen
## Escolha da arena num mapa do Brasil: uma bolinha pulsando em cada região
## (a posição vem de "pin" em Game.ARENAS, em fração do mapa). Clicar ou andar
## com Esquerda/Direita mostra a prévia, o nome e a descrição no painel; Ataque,
## Pulo, Enter ou o botão Confirmar começa a luta. Especial/Esc volta.

const MAP_RECT := Rect2(70, 150, 960, 860)

var index := 0   # posição em _options
var cards: Array[Control] = []   # um marcador por opção (o dado é a "Aleatória")
var _options: Array[int] = []    # -1 = aleatória, senão índice em Game.ARENAS
var _map_box: Control
var _preview: TextureRect
var _name: Label
var _desc: Label
var _confirm: Button
var _starting := false


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(UiArt.backdrop(0.5))
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)
	_content = root
	var title := UiArt.ribbon("ESCOLHA A ARENA", 46)
	title.position = Vector2(960 - 300, 22)
	title.custom_minimum_size = Vector2(600, 0)
	root.add_child(title)

	_options.append(-1)
	for i in Game.ARENAS.size():
		if Game.arena_ready(Game.ARENAS[i]):
			_options.append(i)

	# Mapa
	_map_box = Control.new()
	_map_box.position = MAP_RECT.position
	_map_box.size = MAP_RECT.size
	_map_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(_map_box)
	var map_tex := UiArt.tex(UiArt.MAP)
	var map_area := Rect2(Vector2.ZERO, MAP_RECT.size)
	if map_tex != null:
		var m := TextureRect.new()
		m.texture = map_tex
		m.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		m.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		m.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		m.size = MAP_RECT.size
		m.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_map_box.add_child(m)
		# área real desenhada (a imagem é recortada no contorno do país)
		var k := minf(MAP_RECT.size.x / map_tex.get_width(), MAP_RECT.size.y / map_tex.get_height())
		var drawn := Vector2(map_tex.get_width(), map_tex.get_height()) * k
		map_area = Rect2((MAP_RECT.size - drawn) * 0.5, drawn)
	else:
		var p := Panel.new()
		p.size = MAP_RECT.size
		p.add_theme_stylebox_override("panel", UiArt.panel())
		_map_box.add_child(p)

	for opt in _options:
		var pin: Control
		if opt < 0:
			pin = _dice_button()
			pin.position = Vector2(MAP_RECT.end.x - 250, MAP_RECT.end.y - 70)
			root.add_child(pin)
		else:
			var f: Vector2 = Game.ARENAS[opt].get("pin", Vector2(0.5, 0.5))
			pin = MapPin.new()
			pin.label = Game.ARENAS[opt]["name"]
			pin.position = map_area.position + map_area.size * f - pin.size * 0.5
			_map_box.add_child(pin)
		var i := cards.size()
		pin.mouse_entered.connect(func() -> void: _select(i, false))
		pin.gui_input.connect(func(e: InputEvent) -> void:
			if e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
				_select(i))
		cards.append(pin)

	# Painel da prévia
	var panel := PanelContainer.new()
	panel.position = Vector2(1090, 170)
	panel.custom_minimum_size = Vector2(760, 0)
	panel.add_theme_stylebox_override("panel", UiArt.panel(UiArt.GOLD, 5))
	root.add_child(panel)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 14)
	panel.add_child(v)
	_preview = TextureRect.new()
	_preview.custom_minimum_size = Vector2(720, 450)
	_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_preview.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	v.add_child(_preview)
	_name = make_label("")
	UiArt.outlined(_name, 52, UiArt.CREAM, 10)
	_name.add_theme_font_override("font", load("res://assets/fonts/kenney_future.ttf"))
	v.add_child(_name)
	_desc = make_label("", "HintLabel")
	_desc.add_theme_font_size_override("font_size", 26)
	_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_desc.custom_minimum_size = Vector2(720, 80)
	v.add_child(_desc)
	_confirm = Button.new()
	_confirm.text = "Confirmar"
	_confirm.focus_mode = Control.FOCUS_NONE
	_confirm.custom_minimum_size = Vector2(360, 76)
	_confirm.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	UiArt.style_button(_confirm, 34)
	setup_button_fx(_confirm)
	_confirm.pressed.connect(_confirm_choice)
	v.add_child(_confirm)

	var hint := make_label("Esquerda/Direita ou clique na bolinha  ·  Ataque, Pulo ou Confirmar começa  ·  Especial volta", "HintLabel")
	UiArt.outlined(hint, 22, UiArt.CREAM, 6)
	hint.position = Vector2(360, 1080 - 56)
	hint.size = Vector2(1200, 40)
	root.add_child(hint)
	var back := Button.new()
	back.text = "Voltar"
	back.focus_mode = Control.FOCUS_NONE
	back.size = Vector2(200, 60)
	back.position = Vector2(40, 1080 - 84)
	UiArt.style_button(back, 26)
	setup_button_fx(back)
	back.pressed.connect(_back)
	root.add_child(back)

	index = maxi(0, _options.find(Game.arena_index))
	play_intro.call_deferred()
	_refresh()


func _dice_button() -> Button:
	var b := Button.new()
	b.text = "Aleatória"
	b.focus_mode = Control.FOCUS_NONE
	b.size = Vector2(240, 64)
	UiArt.style_button(b, 26)
	return b


func _process(_delta: float) -> void:
	if _starting:
		return
	for p in PLAYERS:
		if Controles.menu_pressed(p + "_left") or Controles.menu_pressed(p + "_up"):
			_move(-1)
		elif Controles.menu_pressed(p + "_right") or Controles.menu_pressed(p + "_down"):
			_move(1)
		elif Controles.menu_pressed(p + "_attack") or Controles.menu_pressed(p + "_jump"):
			_confirm_choice()
			return
		elif Controles.menu_pressed(p + "_special") or Controles.menu_pressed(p + "_pause"):
			_back()
			return
	if Controles.menu_pressed("ui_left"):
		_move(-1)
	elif Controles.menu_pressed("ui_right"):
		_move(1)
	elif Controles.menu_pressed("ui_accept"):
		_confirm_choice()
	elif Controles.menu_pressed("ui_cancel"):
		_back()


func _move(step: int) -> void:
	_select(posmod(index + step, cards.size()))


func _select(i: int, sound := true) -> void:
	if _starting or i == index:
		return
	index = i
	if sound:
		Sfx.play("ui_move")
	_refresh()
	pop(_preview, 1.04)


func _confirm_choice() -> void:
	if _starting:
		return
	_starting = true
	Game.arena_index = _options[index]
	Sfx.play("ui_confirm")
	pop(cards[index], 1.3, 0.22)
	pop(_confirm, 1.12, 0.22)
	await get_tree().create_timer(0.35).timeout
	Game.go_to(Game.MATCH_SCENE)


func _back() -> void:
	Sfx.play("ui_back")
	Game.go_to(Game.SELECT_SCENE)


func _refresh() -> void:
	for i in cards.size():
		var c := cards[i]
		if c is MapPin:
			(c as MapPin).selected = i == index
		else:
			c.modulate = Color(1.25, 1.2, 0.9) if i == index else Color.WHITE
	var opt := _options[index]
	if opt < 0:
		_name.text = "Aleatória"
		_desc.text = "Uma arena sorteada a cada partida."
		_preview.texture = UiArt.tex(UiArt.MENU_BG)
	else:
		var a: Dictionary = Game.ARENAS[opt]
		_name.text = a["name"]
		_desc.text = String(a.get("desc", ""))
		_preview.texture = UiArt.tex(String(a.get("preview", "")))


## Bolinha do mapa: anel pulsando, maior e dourada quando escolhida, com o nome.
class MapPin extends Control:
	var label := ""
	var selected := false:
		set(v):
			selected = v
			queue_redraw()
	var _t := 0.0

	func _init() -> void:
		size = Vector2(72, 72)
		mouse_filter = Control.MOUSE_FILTER_STOP
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	func _process(delta: float) -> void:
		_t += delta
		queue_redraw()

	func _draw() -> void:
		var c := size * 0.5
		var base := 15.0 if selected else 11.0
		var pulse := fmod(_t * 0.9, 1.0)
		var col := UiArt.GOLD if selected else Color("ff5a3c")
		draw_arc(c, base + pulse * 22.0, 0, TAU, 32, Color(col, 1.0 - pulse), 4.0)
		draw_circle(c + Vector2(0, 3), base + 3, Color(0, 0, 0, 0.4))
		draw_circle(c, base + 3, UiArt.INK)
		draw_circle(c, base, col)
		draw_circle(c + Vector2(-base * 0.3, -base * 0.3), base * 0.3, Color(1, 1, 1, 0.7))
		var font: Font = load("res://assets/fonts/kenney_future_narrow.ttf")
		var fs := 26 if selected else 22
		var w := font.get_string_size(label, HORIZONTAL_ALIGNMENT_CENTER, -1, fs).x
		var at := Vector2(c.x - w * 0.5, c.y + base + 30)
		draw_string_outline(font, at, label, HORIZONTAL_ALIGNMENT_LEFT, -1, fs, 8, UiArt.INK)
		draw_string(font, at, label, HORIZONTAL_ALIGNMENT_LEFT, -1, fs, UiArt.GOLD if selected else UiArt.CREAM)
