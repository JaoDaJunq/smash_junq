extends MenuScreen
## Escolha de personagem no estilo Street Fighter: todos os lutadores numa grade
## de fotinhos, uma linha por grupo de bichos (Roster) e uma coluna por tipo.
## Os que ainda não existem aparecem como "?" escuro e o cursor PULA essas vagas
## (vai ao próximo jogável na direção). Cada jogador tem um cursor (azul /
## vermelho), anda com o direcional, confirma com Ataque ou Pulo e desfaz com
## Especial; o mouse escolhe pelo clique na foto. Dos lados, o lutador escolhido
## aparece grande e animado, com grupo, tipo e barrinhas.
## No modo CPU/treino, o Jogador 1 escolhe o próprio lutador e depois o outro.

const START_DELAY := 0.5
const TILE := 112.0
const GAP := 10.0
const GROUP_W := 190.0
const WAITING := Color("6b7390")
const LOCKED_TILE := Color(0.025, 0.018, 0.03, 0.85)
const LOCKED_BORDER := Color(0.13, 0.09, 0.1)
## Tamanhos de texto pensados para TV (lidos do sofá).
const HINT_SIZE := 28
const DESC_SIZE := 28
const LABEL_SIZE := 28
const STAGE := Vector2(460, 330)
const NAME_SIZE := 46
## Fração da altura da arte de apresentação que aparece (do topo; corta no joelho).
const SPLASH_SHOWN := 0.74

## Índice em Game.CHARACTERS do lutador sob o cursor (-1 = "?", em breve).
var choice := {"p1": 0, "p2": 1}
var cursor := {"p1": Vector2i.ZERO, "p2": Vector2i.ZERO}
var locked := {"p1": false, "p2": false}
var tiles := {}   # Vector2i -> {"root": Panel, "tags": {pid: Label}}
var _panels := {}
var _starting := false


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(UiArt.backdrop(0.5, true, true))
	for pid in PLAYERS:
		_set_cursor(pid, Roster.cell_of(Game.character_index(pid)))
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)
	_content = root

	var title := UiArt.ribbon("ESCOLHA SEU LUTADOR", 46)
	title.position = Vector2(960 - 360, 22)
	title.custom_minimum_size = Vector2(720, 0)
	root.add_child(title)
	var mode_text := "2 jogadores" if Game.mode == "versus" else ("Treino" if Game.mode == "training" else "Contra a CPU")
	var sub := make_label(mode_text)
	UiArt.outlined(sub, 26, UiArt.GOLD, 6)
	sub.position = Vector2(760, 112)
	sub.size = Vector2(400, 36)
	root.add_child(sub)

	_build_grid(root, Vector2(960 - (GROUP_W + 4 * (TILE + GAP)) * 0.5, 160))
	_panels["p1"] = _build_side("p1", Vector2(30, 150))
	_panels["p2"] = _build_side("p2", Vector2(1920 - 30 - 500, 150))
	for pid in PLAYERS:
		root.add_child(_panels[pid]["root"])

	# Dica de rodapé: no máximo 3 comandos (o resto o jogador descobre na tela)
	var hint_text := "Direcional escolhe  ·  Ataque confirma\nEspecial desfaz"
	if Game.is_single_player():
		hint_text += "\nVocê escolhe o seu e depois o " + ("do boneco" if Game.mode == "training" else "da CPU")
	var hint := make_label(hint_text, "HintLabel")
	hint.name = "Dica"
	UiArt.outlined(hint, HINT_SIZE, UiArt.CREAM, 7)
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	hint.position = Vector2(550, 934)
	hint.size = Vector2(820, 130)
	root.add_child(hint)
	var back := Button.new()
	back.text = "Voltar"
	back.focus_mode = Control.FOCUS_NONE
	back.size = Vector2(200, 60)
	back.position = Vector2(40, 34)
	UiArt.style_button(back, 26)
	setup_button_fx(back)
	back.pressed.connect(_back)
	root.add_child(back)
	play_intro.call_deferred()
	_refresh()


# --- Grade ---

