class_name HowToPlayScreen
extends MenuScreen
## Tela "Como jogar" em duas abas:
##  - "Básico": 4 cartões grandes (andar/pular, atacar, especial, escudo/escape),
##    cada um com o Juba fazendo o movimento (UiArt.FighterIdle com a folha), uma
##    linha de texto e as teclas do P1 lidas do mapeamento atual.
##  - "Teclas e regras": tabela de controles (Jogador 1, Jogador 2, Gamepad),
##    regras e dicas de movimento.
## Esquerda/direita (ou clique na aba) troca de aba. Cabe em 1920x1080; o
## ScrollContainer da segunda aba só rola se algo crescer além do espaço.

const CELL_SIZE := 24
const BODY_SIZE := 22
const SCROLL_STEP := 160
const SCROLL_HEIGHT := 700.0
const CONTENT_WIDTH := 1580.0
const TABS := ["Básico", "Teclas e regras"]
const CARD_SIZE := Vector2(380, 560)
const CARD_PX := 4.6
const DEMO_CHAR := "juba"
## Cartões do básico: [título, folhas do Juba em sequência, linha, ações do P1 mostradas].
const CARDS: Array[Array] = [
	["Andar e pular", ["andar", "pulo"], "Pula de novo no ar", ["left", "right", "jump"]],
	["Atacar", ["jab", "golpe_frente", "golpe_cima"], "A direção muda o golpe", ["attack"]],
	["Especial", ["especial_lado", "especial_neutro"], "Cada bicho tem o seu", ["special"]],
	["Escudo e escape", ["defesa_esquiva"], "Defende e escapa rolando", ["shield"]],
]

## Ação e as ações do mapa que ela mostra (as teclas vêm de Opções → Controles).
const CONTROLS: Array[Array] = [
	["Mover", ["up", "left", "down", "right"]],
	["Pular", ["jump"]],
	["Ataque", ["attack"]],
	["Especial", ["special"]],
	["Defesa / esquiva", ["shield"]],
	["Agarrão", ["grab"]],
	["Pausa", ["pause"]],
]
const RULES: Array[String] = [
	"Cada golpe que acerta aumenta o dano (%) do adversário.",
	"Quanto maior o dano, mais longe o golpe lança.",
	"Sair da arena pela borda é um KO.",
	"Vence quem fizer 3 KOs primeiro.",
	"KO dos dois ao mesmo tempo no ponto final: morte súbita.",
]
const TIPS: Array[String] = [
	"Correr: toque duplo na direção. Descer da plataforma: para baixo.",
	"Na borda: para cima sobe, pulo salta. Segurando alguém: Ataque bate, direção arremessa.",
	"Defesa parado = escudo; andando ou no ar = esquiva intocável. Defesa + Ataque agarra.",
	"Levou golpe? Depois de um instante, Defesa escapa do combo (espera 2 s).",
	"Ataque 3 vezes seguidas faz uma sequência. Troque as teclas em Opções → Controles.",
]

var table: GridContainer
var content: VBoxContainer
var scroll: ScrollContainer
## Aba aberta (0 básico, 1 teclas e regras).
var tab := 0
var basics: Control
## Um dicionário por cartão: {root, demo, keys}.
var cards: Array[Dictionary] = []
var _tab_buttons: Array[Button] = []


func _ready() -> void:
	scrim = true
	var col := build_column("Como jogar")
	col.add_child(_build_tabs())
	basics = _build_basics()
	col.add_child(basics)
	scroll = ScrollContainer.new()
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.custom_minimum_size = Vector2(CONTENT_WIDTH + 40.0, SCROLL_HEIGHT)
	col.add_child(scroll)
	content = VBoxContainer.new()
	content.add_theme_constant_override("separation", 24)
	content.custom_minimum_size.x = CONTENT_WIDTH
	scroll.add_child(content)
	content.add_child(_build_table())
	var blocks := HBoxContainer.new()
	blocks.add_theme_constant_override("separation", 40)
	blocks.add_child(_build_block("Regras", RULES))
	blocks.add_child(_build_block("Movimento e dicas", TIPS))
	content.add_child(blocks)
	var back := add_button(col, "Voltar", func() -> void: Game.go_menu(), true)
	back.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	show_tab(0)
	focus_first()


