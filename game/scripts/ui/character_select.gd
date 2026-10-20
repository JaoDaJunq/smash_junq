extends MenuScreen
## Escolha de personagem no estilo Street Fighter: todos os lutadores numa grade
## de fotinhos, uma linha por grupo de bichos (Roster) e uma coluna por tipo.
## Os que ainda não existem aparecem como "?". Cada jogador tem um cursor (azul /
## vermelho), anda com o direcional, confirma com Ataque ou Pulo e desfaz com
## Especial; o mouse escolhe pelo clique na foto. Dos lados, o lutador escolhido
## aparece grande e animado, com grupo, tipo e barrinhas.
## No modo CPU/treino, o Jogador 1 escolhe o próprio lutador e depois o outro.

const START_DELAY := 0.5
const TILE := 112.0
const GAP := 10.0
const GROUP_W := 190.0
const WAITING := Color("6b7390")
const LOCKED_TILE := Color(0.05, 0.04, 0.07)

## Índice em Game.CHARACTERS do lutador sob o cursor (-1 = "?", em breve).
var choice := {"p1": 0, "p2": 1}
var cursor := {"p1": Vector2i.ZERO, "p2": Vector2i.ZERO}
var locked := {"p1": false, "p2": false}
var tiles := {}   # Vector2i -> {"root": Panel, "tags": {pid: Label}}
var _panels := {}
var _starting := false


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(UiArt.backdrop(0.5))
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

	var hint_text := "Direcional anda  ·  Ataque ou Pulo confirma  ·  Especial desfaz  ·  Pausa volta  ·  ou clique na foto"
	if Game.is_single_player():
		hint_text += "\nVocê escolhe o seu lutador e depois o " + ("do boneco" if Game.mode == "training" else "da CPU")
	var hint := make_label(hint_text, "HintLabel")
	UiArt.outlined(hint, 22, UiArt.CREAM, 6)
	hint.position = Vector2(360, 1080 - 92)
	hint.size = Vector2(1200, 70)
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
	play_intro.call_deferred()
	_refresh()


# --- Grade ---

func _build_grid(root: Control, origin: Vector2) -> void:
	for c in Roster.cols():
		var h := make_label(Roster.TYPES[c].to_upper())
		UiArt.outlined(h, 20, UiArt.GOLD, 6)
		h.position = origin + Vector2(GROUP_W + c * (TILE + GAP), 0)
		h.size = Vector2(TILE, 28)
		root.add_child(h)
	for r in Roster.rows():
		var g: Dictionary = Roster.GROUPS[r]
		var y := origin.y + 34 + r * (TILE + GAP)
		var gl := make_label(String(g["name"]).to_upper())
		UiArt.outlined(gl, 24, g["color"], 7)
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
		UiArt.outlined(q, 64, group_color.darkened(0.35), 8)
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
	a.region = Rect2(14, 4, 36, 36)
	return a


# --- Painéis dos lados ---

func _build_side(pid: String, at: Vector2) -> Dictionary:
	var panel := PanelContainer.new()
	panel.position = at
	panel.custom_minimum_size = Vector2(500, 820)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 6)
	panel.add_child(v)
	var title := make_label(Game.player_label(pid).to_upper())
	UiArt.outlined(title, 30, Game.PLAYER_COLORS[pid], 8)
	v.add_child(title)
	var stage := Control.new()
	stage.custom_minimum_size = Vector2(460, 340)
	stage.clip_contents = true
	v.add_child(stage)
	var name_label := make_label("")
	UiArt.outlined(name_label, 46, UiArt.CREAM, 10)
	name_label.add_theme_font_override("font", load("res://assets/fonts/kenney_future.ttf"))
	v.add_child(name_label)
	var kind := make_label("")
	UiArt.outlined(kind, 24, UiArt.GOLD, 6)
	v.add_child(kind)
	var desc := make_label("", "HintLabel")
	desc.add_theme_font_size_override("font_size", 22)
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.custom_minimum_size = Vector2(460, 64)
	v.add_child(desc)
	var bars := VBoxContainer.new()
	bars.add_theme_constant_override("separation", 4)
	v.add_child(bars)
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
		var id := String(Game.CHARACTERS[idx].get("id", ""))
		var f := UiArt.FighterIdle.new().setup("res://assets/characters/%s/pixel/parado.png" % id, 5.6, 6.0)
		f.flip_h = pid == "p2"   # os dois se olham
		f.position = Vector2((460 - 64 * 5.6) * 0.5, 340 - 64 * 5.6 + 10)
		stage.add_child(f)
	else:
		var q := make_label("?")
		UiArt.outlined(q, 220, Color(0.18, 0.12, 0.12), 14)
		q.set_anchors_preset(Control.PRESET_FULL_RECT)
		q.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		stage.add_child(q)
	pop(stage, 1.08)


func _fill_bars(bars: VBoxContainer, stats: Dictionary) -> void:
	for c in bars.get_children():
		c.queue_free()
	for key in stats:
		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 10)
		var l := Label.new()
		l.text = key
		l.custom_minimum_size = Vector2(190, 0)
		l.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		UiArt.outlined(l, 20, UiArt.CREAM, 5)
		row.add_child(l)
		for i in 5:
			var pip := Panel.new()
			pip.custom_minimum_size = Vector2(38, 18)
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
	_set_cursor(slot, Vector2i(posmod(c.x + step.x, Roster.cols()), posmod(c.y + step.y, Roster.rows())))
	Sfx.play("ui_move")
	_refresh()
	pop(tiles[cursor[slot]]["root"], 1.12)


func _mouse_hover(cell: Vector2i) -> void:
	var slot := _mouse_slot()
	if locked[slot] or not slot_active(slot) or cursor[slot] == cell:
		return
	_set_cursor(slot, cell)
	Sfx.play("ui_move")
	_refresh()


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
	await get_tree().create_timer(START_DELAY).timeout
	Game.go_to(Game.ARENA_SELECT_SCENE)


func _back() -> void:
	if _starting:
		return
	Sfx.play("ui_back")
	Game.go_to(Game.MODE_SCENE)


# --- Visual ---

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
		var s := StyleBoxFlat.new()
		s.bg_color = (t["color"] as Color).darkened(0.55) if t["playable"] else LOCKED_TILE
		s.border_color = border
		s.set_border_width_all(width)
		s.set_corner_radius_all(10)
		(t["root"] as Panel).add_theme_stylebox_override("panel", s)
		(t["root"] as Panel).modulate = Color.WHITE if t["playable"] or not here.is_empty() else Color(1, 1, 1, 0.75)
	for pid in PLAYERS:
		var p: Dictionary = _panels[pid]
		var cell: Vector2i = cursor[pid]
		var slot := Roster.slot(cell)
		var group: Dictionary = Roster.GROUPS[cell.y]
		_show_fighter(pid)
		p["name"].text = slot["name"]
		p["kind"].text = "%s  ·  %s" % [group["name"], Roster.TYPES[cell.x]]
		(p["kind"] as Label).add_theme_color_override("font_color", group["color"])
		var idx: int = choice[pid]
		if idx >= 0:
			var info: Dictionary = Game.CHARACTERS[idx]
			p["desc"].text = info["desc"]
			if p.get("bars_for", -2) != idx:
				_fill_bars(p["bars"], info.get("stats", {}))
				p["bars_for"] = idx
		else:
			p["desc"].text = "Em breve: %s (%s)." % [slot["name"], slot["animal"]]
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
