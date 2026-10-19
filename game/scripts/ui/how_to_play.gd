class_name HowToPlayScreen
extends MenuScreen
## Tela "Como jogar": tabela de controles (Jogador 1, Jogador 2, Gamepad), regras
## e dicas de movimento. Cabe em 1920x1080 nos tamanhos de fonte do tema; o
## ScrollContainer só entra em ação se algo crescer além do espaço disponível.

const CELL_SIZE := 24
const BODY_SIZE := 22
const SCROLL_STEP := 160
const SCROLL_HEIGHT := 700.0
const CONTENT_WIDTH := 1580.0

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


func _ready() -> void:
	var col := build_column("Como jogar")
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
	focus_first()


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
	# Se o conteúdo passar do espaço, cima/baixo rola (só há o botão Voltar com foco).
	if scroll == null or not is_visible_in_tree():
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
