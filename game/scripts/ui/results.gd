class_name ResultsScreen
extends MenuScreen
## Tela de resultado: a arte de apresentação do vencedor entra grande pela
## esquerda (sem passar da coluna dos números); à direita, faixa "Jogador N
## venceu!" na cor dele, o lutador, o placar e um cartão por jogador com retrato
## (o perdedor apagado), dano causado, KOs e o golpe que mais acertou; Revanche e Menu.
## Confete verde-amarelo cai enquanto a tela está aberta.

signal rematch_requested

const INPUT_LOCK := 0.6
const ART_H := 940.0
const COLUMN_X := 860.0

var title_label: Label
var kos_label: Label
var detail_label: Label

var _ribbon: PanelContainer
var _art: TextureRect
var _art_tween: Tween
var _faces := {}   # pid -> TextureRect
## pid -> {card, who, fighter, dano, kos, golpe} (Labels do cartão de estatísticas)
var stat_cards := {}
var _confetti: CPUParticles2D


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	var dim := ColorRect.new()
	dim.color = Color(0.04, 0.02, 0.06, 0.78)
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	dim.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(dim)

	_art = TextureRect.new()
	_art.name = "ArteVencedor"
	_art.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	_art.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	_art.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_art)

	_confetti = _make_confetti()
	add_child(_confetti)

	# Coluna da direita (entra com a animação padrão das telas)
	var holder := Control.new()   # play_intro() mexe na posição deste
	holder.set_anchors_preset(Control.PRESET_FULL_RECT)
	holder.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(holder)
	_content = holder
	var area := CenterContainer.new()
	area.position = Vector2(COLUMN_X, 0)
	area.size = Vector2(1920 - COLUMN_X - 40, 1080)
	area.mouse_filter = Control.MOUSE_FILTER_IGNORE
	holder.add_child(area)
	var col := VBoxContainer.new()
	col.add_theme_constant_override("separation", 18)
	area.add_child(col)

	_ribbon = PanelContainer.new()
	_ribbon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_ribbon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	col.add_child(_ribbon)
	title_label = make_label("")
	UiArt.outlined(title_label, 60, UiArt.CREAM, 12)
	title_label.add_theme_font_override("font", load("res://assets/fonts/kenney_future.ttf"))
	_ribbon.add_child(title_label)

	detail_label = make_label("")
	UiArt.outlined(detail_label, 40, UiArt.GOLD, 10)
	col.add_child(detail_label)

	kos_label = make_label("")
	kos_label.name = "Placar"
	UiArt.outlined(kos_label, 34, UiArt.CREAM, 8)
	col.add_child(kos_label)

	var cards := HBoxContainer.new()
	cards.alignment = BoxContainer.ALIGNMENT_CENTER
	cards.add_theme_constant_override("separation", 24)
	col.add_child(cards)
	for pid in PLAYERS:
		cards.add_child(_stat_card(pid))

	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 4)
	col.add_child(gap)
	for entry in [["Revanche", func() -> void: rematch_requested.emit(), false],
			["Menu", func() -> void: Game.go_menu(), true]]:
		var b := add_button(col, entry[0], entry[1], entry[2])
		b.custom_minimum_size = Vector2(440, 76)
		b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		UiArt.style_button(b, 32)
	visible = false


const CARD_W := 470.0


## Cartão de um jogador: retrato + nome, e as três linhas de números.
func _stat_card(pid: String) -> Control:
	var card := PanelContainer.new()
	card.name = "Cartao" + pid.to_upper()
	card.custom_minimum_size = Vector2(CARD_W, 0)
	card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 6)
	card.add_child(v)
	var top := HBoxContainer.new()
	top.add_theme_constant_override("separation", 14)
	v.add_child(top)
	top.add_child(_face(pid))
	var names := VBoxContainer.new()
	names.alignment = BoxContainer.ALIGNMENT_CENTER
	names.add_theme_constant_override("separation", 2)
	top.add_child(names)
	var who := make_label("")
	who.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	UiArt.outlined(who, 30, (Game.PLAYER_COLORS[pid] as Color).lightened(0.3), 7)
	names.add_child(who)
	var fighter := make_label("")
	fighter.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	UiArt.outlined(fighter, 26, UiArt.CREAM, 6)
	fighter.clip_text = true
	fighter.custom_minimum_size = Vector2(CARD_W - 36 - 100 - 14, 0)
	names.add_child(fighter)
	var dano := _stat_row(v, "Dano causado")
	var kos := _stat_row(v, "KOs")
	var caption := make_label("Golpe que mais acertou")
	caption.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	UiArt.outlined(caption, 26, UiArt.CREAM, 6)
	v.add_child(caption)
	var golpe := make_label("")
	golpe.name = "Golpe"
	golpe.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	UiArt.outlined(golpe, 30, UiArt.GOLD, 7)
	golpe.custom_minimum_size = Vector2(CARD_W - 36, 0)
	v.add_child(golpe)
	stat_cards[pid] = {"card": card, "who": who, "fighter": fighter, "dano": dano, "kos": kos, "golpe": golpe}
	return card