func _build_grid(root: Control, origin: Vector2) -> void:
	for c in Roster.cols():
		var h := make_label(Roster.TYPES[c].to_upper())
		UiArt.outlined(h, LABEL_SIZE, UiArt.GOLD, 7)
		h.position = origin + Vector2(GROUP_W + c * (TILE + GAP) - GAP * 0.5, -8)
		h.size = Vector2(TILE + GAP, 36)
		UiArt.fit_size(h, LABEL_SIZE, TILE + GAP - 2, 22)
		root.add_child(h)
	for r in Roster.rows():
		var g: Dictionary = Roster.GROUPS[r]
		var y := origin.y + 34 + r * (TILE + GAP)
		var gl := make_label(String(g["name"]).to_upper())
		UiArt.outlined(gl, LABEL_SIZE, g["color"], 7)
		gl.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		gl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		gl.position = Vector2(origin.x - 10, y)
		gl.size = Vector2(GROUP_W - 14, TILE)
		root.add_child(gl)
		for c in Roster.cols():
			var cell := Vector2i(c, r)
			var t := _tile(cell, g["color"])
			t.position = Vector2(origin.x + GROUP_W + c * (TILE + GAP), y)
			root.add_child(t)


func _tile(cell: Vector2i, group_color: Color) -> Panel:
	var info := Roster.slot(cell)
	var playable := Game.character_ready(int(info["char"]))
	var p := Panel.new()
	p.size = Vector2(TILE, TILE)
	p.clip_contents = true
	p.mouse_filter = Control.MOUSE_FILTER_STOP
	var pic := TextureRect.new()
	pic.set_anchors_preset(Control.PRESET_FULL_RECT)
	pic.offset_left = 5
	pic.offset_top = 5
	pic.offset_right = -5
	pic.offset_bottom = -5
	pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	pic.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	pic.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	pic.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if playable:
		pic.texture = _portrait(int(info["char"]))
	p.add_child(pic)
	if not playable:
		var q := make_label("?")
		UiArt.outlined(q, 46, group_color.darkened(0.72), 6)
		q.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.6))
		q.set_anchors_preset(Control.PRESET_FULL_RECT)
		q.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		q.mouse_filter = Control.MOUSE_FILTER_IGNORE
		p.add_child(q)
	var tags := {}
	for pid in PLAYERS:
		var tag := make_label("1P" if pid == "p1" else "2P")
		UiArt.outlined(tag, 20, Color.WHITE, 6)
		tag.add_theme_color_override("font_color", Game.PLAYER_COLORS[pid])
		tag.size = Vector2(44, 26)
		tag.position = Vector2(2 if pid == "p1" else TILE - 46, TILE - 30)
		tag.mouse_filter = Control.MOUSE_FILTER_IGNORE
		p.add_child(tag)
		tags[pid] = tag
	p.mouse_entered.connect(func() -> void: _mouse_hover(cell))
	p.gui_input.connect(func(e: InputEvent) -> void:
		if e is InputEventMouseButton and e.pressed and e.button_index == MOUSE_BUTTON_LEFT:
			_mouse_click(cell))
	tiles[cell] = {"root": p, "tags": tags, "playable": playable, "color": group_color}
	return p


## Fotinho: retrato em pixel art (importado de art/ui/), senão o rosto do
## primeiro quadro do "parado".
func _portrait(char_index: int) -> Texture2D:
	var id := String(Game.CHARACTERS[char_index].get("id", ""))
	var t := UiArt.tex("res://assets/characters/%s/retrato_pixel.png" % id)
	if t != null:
		return t
	var sheet := UiArt.tex("res://assets/characters/%s/pixel/parado.png" % id)
	if sheet == null:
		return null
	var a := AtlasTexture.new()
	a.atlas = sheet
	a.region = Rect2(14 + (UiArt.frame_width(sheet, "res://assets/characters/%s/pixel/parado.png" % id) - 64.0) * 0.5, 4, 36, 36)
	return a


# --- Painéis dos lados ---

