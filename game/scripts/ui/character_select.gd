extends MenuScreen
## Escolha de personagem. Cada jogador escolhe com esquerda/direita e confirma
## com Ataque ou Pulo (Especial desfaz). Voltar: Pausa ou botão. Mouse também funciona.
## No modo CPU, o Jogador 1 escolhe o próprio lutador e depois o da CPU.

const START_DELAY := 0.5
const WAITING := Color("6b7390")

var choice := {"p1": 0, "p2": 1}
var locked := {"p1": false, "p2": false}
var _panels := {}
var _starting := false
var _arena_label: Label


func _ready() -> void:
	var versus := Game.mode == "versus"
	choice["p1"] = Game.character_index("p1")
	choice["p2"] = Game.character_index("p2")
	var subtitle := "2 jogadores" if versus else ("Treino" if Game.mode == "training" else "Contra a CPU")
	var col := build_column("Escolha seu lutador", subtitle)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 40)
	row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	col.add_child(row)
	for pid in PLAYERS:
		_panels[pid] = _build_panel(pid)
		row.add_child(_panels[pid]["root"])
	var arena_row := HBoxContainer.new()
	arena_row.add_theme_constant_override("separation", 16)
	arena_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	col.add_child(arena_row)
	arena_row.add_child(_mouse_button("◀", func() -> void: _move_arena(-1), 70))
	_arena_label = make_label("", "HeadingLabel", ACCENT)
	_arena_label.custom_minimum_size = Vector2(520, 0)
	arena_row.add_child(_arena_label)
	arena_row.add_child(_mouse_button("▶", func() -> void: _move_arena(1), 70))
	col.add_child(make_label("Esquerda/Direita escolhe  ·  Cima/Baixo troca a arena  ·  Ataque ou Pulo confirma  ·  Especial desfaz  ·  Pausa volta", "HintLabel"))
	if not versus:
		var other := "do boneco" if Game.mode == "training" else "da CPU"
		col.add_child(make_label("Você escolhe o seu lutador e depois o " + other, "HintLabel"))
	var back := Button.new()
	back.text = "Voltar"
	back.focus_mode = Control.FOCUS_NONE
	back.custom_minimum_size = Vector2(260, 56)
	back.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	setup_button_fx(back)
	back.pressed.connect(_back)
	col.add_child(back)
	_refresh()


func _build_panel(pid: String) -> Dictionary:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(540, 0)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 10)
	panel.add_child(v)
	var title := make_label("", "HeadingLabel", Game.PLAYER_COLORS[pid])
	v.add_child(title)
	# Prévia: retrato do personagem (arte em assets/characters/<id>/retrato.png)
	var preview_box := CenterContainer.new()
	var preview := TextureRect.new()
	preview.custom_minimum_size = Vector2(240, 260)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview_box.add_child(preview)
	v.add_child(preview_box)
	var name_label := make_label("", "HeadingLabel")
	name_label.add_theme_font_size_override("font_size", 44)
	v.add_child(name_label)
	var desc := make_label("", "HintLabel")
	desc.add_theme_font_size_override("font_size", 24)
	desc.custom_minimum_size = Vector2(0, 68)
	v.add_child(desc)
	var weight := make_label("", "AccentLabel")
	v.add_child(weight)
	var status := make_label("")
	v.add_child(status)
	# Controles de mouse
	var h := HBoxContainer.new()
	h.alignment = BoxContainer.ALIGNMENT_CENTER
	h.add_theme_constant_override("separation", 12)
	v.add_child(h)
	var prev := _mouse_button("«", func() -> void: _move(pid, -1), 70)
	var confirm := _mouse_button("Confirmar", func() -> void: _toggle_lock(pid), 200)
	var next := _mouse_button("»", func() -> void: _move(pid, 1), 70)
	h.add_child(prev)
	h.add_child(confirm)
	h.add_child(next)
	return {"root": panel, "title": title, "name": name_label, "desc": desc, "weight": weight,
		"status": status, "preview": preview, "preview_box": preview_box, "confirm": confirm}


func _mouse_button(text: String, on_press: Callable, width: float) -> Button:
	var b := Button.new()
	b.theme_type_variation = "SmallButton"
	b.text = text
	b.focus_mode = Control.FOCUS_NONE
	b.custom_minimum_size = Vector2(width, 52)
	setup_button_fx(b)
	b.pressed.connect(on_press)
	return b


## Quem manda no jogador-alvo deste painel. No modo CPU, o P1 controla os dois.
func controller_of(slot: String) -> String:
	return "p1" if Game.is_single_player() else slot