func _stat_row(parent: Control, caption: String) -> Label:
	var row := HBoxContainer.new()
	parent.add_child(row)
	var l := make_label(caption)
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	UiArt.outlined(l, 26, UiArt.CREAM, 6)
	row.add_child(l)
	var value := make_label("")
	value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	UiArt.outlined(value, 32, UiArt.GOLD, 7)
	row.add_child(value)
	return value


func _card_style(pid: String, won: bool) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = Color(0.07, 0.05, 0.08, 0.9)
	s.border_color = UiArt.GOLD if won else (Game.PLAYER_COLORS[pid] as Color).darkened(0.2)
	s.set_border_width_all(5 if won else 3)
	s.set_corner_radius_all(14)
	s.content_margin_left = 18
	s.content_margin_right = 18
	s.content_margin_top = 14
	s.content_margin_bottom = 14
	return s


func _face(pid: String) -> Control:
	var frame := Panel.new()
	frame.custom_minimum_size = Vector2(100, 100)
	frame.clip_contents = true
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var s := StyleBoxFlat.new()
	s.bg_color = (Game.PLAYER_COLORS[pid] as Color).darkened(0.6)
	s.border_color = Game.PLAYER_COLORS[pid]
	s.set_border_width_all(5)
	s.set_corner_radius_all(12)
	frame.add_theme_stylebox_override("panel", s)
	var pic := TextureRect.new()
	pic.set_anchors_preset(Control.PRESET_FULL_RECT)
	pic.offset_left = 5
	pic.offset_top = 5
	pic.offset_right = -5
	pic.offset_bottom = -5
	pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	pic.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	pic.mouse_filter = Control.MOUSE_FILTER_IGNORE
	frame.add_child(pic)
	_faces[pid] = pic
	return frame


## Confete nas cores do Brasil caindo do topo.
func _make_confetti() -> CPUParticles2D:
	var p := CPUParticles2D.new()
	p.emitting = false
	p.amount = 90
	p.lifetime = 3.2
	p.position = Vector2(960, -20)
	p.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
	p.emission_rect_extents = Vector2(960, 10)
	p.direction = Vector2(0, 1)
	p.spread = 25.0
	p.gravity = Vector2(0, 260)
	p.initial_velocity_min = 80.0
	p.initial_velocity_max = 220.0
	p.angular_velocity_min = -360.0
	p.angular_velocity_max = 360.0
	p.scale_amount_min = 6.0
	p.scale_amount_max = 12.0
	var g := Gradient.new()
	g.offsets = PackedFloat32Array([0.0, 0.33, 0.66, 1.0])
	g.colors = PackedColorArray([Color("2fa84f"), Color("ffc83d"), Color("3a6fe0"), Color("fff1d0")])
	p.color_initial_ramp = g
	return p


## Índice em Game.CHARACTERS do lutador de cada lado.
func _char_index(result: Dictionary, pid: String) -> int:
	var idx: Dictionary = result.get("indices", {})
	return int(idx.get(pid, Game.character_index(pid)))