func _build_side(pid: String, at: Vector2) -> Dictionary:
	var panel := PanelContainer.new()
	panel.position = at
	panel.custom_minimum_size = Vector2(500, 900)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 6)
	panel.add_child(v)
	var title := make_label(Game.player_label(pid).to_upper())
	UiArt.outlined(title, 30, Game.PLAYER_COLORS[pid], 8)
	v.add_child(title)
	var stage := Control.new()
	stage.custom_minimum_size = STAGE
	stage.clip_contents = true
	v.add_child(stage)
	var name_label := make_label("")
	UiArt.outlined(name_label, NAME_SIZE, UiArt.CREAM, 10)
	name_label.add_theme_font_override("font", load("res://assets/fonts/kenney_future.ttf"))
	name_label.clip_text = true
	v.add_child(name_label)
	var kind := make_label("")
	UiArt.outlined(kind, 28, UiArt.GOLD, 7)
	v.add_child(kind)
	# Descrição em parágrafo único com altura fixa de 3 linhas: o resto do
	# painel não pula quando troca de lutador.
	var desc := make_label("", "HintLabel")
	desc.add_theme_font_size_override("font_size", DESC_SIZE)
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	desc.custom_minimum_size = Vector2(460, 4 * 33)
	v.add_child(desc)
	var bars := VBoxContainer.new()
	bars.add_theme_constant_override("separation", 4)
	bars.custom_minimum_size = Vector2(0, 4 * 30 + 3 * 4)
	v.add_child(bars)
	var push := Control.new()
	push.size_flags_vertical = Control.SIZE_EXPAND_FILL
	push.mouse_filter = Control.MOUSE_FILTER_IGNORE
	v.add_child(push)
	var status := make_label("")
	UiArt.outlined(status, 32, UiArt.GOLD, 8)
	v.add_child(status)
	var confirm := Button.new()
	confirm.focus_mode = Control.FOCUS_NONE
	confirm.custom_minimum_size = Vector2(260, 58)
	confirm.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	UiArt.style_button(confirm, 26)
	setup_button_fx(confirm)
	confirm.pressed.connect(func() -> void: _toggle_lock(pid))
	v.add_child(confirm)
	return {"root": panel, "stage": stage, "name": name_label, "kind": kind, "desc": desc,
		"bars": bars, "status": status, "confirm": confirm, "shown": -2}


func _show_fighter(pid: String) -> void:
	var p: Dictionary = _panels[pid]
	var idx: int = choice[pid]
	if p["shown"] == idx:
		return
	p["shown"] = idx
	var stage: Control = p["stage"]
	for c in stage.get_children():
		c.queue_free()
	if idx >= 0:
		_show_splash(pid, stage, idx)
	else:
		var q := make_label("?")
		UiArt.outlined(q, 220, Color(0.18, 0.12, 0.12), 14)
		q.set_anchors_preset(Control.PRESET_FULL_RECT)
		q.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		stage.add_child(q)
	pop(stage, 1.04)


