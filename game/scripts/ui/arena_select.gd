extends MenuScreen
## Escolha da arena, depois dos personagens. Um cartão por arena (prévia, nome e
## como é o mapa) mais "Aleatória". Esquerda/Direita escolhe, Ataque/Pulo/Enter
## ou clique confirma, Especial/Esc/Pausa volta para os personagens.
## Quem escolhe: qualquer jogador (no modo CPU e treino, o Jogador 1).

const CARD_W := 330.0
const CARD_H := 300.0

var index := 0   # 0 = Aleatória; 1.. = Game.ARENAS[index - 1]
var cards: Array[PanelContainer] = []
var _options: Array[int] = []   # -1 = aleatória, senão índice em Game.ARENAS
var _desc: Label
var _starting := false


func _ready() -> void:
	var col := build_column("Escolha a arena")
	_options.append(-1)
	for i in Game.ARENAS.size():
		if Game.arena_ready(Game.ARENAS[i]):
			_options.append(i)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 22)
	row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	col.add_child(row)
	for opt in _options:
		var card := _card(opt)
		row.add_child(card)
		cards.append(card)
	_desc = make_label("", "HintLabel")
	_desc.add_theme_font_size_override("font_size", 26)
	_desc.custom_minimum_size = Vector2(1400, 70)
	_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	col.add_child(_desc)
	col.add_child(make_label("Esquerda/Direita escolhe  ·  Ataque, Pulo ou clique confirma  ·  Especial ou Esc volta", "HintLabel"))
	index = maxi(0, _options.find(Game.arena_index))
	_refresh()


func _card(opt: int) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(CARD_W, CARD_H)
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 8)
	panel.add_child(v)
	var pic := TextureRect.new()
	pic.custom_minimum_size = Vector2(CARD_W - 20, 190)
	pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	pic.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	pic.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	if opt >= 0:
		var path := String(Game.ARENAS[opt].get("preview", ""))
		if path != "" and ResourceLoader.exists(path):
			pic.texture = load(path)
	v.add_child(pic)
	var name := make_label("Aleatória" if opt < 0 else Game.ARENAS[opt]["name"], "HeadingLabel")
	name.add_theme_font_size_override("font_size", 30)
	v.add_child(name)
	panel.gui_input.connect(func(e: InputEvent) -> void:
		if e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
			index = cards.find(panel)
			_confirm())
	panel.mouse_entered.connect(func() -> void:
		if not _starting:
			index = cards.find(panel)
			_refresh())
	return panel


func _process(_delta: float) -> void:
	if _starting:
		return
	for p in PLAYERS:
		if Controles.menu_pressed(p + "_left"):
			_move(-1)
		elif Controles.menu_pressed(p + "_right"):
			_move(1)
		elif Controles.menu_pressed(p + "_attack") or Controles.menu_pressed(p + "_jump"):
			_confirm()
			return
		elif Controles.menu_pressed(p + "_special") or Controles.menu_pressed(p + "_pause"):
			_back()
			return
	if Controles.menu_pressed("ui_left"):
		_move(-1)
	elif Controles.menu_pressed("ui_right"):
		_move(1)
	elif Controles.menu_pressed("ui_accept"):
		_confirm()
	elif Controles.menu_pressed("ui_cancel"):
		_back()


func _move(step: int) -> void:
	index = posmod(index + step, cards.size())
	Sfx.play("ui_move")
	_refresh()
	pop(cards[index], 1.06)


func _confirm() -> void:
	if _starting:
		return
	_starting = true
	Game.arena_index = _options[index]
	Sfx.play("ui_confirm")
	pop(cards[index], 1.12, 0.22)
	await get_tree().create_timer(0.35).timeout
	Game.go_to(Game.MATCH_SCENE)


func _back() -> void:
	Sfx.play("ui_back")
	Game.go_to(Game.SELECT_SCENE)


func _refresh() -> void:
	for i in cards.size():
		var on := i == index
		var style := StyleBoxFlat.new()
		style.bg_color = Color(0.09, 0.106, 0.157, 0.95)
		style.border_color = ACCENT if on else Color(0.204, 0.235, 0.345)
		style.set_border_width_all(5 if on else 2)
		style.set_corner_radius_all(14)
		style.set_content_margin_all(10)
		cards[i].add_theme_stylebox_override("panel", style)
		cards[i].modulate = Color.WHITE if on else Color(1, 1, 1, 0.7)
	var opt := _options[index]
	_desc.text = "Uma arena sorteada a cada partida." if opt < 0 else String(Game.ARENAS[opt].get("desc", ""))