## result: winner (id), kos {p1, p2}, labels {p1, p2}, characters {p1, p2} e
## (opcional) indices {p1, p2} em Game.CHARACTERS.
func show_result(result: Dictionary) -> void:
	var winner: String = result["winner"]
	title_label.text = "%s venceu!" % result["labels"][winner]
	_ribbon.add_theme_stylebox_override("panel", _ribbon_style(Game.PLAYER_COLORS[winner]))
	detail_label.text = "com %s" % result["characters"][winner]
	var kos: Dictionary = result["kos"]
	var labels: Dictionary = result["labels"]
	kos_label.text = "%s  %d   x   %d  %s" % [labels["p1"], kos["p1"], kos["p2"], labels["p2"]]
	var stats: Dictionary = result.get("stats", {})
	# Luta-espelho: o P2 aparece com a paleta trocada (retrato e, se venceu, a arte)
	var mirror := Espelho.is_mirror(_char_index(result, "p1"), _char_index(result, "p2"))
	Espelho.set_on(_faces["p2"], mirror)
	Espelho.set_on(_faces["p1"], false)
	Espelho.set_on(_art, mirror and winner == "p2")
	for pid in PLAYERS:
		var i := _char_index(result, pid)
		var pic: TextureRect = _faces[pid]
		pic.texture = UiArt.portrait(String(Game.CHARACTERS[i].get("id", ""))) if i >= 0 else null
		(pic.get_parent() as Control).modulate = Color.WHITE if pid == winner else Color(0.45, 0.45, 0.5)
		var c: Dictionary = stat_cards[pid]
		(c["card"] as PanelContainer).add_theme_stylebox_override("panel", _card_style(pid, pid == winner))
		(c["who"] as Label).text = String(labels[pid])
		(c["fighter"] as Label).text = String(result["characters"][pid])
		var st: Dictionary = stats.get(pid, {})
		(c["dano"] as Label).text = "%d%%" % int(st.get("dano", 0))
		(c["kos"] as Label).text = str(int(st.get("kos", kos.get(pid, 0))))
		var top := String(st.get("golpe_top_nome", ""))
		(c["golpe"] as Label).text = "%s  ×%d" % [top, int(st.get("golpe_top_acertos", 0))] if top != "" else "nenhum acerto"
	_show_art(_char_index(result, winner))
	visible = true
	_confetti.restart()
	_confetti.emitting = true
	# A faixa do título "estoura" depois do layout, junto com a entrada da tela
	pop.call_deferred(_ribbon, 1.3, 0.3)
	# Trava curta para os botões não serem apertados sem querer por quem ainda joga
	for b in buttons:
		b.disabled = true
	await get_tree().create_timer(INPUT_LOCK).timeout
	if not visible:
		return
	for b in buttons:
		b.disabled = false
	focus_first()


## Arte do vencedor entrando pela esquerda e depois respirando de leve.
func _show_art(idx: int) -> void:
	if _art_tween != null and _art_tween.is_valid():
		_art_tween.kill()
	var t: Texture2D = UiArt.splash(String(Game.CHARACTERS[idx].get("id", ""))) if idx >= 0 else null
	_art.texture = t
	_art.visible = t != null
	if t == null:
		return
	# Cabe à esquerda da coluna dos números (nunca por baixo deles)
	var max_w := COLUMN_X - 70.0
	var h := ART_H
	var w := h * t.get_width() / t.get_height()
	if w > max_w:
		w = max_w
		h = w * t.get_height() / t.get_width()
	_art.size = Vector2(w, h)
	var end := Vector2(maxf(30.0, (COLUMN_X - 40.0 - w) * 0.5), 1080 - h - 10)
	_art.position = end - Vector2(320, 0)
	_art.modulate.a = 0.0
	_art.scale = Vector2.ONE
	_art.pivot_offset = Vector2(w * 0.5, h)
	_art_tween = _art.create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_art_tween.tween_property(_art, "position", end, 0.45).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_art_tween.parallel().tween_property(_art, "modulate:a", 1.0, 0.25)
	_art_tween.tween_callback(_breathe)


func _breathe() -> void:
	_art_tween = _art.create_tween().set_loops().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_art_tween.tween_property(_art, "scale", Vector2(1.0, 1.015), 1.3).set_trans(Tween.TRANS_SINE)
	_art_tween.tween_property(_art, "scale", Vector2.ONE, 1.3).set_trans(Tween.TRANS_SINE)


func _ribbon_style(color: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = color.darkened(0.15)
	s.border_color = UiArt.INK
	s.set_border_width_all(5)
	s.skew = Vector2(-0.12, 0)
	s.content_margin_left = 50
	s.content_margin_right = 50
	s.content_margin_top = 8
	s.content_margin_bottom = 12
	s.shadow_color = Color(0, 0, 0, 0.4)
	s.shadow_size = 8
	return s


func _notification(what: int) -> void:
	super._notification(what)
	if what == NOTIFICATION_VISIBILITY_CHANGED and _confetti != null and not is_visible_in_tree():
		_confetti.emitting = false
		if _art_tween != null and _art_tween.is_valid():
			_art_tween.kill()