## Apresentação: a arte pintada do lutador entra deslizando de fora (corte do
## joelho para cima, apagando embaixo) e o sprite do jogo ginga no canto.
## Sem arte pintada, só o sprite grande como antes.
func _show_splash(pid: String, stage: Control, idx: int) -> void:
	var id := String(Game.CHARACTERS[idx].get("id", ""))
	var outer := -1.0 if pid == "p1" else 1.0   # lado de fora da tela
	var group: Dictionary = Roster.GROUPS[(cursor[pid] as Vector2i).y]
	var glow := Panel.new()
	var gs := StyleBoxFlat.new()
	gs.bg_color = Color(group["color"], 0.22)
	gs.set_corner_radius_all(14)
	glow.add_theme_stylebox_override("panel", gs)
	glow.position = Vector2(0, 30)
	glow.size = Vector2(STAGE.x, STAGE.y - 30)
	glow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	stage.add_child(glow)
	var art := UiArt.splash(id)
	if art == null:
		var f := UiArt.FighterIdle.new().setup("res://assets/characters/%s/pixel/parado.png" % id, 5.6, 6.0)
		f.flip_h = pid == "p2"   # os dois se olham
		f.position = Vector2((STAGE.x - 64 * 5.6) * 0.5 - f.margin_px, STAGE.y - 64 * 5.6 + 10)
		stage.add_child(f)
		return
	var h := STAGE.y / SPLASH_SHOWN
	var w := h * art.get_width() / art.get_height()
	var r := TextureRect.new()
	r.name = "Apresentacao"
	r.texture = art
	r.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	r.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	r.stretch_mode = TextureRect.STRETCH_SCALE
	r.mouse_filter = Control.MOUSE_FILTER_IGNORE
	r.size = Vector2(w, h)
	# um pouco puxado para o centro da tela, deixando o canto de fora pro sprite
	var end := Vector2((STAGE.x - w) * 0.5 - outer * 46.0, 4)
	r.position = end + Vector2(outer * 90.0, 0)
	r.modulate.a = 0.0
	stage.add_child(r)
	var tw := r.create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(r, "position", end, 0.22).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(r, "modulate:a", 1.0, 0.14)
	# corte de baixo esmaecendo na cor do painel
	var fade := TextureRect.new()
	var g := Gradient.new()
	g.set_color(0, Color(UiArt.PANEL_BG, 0.0))
	g.set_color(1, UiArt.PANEL_BG)
	var gt := GradientTexture2D.new()
	gt.gradient = g
	gt.fill_from = Vector2(0.5, 0.0)
	gt.fill_to = Vector2(0.5, 1.0)
	fade.texture = gt
	fade.stretch_mode = TextureRect.STRETCH_SCALE
	fade.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	fade.position = Vector2(0, STAGE.y - 70)
	fade.size = Vector2(STAGE.x, 70)
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	stage.add_child(fade)
	# o lutador como ele aparece na luta, pequeno no canto de fora
	var px := 2.6
	var f := UiArt.FighterIdle.new().setup("res://assets/characters/%s/pixel/parado.png" % id, px, 6.0)
	f.flip_h = pid == "p2"
	f.position = Vector2(0.0 if pid == "p1" else STAGE.x - 64 * px, STAGE.y - 64 * px + 6) - Vector2(f.margin_px, 0)
	stage.add_child(f)


func _fill_bars(bars: VBoxContainer, stats: Dictionary) -> void:
	for c in bars.get_children():
		c.queue_free()
	for key in stats:
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 10)
		var l := Label.new()
		l.text = key
		row.custom_minimum_size = Vector2(0, 30)
		l.custom_minimum_size = Vector2(236, 0)
		l.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		UiArt.outlined(l, 26, UiArt.CREAM, 6)
		row.add_child(l)
		for i in 5:
			var pip := Panel.new()
			pip.custom_minimum_size = Vector2(32, 20)
			pip.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			var s := StyleBoxFlat.new()
			s.bg_color = UiArt.GOLD if i < int(stats[key]) else Color(0.2, 0.15, 0.13)
			s.border_color = UiArt.INK
			s.set_border_width_all(2)
			s.set_corner_radius_all(4)
			pip.add_theme_stylebox_override("panel", s)
			row.add_child(pip)
		bars.add_child(row)


# --- Entrada ---

## Quem manda no jogador-alvo deste painel. No modo CPU, o P1 controla os dois.
func controller_of(slot: String) -> String:
	return "p1" if Game.is_single_player() else slot


## No modo CPU, a CPU (p2) só escolhe depois que o P1 confirmou.
func slot_active(slot: String) -> bool:
	if _starting:
		return false
	return slot == "p1" or Game.mode == "versus" or locked["p1"]


## Quem o mouse controla agora (o P1, ou a vez da CPU/boneco no modo de 1 jogador).
func _mouse_slot() -> String:
	if Game.is_single_player() and locked["p1"]:
		return "p2"
	return "p1"


func _process(_delta: float) -> void:
	for pid in PLAYERS:
		if Controles.menu_pressed(pid + "_pause"):
			_back()
			return
	var slots: Array = PLAYERS
	if Game.is_single_player():
		slots = ["p2" if locked["p1"] else "p1"]
	for slot in slots:
		if not slot_active(slot):
			continue
		var c := controller_of(slot)
		var step := Vector2i.ZERO
		if Controles.menu_pressed(c + "_left"):
			step.x -= 1
		if Controles.menu_pressed(c + "_right"):
			step.x += 1
		if Controles.menu_pressed(c + "_up"):
			step.y -= 1
		if Controles.menu_pressed(c + "_down"):
			step.y += 1
		if step != Vector2i.ZERO:
			_move(slot, step)
		if Controles.menu_pressed(c + "_attack") or Controles.menu_pressed(c + "_jump"):
			if not locked[slot]:
				_toggle_lock(slot)
		elif Controles.menu_pressed(c + "_special"):
			_unlock(slot)


