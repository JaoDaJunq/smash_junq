class_name ResultsScreen
extends MenuScreen
## Tela de resultado: a arte de apresentação do vencedor entra grande pela
## esquerda; à direita, faixa "Jogador N venceu!" na cor dele, o lutador, o
## placar com os retratos dos dois (o perdedor apagado), Revanche e Menu.
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

	var score := HBoxContainer.new()
	score.alignment = BoxContainer.ALIGNMENT_CENTER
	score.add_theme_constant_override("separation", 22)
	col.add_child(score)
	for pid in PLAYERS:
		if pid == "p2":
			kos_label = make_label("")
			UiArt.outlined(kos_label, 34, UiArt.CREAM, 8)
			kos_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			score.add_child(kos_label)
		score.add_child(_face(pid))

	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 16)
	col.add_child(gap)
	for entry in [["Revanche", func() -> void: rematch_requested.emit(), false],
			["Menu", func() -> void: Game.go_menu(), true]]:
		var b := add_button(col, entry[0], entry[1], entry[2])
		b.custom_minimum_size = Vector2(440, 76)
		b.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		UiArt.style_button(b, 32)
	visible = false


func _face(pid: String) -> Control:
	var frame := Panel.new()
	frame.custom_minimum_size = Vector2(120, 120)
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
	for pid in PLAYERS:
		var i := _char_index(result, pid)
		var pic: TextureRect = _faces[pid]
		pic.texture = UiArt.portrait(String(Game.CHARACTERS[i].get("id", ""))) if i >= 0 else null
		(pic.get_parent() as Control).modulate = Color.WHITE if pid == winner else Color(0.45, 0.45, 0.5)
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
	var w := ART_H * t.get_width() / t.get_height()
	_art.size = Vector2(w, ART_H)
	var end := Vector2(maxf(40.0, (COLUMN_X - w) * 0.5), 1080 - ART_H - 10)
	_art.position = end - Vector2(320, 0)
	_art.modulate.a = 0.0
	_art.scale = Vector2.ONE
	_art.pivot_offset = Vector2(w * 0.5, ART_H)
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