func _build_tabs() -> Control:
	var bar := HBoxContainer.new()
	bar.alignment = BoxContainer.ALIGNMENT_CENTER
	bar.add_theme_constant_override("separation", 16)
	for i in TABS.size():
		var b := Button.new()
		b.text = TABS[i]
		b.focus_mode = Control.FOCUS_NONE
		b.toggle_mode = true
		b.custom_minimum_size = Vector2(330, 58)
		UiArt.style_button(b, 26)
		b.pressed.connect(func() -> void:
			if tab != i:
				Sfx.play("ui_move")
			show_tab(i))
		bar.add_child(b)
		_tab_buttons.append(b)
	var hint := make_label("◀ ▶ troca de aba", "HintLabel")
	UiArt.outlined(hint, 22, UiArt.CREAM, 5)
	hint.custom_minimum_size = Vector2(240, 0)
	bar.add_child(hint)
	return bar


## Mostra a aba i (0 básico, 1 teclas e regras).
func show_tab(i: int) -> void:
	tab = clampi(i, 0, TABS.size() - 1)
	basics.visible = tab == 0
	scroll.visible = tab == 1
	for k in _tab_buttons.size():
		var b := _tab_buttons[k]
		b.set_pressed_no_signal(k == tab)
		b.modulate = Color.WHITE if k == tab else Color(0.75, 0.72, 0.7)
		b.add_theme_stylebox_override("normal", UiArt.plank(k == tab))


func _build_basics() -> Control:
	var row := HBoxContainer.new()
	row.name = "Basico"
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	row.add_theme_constant_override("separation", 26)
	row.custom_minimum_size = Vector2(CONTENT_WIDTH + 40.0, SCROLL_HEIGHT)
	for c in CARDS:
		row.add_child(_card(c))
	return row


func _card(spec: Array) -> Control:
	var card := PanelContainer.new()
	card.custom_minimum_size = CARD_SIZE
	card.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	var st := StyleBoxFlat.new()
	st.bg_color = Color(0.07, 0.05, 0.08, 0.9)
	st.border_color = UiArt.GOLD.darkened(0.25)
	st.set_border_width_all(4)
	st.set_corner_radius_all(18)
	for side in ["left", "right", "top", "bottom"]:
		st.set("content_margin_" + side, 18)
	card.add_theme_stylebox_override("panel", st)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 10)
	card.add_child(v)
	var title := make_label(spec[0])
	UiArt.outlined(title, 34, UiArt.GOLD, 8)
	v.add_child(title)
	# Palco do Juba: fundo um pouco mais claro, ele centralizado em cima do "chão"
	var stage := Panel.new()
	stage.custom_minimum_size = Vector2(0, 64 * CARD_PX + 24)
	stage.clip_contents = true
	var ss := StyleBoxFlat.new()
	ss.bg_color = Color(0.16, 0.12, 0.14, 0.9)
	ss.set_corner_radius_all(12)
	stage.add_theme_stylebox_override("panel", ss)
	v.add_child(stage)
	var demo := Demo.new()
	demo.setup_sheets(DEMO_CHAR, spec[1], CARD_PX)
	stage.add_child(demo)
	demo.position = Vector2((CARD_SIZE.x - 36 - demo.size.x) * 0.5, 12)
	var line := make_label(spec[2])
	line.name = "Linha"
	UiArt.outlined(line, 26, UiArt.CREAM, 6)
	line.custom_minimum_size = Vector2(CARD_SIZE.x - 36, 56)
	line.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	UiArt.fit_size(line, 26, CARD_SIZE.x - 44, 20)   # sempre 1 linha
	v.add_child(line)
	var keys := make_label(_keys_text(spec[3]))
	keys.name = "Teclas"
	UiArt.outlined(keys, 28, Game.PLAYER_COLORS["p1"].lightened(0.35), 6)
	keys.clip_text = true
	keys.custom_minimum_size = Vector2(CARD_SIZE.x - 36, 0)
	UiArt.fit_size(keys, 28, CARD_SIZE.x - 40, 18)
	v.add_child(keys)
	cards.append({"root": card, "demo": demo, "keys": keys, "line": line})
	return card


## Teclas do Jogador 1 (teclado e controle) das ações, do mapeamento atual.
static func _keys_text(actions: Array) -> String:
	var keys: Array[String] = []
	var pads: Array[String] = []
	for a in actions:
		var k := Controles.describe("p1_" + a, "teclado")
		var g := Controles.describe("p1_" + a, "controle")
		if k != "—" and not k in keys:
			keys.append(k)
		if g != "—" and not g in pads:
			pads.append(g)
	var t := " ".join(keys)
	if not pads.is_empty() and actions.size() == 1:
		t += "  ·  " + " ".join(pads)
	return t