func _set_cursor(slot: String, cell: Vector2i) -> void:
	cursor[slot] = cell
	var idx := int(Roster.slot(cell)["char"])
	choice[slot] = idx if Game.character_ready(idx) else -1


func _move(slot: String, step: Vector2i) -> void:
	if locked[slot] or not slot_active(slot):
		return
	var c: Vector2i = cursor[slot]
	var to := next_cell(c, step)
	if to == c:
		return
	_set_cursor(slot, to)
	Sfx.play("ui_move")
	_refresh()
	pop(tiles[cursor[slot]]["root"], 1.12)


## A vaga tem lutador jogável?
static func cell_playable(cell: Vector2i) -> bool:
	return Game.character_ready(int(Roster.slot(cell)["char"]))


## Próxima vaga JOGÁVEL a partir de "from" na direção "step" (as vagas "?" são
## puladas). Na horizontal, segue na mesma linha (dando a volta); na vertical,
## vai à próxima linha que tenha jogável, na coluna mais perto da atual. Sem
## nenhuma, fica onde está.
static func next_cell(from: Vector2i, step: Vector2i) -> Vector2i:
	var cell := from
	if step.x != 0:
		for k in range(1, Roster.cols()):
			var c := Vector2i(posmod(from.x + signi(step.x) * k, Roster.cols()), from.y)
			if cell_playable(c):
				cell = c
				break
	if step.y != 0:
		for k in range(1, Roster.rows()):
			var r := posmod(cell.y + signi(step.y) * k, Roster.rows())
			var best := -1
			for c in Roster.cols():
				if cell_playable(Vector2i(c, r)) and (best < 0 or absi(c - cell.x) < absi(best - cell.x)):
					best = c
			if best >= 0:
				return Vector2i(best, r)
	return cell


func _mouse_hover(cell: Vector2i) -> void:
	var slot := _mouse_slot()
	if locked[slot] or not slot_active(slot) or cursor[slot] == cell or not cell_playable(cell):
		return
	_set_cursor(slot, cell)
	Sfx.play("ui_move")
	_refresh()
	pop(tiles[cell]["root"], 1.12)


func _mouse_click(cell: Vector2i) -> void:
	var slot := _mouse_slot()
	if not slot_active(slot):
		return
	if locked[slot]:
		_unlock(slot)
	_set_cursor(slot, cell)
	_toggle_lock(slot)


func _toggle_lock(slot: String) -> void:
	if not slot_active(slot):
		return
	if locked[slot]:
		_unlock(slot)
		return
	if choice[slot] < 0:
		# "?" ainda não existe: treme a foto e não confirma
		Sfx.play("ui_back")
		var t: Control = tiles[cursor[slot]]["root"]
		var x := t.position.x
		var tw := t.create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		for k in 3:
			tw.tween_property(t, "position:x", x + 8, 0.03)
			tw.tween_property(t, "position:x", x - 8, 0.03)
		tw.tween_property(t, "position:x", x, 0.03)
		return
	locked[slot] = true
	Sfx.play("ui_confirm")
	_refresh()
	pop(_panels[slot]["status"], 1.35, 0.25)
	pop(_panels[slot]["stage"], 1.15, 0.22)
	_flash(_panels[slot]["stage"])
	pop(tiles[cursor[slot]]["root"], 1.2, 0.25)
	if locked["p1"] and locked["p2"]:
		_start_match()


## Desfaz a confirmação. No modo CPU, desfazer na vez da CPU volta ao P1.
func _unlock(slot: String) -> void:
	var changed: bool = locked[slot]
	if Game.is_single_player() and slot == "p2" and not locked["p2"]:
		locked["p1"] = false
		changed = true
	locked[slot] = false
	if changed:
		Sfx.play("ui_back")
	_refresh()


func _start_match() -> void:
	_starting = true
	for pid in PLAYERS:
		Game.set_character(pid, choice[pid])
	_refresh()
	# faixa "PRONTOS!" estoura no meio antes de ir para a arena
	var go := UiArt.ribbon("PRONTOS!", 72)
	go.custom_minimum_size = Vector2(620, 0)
	go.position = Vector2(960 - 310, 470)
	_content.add_child(go)
	pop.call_deferred(go, 1.6, 0.3)
	await get_tree().create_timer(START_DELAY).timeout
	Game.go_to(Game.ARENA_SELECT_SCENE)