## No modo CPU, a CPU (p2) só escolhe depois que o P1 confirmou.
func slot_active(slot: String) -> bool:
	if _starting:
		return false
	return slot == "p1" or Game.mode == "versus" or locked["p1"]


func _process(_delta: float) -> void:
	for pid in PLAYERS:
		if Input.is_action_just_pressed(pid + "_pause"):
			_back()
			return
	# No modo CPU só um painel escolhe por vez (o do P1 trava quando a CPU escolhe)
	var slots: Array = PLAYERS
	if Game.is_single_player():
		slots = ["p2" if locked["p1"] else "p1"]
	for slot in slots:
		if not slot_active(slot):
			continue
		var c := controller_of(slot)
		if Input.is_action_just_pressed(c + "_left"):
			_move(slot, -1)
		if Input.is_action_just_pressed(c + "_right"):
			_move(slot, 1)
		if Input.is_action_just_pressed(c + "_up"):
			_move_arena(-1)
		elif Input.is_action_just_pressed(c + "_down"):
			_move_arena(1)
		if Input.is_action_just_pressed(c + "_attack") or Input.is_action_just_pressed(c + "_jump"):
			if not locked[slot]:
				_toggle_lock(slot)
		elif Input.is_action_just_pressed(c + "_special"):
			_unlock(slot)


func _move(slot: String, step: int) -> void:
	if locked[slot] or not slot_active(slot):
		return
	choice[slot] = posmod(choice[slot] + step, Game.CHARACTERS.size())
	Sfx.play("ui_move")
	_refresh()
	var p: Dictionary = _panels[slot]
	pop(p["name"], 1.18)
	pop(p["preview_box"], 1.1)


## Arena: Aleatória (-1) e as da lista, em volta.
func _move_arena(step: int) -> void:
	if _starting:
		return
	Game.arena_index = posmod(Game.arena_index + 1 + step, Game.ARENAS.size() + 1) - 1
	Sfx.play("ui_move")
	_refresh()
	pop(_arena_label, 1.12)


func _toggle_lock(slot: String) -> void:
	if not slot_active(slot):
		return
	if locked[slot]:
		_unlock(slot)
		return
	locked[slot] = true
	Sfx.play("ui_confirm")
	_refresh()
	var p: Dictionary = _panels[slot]
	pop(p["status"], 1.35, 0.25)
	pop(p["preview_box"], 1.2, 0.22)
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
	Game.go_to(Game.MATCH_SCENE)


func _back() -> void:
	if _starting:
		return
	Sfx.play("ui_back")
	Game.go_to(Game.MODE_SCENE)


func _refresh() -> void:
	if _arena_label:
		_arena_label.text = "Arena: " + Game.arena_name(Game.arena_index)
	for pid in PLAYERS:
		var p: Dictionary = _panels[pid]
		var info: Dictionary = Game.CHARACTERS[choice[pid]]
		p["title"].text = Game.player_label(pid).to_upper()
		p["name"].text = info["name"]
		p["desc"].text = info["desc"]
		p["weight"].text = "Peso: " + info["weight"]
		var active := slot_active(pid)
		var status: Label = p["status"]
		if locked[pid]:
			status.text = "PRONTO!"
			status.add_theme_color_override("font_color", GOOD)
		elif active:
			status.text = "Escolhendo..."
			status.add_theme_color_override("font_color", ACCENT)
		else:
			status.text = "Aguardando o Jogador 1"
			status.add_theme_color_override("font_color", WAITING)
		var confirm: Button = p["confirm"]
		confirm.text = "Desfazer" if locked[pid] else "Confirmar"
		confirm.disabled = not active
		var preview: TextureRect = p["preview"]
		if info.has("retrato") and ResourceLoader.exists(info["retrato"]):
			preview.texture = load(info["retrato"])
		preview.flip_h = pid == "p2"  # os dois retratos se olham
		preview.modulate = Color.WHITE if active or locked[pid] else Color(1, 1, 1, 0.35)
		# Contorno do cartão: dourado em quem está escolhendo, verde em quem confirmou
		var border := WAITING if not active else ACCENT
		if locked[pid]:
			border = GOOD
		(p["root"] as PanelContainer).add_theme_stylebox_override("panel", _card_style(border, active or locked[pid]))


func _card_style(border: Color, highlighted: bool) -> StyleBoxFlat:
	var style := (theme_shared().get_stylebox("panel", "PanelContainer") as StyleBoxFlat).duplicate() as StyleBoxFlat
	style.border_color = border
	style.set_border_width_all(4 if highlighted else 2)
	if not highlighted:
		style.bg_color = style.bg_color.darkened(0.2)
	return style