## Juba tocando várias folhas em sequência (cada uma uma volta inteira).
class Demo extends UiArt.FighterIdle:
	var sheets: Array[String] = []
	var _index := 0
	var _left := 0.0
	var _px := 4.0

	func setup_sheets(char_id: String, names: Array, px: float) -> void:
		_px = px
		for n in names:
			sheets.append("res://assets/characters/%s/pixel/%s.png" % [char_id, n])
		_play(0)

	func _play(i: int) -> void:
		_index = i % sheets.size()
		setup(sheets[_index], _px, 10.0)
		_t = 0.0
		_left = frames / fps + 0.25   # uma volta e uma pausinha

	func _process(delta: float) -> void:
		_left -= delta
		if _left <= 0.0:
			_play(_index + 1)
			return
		if _atlas.atlas == null:
			return
		_t += delta
		_atlas.region = Rect2(mini(int(_t * fps), frames - 1) * fw, 0, fw, 64)


func _build_table() -> Control:
	var panel := PanelContainer.new()
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.09, 0.106, 0.157, 0.92)
	style.border_color = Color(0.204, 0.235, 0.345)
	style.set_border_width_all(2)
	style.set_corner_radius_all(12)
	style.content_margin_left = 30.0
	style.content_margin_right = 30.0
	style.content_margin_top = 18.0
	style.content_margin_bottom = 18.0
	panel.add_theme_stylebox_override("panel", style)
	table = GridContainer.new()
	table.columns = 4
	table.add_theme_constant_override("h_separation", 32)
	table.add_theme_constant_override("v_separation", 8)
	panel.add_child(table)
	var heads := ["Ação", "Jogador 1 (teclado)", "Jogador 2 (teclado)", "Gamepad"]
	var colors := [ACCENT, Game.PLAYER_COLORS["p1"], Game.PLAYER_COLORS["p2"], GOOD]
	for i in heads.size():
		table.add_child(_cell(heads[i], 26, colors[i]))
	for row in CONTROLS:
		table.add_child(_cell(row[0], CELL_SIZE, MUTED))
		for col in [["p1", "teclado"], ["p2", "teclado"], ["p1", "controle"]]:
			var names: Array[String] = []
			for act in row[1]:
				var n := Controles.describe("%s_%s" % [col[0], act], col[1])
				if n != "—" and n not in names:
					names.append(n)
			var text := " ".join(names) if not names.is_empty() else "—"
			if row[1].size() > 1 and col[1] == "controle":
				text = "Analógico / direcional"
			table.add_child(_cell(text, CELL_SIZE, Color(0.953, 0.937, 0.902)))
	return panel


func _build_block(title: String, lines: Array[String]) -> Control:
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 8)
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.custom_minimum_size.x = (CONTENT_WIDTH - 40.0) * 0.5
	var head := make_label(title, "HeadingLabel", ACCENT)
	head.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	box.add_child(head)
	for line in lines:
		var l := _cell("•  " + line, BODY_SIZE, Color(0.953, 0.937, 0.902))
		l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		l.custom_minimum_size.x = (CONTENT_WIDTH - 40.0) * 0.5
		box.add_child(l)
	return box


func _cell(text: String, font_size: int, color: Color) -> Label:
	var l := Label.new()
	l.text = text
	l.add_theme_font_size_override("font_size", font_size)
	l.add_theme_color_override("font_color", color)
	return l


func _process(delta: float) -> void:
	super._process(delta)
	# Esquerda/direita troca de aba; se o conteúdo passar do espaço, cima/baixo
	# rola (só há o botão Voltar com foco).
	if scroll == null or not is_visible_in_tree():
		return
	for p in ["ui", "p1", "p2"]:
		if Controles.menu_pressed(p + "_left") or Controles.menu_pressed(p + "_right"):
			Sfx.play("ui_move")
			show_tab(1 - tab)
			return
	for p in ["ui", "p1", "p2"]:
		if Controles.menu_pressed(p + "_down"):
			scroll.scroll_vertical += SCROLL_STEP
			return
		if Controles.menu_pressed(p + "_up"):
			scroll.scroll_vertical -= SCROLL_STEP
			return


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Sfx.play("ui_back")
		Game.go_menu()