func _back() -> void:
	if _starting:
		return
	Sfx.play("ui_back")
	Game.go_to(Game.MODE_SCENE)


# --- Visual ---

## Clarão rápido (confirmação).
func _flash(c: CanvasItem) -> void:
	c.modulate = Color(2.2, 2.2, 2.2)
	c.create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).tween_property(c, "modulate", Color.WHITE, 0.3)


func _refresh() -> void:
	for cell in tiles:
		var t: Dictionary = tiles[cell]
		var here := []
		for pid in PLAYERS:
			var on: bool = cursor[pid] == cell and (slot_active(pid) or locked[pid])
			(t["tags"][pid] as Label).visible = on
			if on:
				here.append(pid)
		var border := UiArt.INK
		var width := 3
		if here.size() == 2:
			border = UiArt.GOLD
			width = 6
		elif here.size() == 1:
			border = Game.PLAYER_COLORS[here[0]]
			width = 6
			if locked[here[0]]:
				border = border.lightened(0.35)
		if not t["playable"] and here.is_empty():
			border = LOCKED_BORDER
			width = 2
		var s := StyleBoxFlat.new()
		s.bg_color = (t["color"] as Color).darkened(0.55) if t["playable"] else LOCKED_TILE
		s.border_color = border
		s.set_border_width_all(width)
		s.set_corner_radius_all(10)
		(t["root"] as Panel).add_theme_stylebox_override("panel", s)
		# vagas "?" discretas: escuras e meio apagadas (o cursor não para nelas)
		(t["root"] as Panel).modulate = Color.WHITE if t["playable"] or not here.is_empty() else Color(1, 1, 1, 0.55)
	for pid in PLAYERS:
		var p: Dictionary = _panels[pid]
		var cell: Vector2i = cursor[pid]
		var slot := Roster.slot(cell)
		var group: Dictionary = Roster.GROUPS[cell.y]
		_show_fighter(pid)
		p["name"].text = slot["name"]
		UiArt.fit_size(p["name"], NAME_SIZE, STAGE.x - 8)
		p["kind"].text = "%s  ·  %s" % [group["name"], Roster.TYPES[cell.x]]
		(p["kind"] as Label).add_theme_color_override("font_color", group["color"])
		var idx: int = choice[pid]
		if idx >= 0:
			var info: Dictionary = Game.CHARACTERS[idx]
			p["desc"].text = UiArt.flat(info["desc"])
			if p.get("bars_for", -2) != idx:
				_fill_bars(p["bars"], info.get("stats", {}))
				p["bars_for"] = idx
		else:
			var animal := String(slot["animal"])
			p["desc"].text = "%s%s ainda está treinando. Em breve no torneio!" % [animal.left(1).to_upper(), animal.substr(1)]
			if p.get("bars_for", -2) != -1:
				_fill_bars(p["bars"], {})
				p["bars_for"] = -1
		var active := slot_active(pid)
		var status: Label = p["status"]
		if locked[pid]:
			status.text = "PRONTO!"
			status.add_theme_color_override("font_color", GOOD)
		elif active:
			status.text = "Escolhendo..." if idx >= 0 else "Em breve"
			status.add_theme_color_override("font_color", UiArt.GOLD)
		else:
			status.text = "Aguardando o Jogador 1"
			status.add_theme_color_override("font_color", WAITING)
		var confirm: Button = p["confirm"]
		confirm.text = "Desfazer" if locked[pid] else "Confirmar"
		confirm.disabled = not active or (idx < 0 and not locked[pid])
		var border: Color = WAITING if not active else Game.PLAYER_COLORS[pid]
		if locked[pid]:
			border = GOOD
		(p["root"] as PanelContainer).add_theme_stylebox_override("panel", UiArt.panel(border, 5 if active or locked[pid] else 3))
		(p["stage"] as Control).modulate = Color.WHITE if active or locked[pid] else Color(1, 1, 1, 0.4)
