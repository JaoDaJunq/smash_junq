class_name PauseMenu
extends MenuScreen
## Menu de pausa da luta. Fica sempre ativo (process_mode ALWAYS) e usa
## get_tree().paused para congelar o resto. Pausa com p1_pause ou p2_pause.
## Ao lado dos botões, a tabela de controles LIDA DO MAPEAMENTO ATUAL
## (Controles.describe): se o jogador trocou uma tecla, a pausa mostra a nova.

## Linhas da tabela: [rótulo, ações (sem o prefixo p1_/p2_)].
const ROWS: Array[Array] = [
	["Andar", ["left", "right"]], ["Cima / baixo", ["up", "down"]], ["Pular", ["jump"]],
	["Ataque", ["attack"]], ["Especial", ["special"]], ["Escudo / escape", ["shield"]],
	["Agarrão", ["grab"]], ["Pausa", ["pause"]],
]
const NAME_W := 230.0
const CELL_W := 300.0
const CELL_FONT := 24

## Quem controla a partida (MatchManager) — define quando pode pausar e reinicia.
var match_manager: Node
## [linha, pid] -> Label com o texto da tecla (testes leem).
var control_cells := {}
var _p2_column: Array[Control] = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var col := build_column("", "", true)
	col.add_theme_constant_override("separation", 18)
	col.add_child(UiArt.ribbon("PAUSA", 56))
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 8)
	col.add_child(gap)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 40)
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	col.add_child(row)
	var left := VBoxContainer.new()
	left.add_theme_constant_override("separation", 18)
	left.alignment = BoxContainer.ALIGNMENT_CENTER
	row.add_child(left)
	add_button(left, "Continuar", close, true)
	add_button(left, "Reiniciar", _restart)
	add_button(left, "Sair para o menu", _quit_to_menu, true)
	for b in buttons:
		b.custom_minimum_size = Vector2(440, 76)
		b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		UiArt.style_button(b)
	row.add_child(_build_controls())
	visible = false


## Quadro com a tabela de controles (Ação | Jogador 1 | Jogador 2).
func _build_controls() -> Control:
	var panel := PanelContainer.new()
	panel.name = "Controles"
	var s := StyleBoxFlat.new()
	s.bg_color = Color(0.07, 0.05, 0.08, 0.88)
	s.border_color = UiArt.GOLD.darkened(0.3)
	s.set_border_width_all(3)
	s.set_corner_radius_all(14)
	for side in ["left", "right"]:
		s.set("content_margin_" + side, 22)
	for side in ["top", "bottom"]:
		s.set("content_margin_" + side, 14)
	panel.add_theme_stylebox_override("panel", s)
	var grid := GridContainer.new()
	grid.columns = 3
	grid.add_theme_constant_override("h_separation", 16)
	grid.add_theme_constant_override("v_separation", 4)
	panel.add_child(grid)
	grid.add_child(_cell("Controles", UiArt.GOLD, NAME_W, 26))
	for pid in PLAYERS:
		var h := _cell("Jogador " + pid.trim_prefix("p"), (Game.PLAYER_COLORS[pid] as Color).lightened(0.25), CELL_W, 26)
		h.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		grid.add_child(h)
		if pid == "p2":
			_p2_column.append(h)
	for r in ROWS.size():
		grid.add_child(_cell(ROWS[r][0], UiArt.CREAM, NAME_W, CELL_FONT))
		for pid in PLAYERS:
			var c := _cell("", Color.WHITE, CELL_W, CELL_FONT)
			c.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			grid.add_child(c)
			control_cells[[r, pid]] = c
			if pid == "p2":
				_p2_column.append(c)
	return panel


func _cell(text: String, color: Color, width: float, font: int) -> Label:
	var l := make_label(text)
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	UiArt.outlined(l, font, color, 6)
	l.custom_minimum_size = Vector2(width, 38)
	l.clip_text = true
	return l


## Texto de uma linha da tabela para um jogador, do mapeamento atual
## (teclado e, se houver, controle).
static func binding_text(pid: String, actions: Array) -> String:
	var keys: Array[String] = []
	var pads: Array[String] = []
	for a in actions:
		var k := Controles.describe("%s_%s" % [pid, a], "teclado")
		var g := Controles.describe("%s_%s" % [pid, a], "controle")
		if k != "—":
			keys.append(k)
		if g != "—" and not g in pads:
			pads.append(g)
	var t := " ".join(keys) if not keys.is_empty() else "—"
	if not pads.is_empty() and actions.size() == 1:
		t += "  ·  " + " ".join(pads)
	return t


## Relê o mapeamento (pode ter mudado nas Opções desde a última pausa).
func refresh_controls() -> void:
	var solo := Game.is_single_player()
	for c in _p2_column:
		c.visible = not solo
	for key in control_cells:
		var r: int = key[0]
		var pid: String = key[1]
		var l: Label = control_cells[key]
		l.text = binding_text(pid, ROWS[r][1])
		UiArt.fit_size(l, CELL_FONT, CELL_W - 6, 16)


func _process(delta: float) -> void:
	for p in PLAYERS:
		if Controles.menu_pressed(p + "_pause"):
			toggle()
			return
	super._process(delta)


func toggle() -> void:
	if visible:
		Sfx.play("ui_back")
		close()
	else:
		open()


func open() -> void:
	if match_manager != null and not match_manager.can_pause():
		return
	Sfx.play("ui_confirm", -3.0)
	refresh_controls()
	visible = true
	get_tree().paused = true
	focus_first()


func close() -> void:
	visible = false
	get_tree().paused = false


func _restart() -> void:
	close()
	if match_manager != null:
		match_manager.restart()


func _quit_to_menu() -> void:
	visible = false
	Game.go_menu()
