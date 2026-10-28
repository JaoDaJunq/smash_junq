class_name Hud
extends CanvasLayer
## Interface da luta (T18): por jogador, painel compacto com retrato, selo
## P1/P2/CPU, nome, dano % que muda de cor e VIDAS (cabecinhas que apagam); mais um aviso grande no centro (contagem, "MORTE SÚBITA").
## Atualiza na hora pelo sinal damage_changed e por set_kos(). Os números "estouram"
## quando o dano sobe, as vidas apagam e o aviso entra com um quique.

const MAX_SHOWN_DAMAGE := 999
## Cores do dano: 0% branco, 50% amarelo, 100% laranja, 150% ou mais vermelho.
const DAMAGE_STOPS: Array[Array] = [
	[0.0, Color(1.0, 1.0, 1.0)],
	[50.0, Color(1.0, 0.92, 0.25)],
	[100.0, Color(1.0, 0.58, 0.12)],
	[150.0, Color(0.95, 0.16, 0.12)],
]
const PUNCH_TIME := 0.22
const BANNER_TIME := 0.3
const PORTRAIT := 96.0
## Largura da coluna de texto (nome, dano, vidas) do painel.
const NAME_W := 254.0
const DAMAGE_SIZE := 58

## Vidas de um jogador: uma cabecinha (retrato) por vida. A partida é de
## "primeiro a ko_target KOs", então, num 1 contra 1, cada KO do adversário é
## uma vida a menos: vidas = ko_target - KOs do outro. Vida perdida APAGA
## (cabecinha escura e transparente) com um tranco; ganhar de volta (revanche)
## acende de novo.
class Lives extends Control:
	var total := 3
	var lives := 3
	var color := Color.WHITE
	var head: Texture2D = null
	var head_src := Rect2()
	const SIZE := 30.0
	const GAP := 6.0
	const ANIM_TIME := 0.45
	const OFF := Color(0.22, 0.22, 0.27, 0.45)

	var _changed: Array[int] = []
	var _t := 1.0
	var _tween: Tween

	func _init() -> void:
		mouse_filter = Control.MOUSE_FILTER_IGNORE

	func configure(new_total: int, new_color: Color, portrait: Texture2D) -> void:
		total = new_total
		lives = new_total
		color = new_color
		head = portrait
		if head != null:
			# Recorte quadrado do alto do retrato (a cabeça)
			var w := float(head.get_width())
			var side := w * 0.62
			head_src = Rect2((w - side) * 0.5, float(head.get_height()) * 0.02, side, side)
		custom_minimum_size = Vector2(total * (SIZE + GAP) - GAP, SIZE)
		queue_redraw()

	func set_lives(n: int) -> void:
		n = clampi(n, 0, total)
		if n == lives:
			return
		_changed.clear()
		for i in range(mini(n, lives), maxi(n, lives)):
			_changed.append(i)
		lives = n
		if _tween != null and _tween.is_valid():
			_tween.kill()
		if not is_inside_tree():
			_t = 1.0
			queue_redraw()
			return
		_t = 0.0
		_tween = create_tween()
		_tween.tween_method(_set_t, 0.0, 1.0, ANIM_TIME)

	func _set_t(value: float) -> void:
		_t = value
		queue_redraw()

	func _draw() -> void:
		for i in total:
			var alive := i < lives
			var grow := 1.0
			var tint := Color.WHITE if alive else OFF
			if i in _changed and _t < 1.0:
				if alive:   # acendeu: cresce e assenta
					grow = 1.0 + 0.5 * pow(1.0 - _t, 2.0)
				else:       # apagou: dá um tranco, fica vermelha e vai escurecendo
					grow = 1.0 + 0.45 * sin(_t * PI) * (1.0 - _t)
					tint = Color(1.6, 0.5, 0.45).lerp(OFF, _t)
			var c := Vector2(SIZE * 0.5 + i * (SIZE + GAP), SIZE * 0.5)
			var half := SIZE * 0.5 * grow
			var r := Rect2(c - Vector2(half, half), Vector2(half, half) * 2.0)
			draw_rect(r.grow(2.0), Color(0.03, 0.03, 0.05, 0.9 if alive else 0.5))
			if head != null:
				draw_texture_rect_region(head, r, head_src, tint)
			else:
				draw_circle(c, half, Color(color, tint.a) * Color(tint.r, tint.g, tint.b))
			draw_rect(r.grow(1.0), (color if alive else Color(0.4, 0.4, 0.45, 0.6)), false, 2.0)

## player_id -> {name, damage, markers, fighter, shown, tweens}
var panels := {}
var banner: Label
var ko_target := 3
## P1 e P2 com o mesmo lutador (P2 de paleta trocada).
var mirror := false
var _banner_id := 0
var _banner_tween: Tween


static func damage_color(percent: float) -> Color:
	if percent <= 0.0:
		return DAMAGE_STOPS[0][1]
	for i in range(1, DAMAGE_STOPS.size()):
		var lo: Array = DAMAGE_STOPS[i - 1]
		var hi: Array = DAMAGE_STOPS[i]
		if percent <= hi[0]:
			return (lo[1] as Color).lerp(hi[1], (percent - lo[0]) / (hi[0] - lo[0]))
	return DAMAGE_STOPS[DAMAGE_STOPS.size() - 1][1]


func _ready() -> void:
	layer = 5


## Monta os painéis. fighters: player_id -> Fighter.
func setup(fighters: Dictionary, target: int) -> void:
	ko_target = target
	# Luta-espelho: apenas o sprite da luta ganha a cor 2. Retrato e vidas
	# preservam as cores originais.
	mirror = fighters.has("p1") and fighters.has("p2") \
		and Espelho.is_mirror(UiArt.char_index_of(fighters["p1"]), UiArt.char_index_of(fighters["p2"]))
	if mirror and not Espelho.is_applied(fighters["p2"]):
		Espelho.apply_fighter(fighters["p2"])
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)

	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for side in ["left", "right", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 36)
	root.add_child(margin)
	var row := HBoxContainer.new()
	row.size_flags_vertical = Control.SIZE_SHRINK_END
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.add_child(row)
	var ids: Array = fighters.keys()
	ids.sort()
	for i in ids.size():
		if i > 0:
			var spacer := Control.new()
			spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
			row.add_child(spacer)
		var pid: String = ids[i]
		var panel := _build_panel(pid, fighters[pid])
		row.add_child(panel)

	banner = Label.new()
	banner.theme_type_variation = "BannerLabel"
	banner.set_anchors_preset(Control.PRESET_FULL_RECT)
	banner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	banner.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	banner.mouse_filter = Control.MOUSE_FILTER_IGNORE
	banner.visible = false
	root.add_child(banner)


func _build_panel(pid: String, fighter: Fighter) -> Control:
	var box := PanelContainer.new()
	box.name = "Painel" + pid.to_upper()
	box.theme_type_variation = "HudPanel"
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Painel compacto (~393x138 em 1080p): faixa do topo na cor do jogador
	var style := MenuScreen.theme_shared().get_stylebox("panel", "HudPanel").duplicate() as StyleBoxFlat
	style.border_color = fighter.body_color
	style.border_width_top = 5
	style.content_margin_left = 12
	style.content_margin_right = 16
	style.content_margin_top = 9
	style.content_margin_bottom = 9
	style.set_corner_radius_all(12)
	box.add_theme_stylebox_override("panel", style)
	var h := HBoxContainer.new()
	h.add_theme_constant_override("separation", 10)
	h.mouse_filter = Control.MOUSE_FILTER_IGNORE
	box.add_child(h)
	var portrait := _build_portrait(fighter)
	if portrait != null:
		h.add_child(portrait)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 0)
	v.mouse_filter = Control.MOUSE_FILTER_IGNORE
	h.add_child(v)

	# Linha de cima: selo P1/P2/CPU na cor do jogador + nome do lutador
	var top := HBoxContainer.new()
	top.add_theme_constant_override("separation", 8)
	top.mouse_filter = Control.MOUSE_FILTER_IGNORE
	v.add_child(top)
	var tag := _build_tag(pid, fighter.body_color)
	top.add_child(tag)
	var name_label := Label.new()
	name_label.text = fighter.display_name
	name_label.tooltip_text = "%s · %s" % [Game.player_label(pid), fighter.display_name]
	name_label.add_theme_font_size_override("font_size", 22)
	name_label.add_theme_color_override("font_color", fighter.body_color.lightened(0.45))
	name_label.add_theme_color_override("font_outline_color", Color(0.03, 0.04, 0.08, 0.9))
	name_label.add_theme_constant_override("outline_size", 5)
	name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	name_label.clip_text = true
	name_label.custom_minimum_size = Vector2(NAME_W - tag.custom_minimum_size.x - 8, 0)
	top.add_child(name_label)

	var damage := Label.new()
	damage.theme_type_variation = "DamageLabel"
	damage.add_theme_font_size_override("font_size", DAMAGE_SIZE)
	damage.add_theme_constant_override("outline_size", 9)
	damage.custom_minimum_size = Vector2(NAME_W, DAMAGE_SIZE)
	damage.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	v.add_child(damage)

	var lives := Lives.new()
	var idx := UiArt.char_index_of(fighter)
	var head: Texture2D = UiArt.portrait(String(Game.CHARACTERS[idx].get("id", ""))) if idx >= 0 else null
	lives.configure(ko_target, fighter.body_color.lightened(0.15), head)
	v.add_child(lives)
	panels[pid] = {"name": name_label, "tag": tag, "damage": damage, "lives": lives, "fighter": fighter,
		"shown": 0.0, "tweens": [], "portrait": portrait, "box": box}
	if not fighter.damage_changed.is_connected(_on_damage_changed.bind(pid)):
		fighter.damage_changed.connect(_on_damage_changed.bind(pid))
	_show_damage(pid, fighter.damage_percent, false)
	return box


## Selo "P1" / "P2" / "CPU" (ou "BON" no treino) com fundo na cor do jogador,
## o mesmo texto da setinha em cima do lutador.
func _build_tag(pid: String, color: Color) -> Control:
	var text := pid.to_upper()
	if pid == "p2" and Game.mode == "cpu":
		text = "CPU"
	elif pid == "p2" and Game.mode == "training":
		text = "BON"
	var chip := Panel.new()
	chip.name = "Selo"
	chip.mouse_filter = Control.MOUSE_FILTER_IGNORE
	chip.custom_minimum_size = Vector2(26 + 15 * text.length(), 28)
	chip.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	var s := StyleBoxFlat.new()
	s.bg_color = color
	s.border_color = color.lightened(0.45)
	s.set_border_width_all(2)
	s.set_corner_radius_all(7)
	chip.add_theme_stylebox_override("panel", s)
	var l := Label.new()
	l.name = "Texto"
	l.text = text
	l.set_anchors_preset(Control.PRESET_FULL_RECT)
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	l.add_theme_font_size_override("font_size", 20)
	l.add_theme_color_override("font_color", Color.WHITE)
	l.add_theme_color_override("font_outline_color", color.darkened(0.65))
	l.add_theme_constant_override("outline_size", 5)
	l.mouse_filter = Control.MOUSE_FILTER_IGNORE
	chip.add_child(l)
	return chip


## Retrato em pixel art do lutador, numa moldura com a cor do jogador
## (null se o lutador não estiver no elenco, ex.: bonecos de teste).
func _build_portrait(fighter: Fighter) -> Control:
	var idx := UiArt.char_index_of(fighter)
	if idx < 0:
		return null
	var tex := UiArt.portrait(String(Game.CHARACTERS[idx].get("id", "")))
	if tex == null:
		return null
	var frame := Panel.new()
	frame.custom_minimum_size = Vector2(PORTRAIT, PORTRAIT)
	frame.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	frame.clip_contents = true
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var s := StyleBoxFlat.new()
	s.bg_color = fighter.body_color.darkened(0.6)
	s.border_color = fighter.body_color.lightened(0.2)
	s.set_border_width_all(3)
	s.set_corner_radius_all(9)
	frame.add_theme_stylebox_override("panel", s)
	var pic := TextureRect.new()
	pic.name = "Retrato"
	pic.texture = tex
	pic.set_anchors_preset(Control.PRESET_FULL_RECT)
	for side in ["left", "top"]:
		pic.set("offset_" + side, 3)
	for side in ["right", "bottom"]:
		pic.set("offset_" + side, -3)
	pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	pic.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	pic.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	pic.mouse_filter = Control.MOUSE_FILTER_IGNORE
	frame.add_child(pic)
	return frame


func _on_damage_changed(percent: float, pid: String) -> void:
	_show_damage(pid, percent, true)


func _show_damage(pid: String, percent: float, pop: bool) -> void:
	var info: Dictionary = panels[pid]
	var label: Label = info["damage"]
	label.text = "%d%%" % mini(roundi(percent), MAX_SHOWN_DAMAGE)
	label.add_theme_color_override("font_color", damage_color(percent))
	var gained: float = percent - float(info["shown"])
	info["shown"] = percent
	if pop and gained > 0.0:
		_punch_damage(info, gained)
	elif gained < 0.0:
		_clear_punch(info)


## Número "estoura": escala, brilho e um tremor curto. Golpes fortes batem mais forte.
func _punch_damage(info: Dictionary, gained: float) -> void:
	var label: Label = info["damage"]
	_clear_punch(info)
	var power := clampf(gained / 25.0, 0.0, 1.0)
	var text_w := label.get_theme_font("font").get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, label.get_theme_font_size("font_size")).x
	label.pivot_offset = Vector2(minf(label.size.x, text_w) * 0.5, label.size.y * 0.5)
	label.scale = Vector2.ONE * (1.25 + 0.3 * power)
	label.modulate = Color(1.8, 1.8, 1.8)
	var pop_tween := create_tween().set_parallel(true)
	pop_tween.tween_property(label, "scale", Vector2.ONE, PUNCH_TIME).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	pop_tween.tween_property(label, "modulate", Color.WHITE, PUNCH_TIME)
	# Tremor: balança de um lado a outro e assenta
	var shake := deg_to_rad(3.0 + 4.0 * power)
	var shake_tween := create_tween()
	for k in [1.0, -0.8, 0.5, -0.25, 0.0]:
		shake_tween.tween_property(label, "rotation", shake * k, 0.035)
	var tweens: Array = [pop_tween, shake_tween]
	# Retrato: pisca vermelho e dá um tranco junto com o número
	var portrait: Control = info.get("portrait")
	if portrait != null:
		portrait.pivot_offset = portrait.size * 0.5
		portrait.modulate = Color(1.9, 0.7, 0.7)
		portrait.scale = Vector2.ONE * (1.08 + 0.08 * power)
		var pt := create_tween().set_parallel(true)
		pt.tween_property(portrait, "modulate", Color.WHITE, PUNCH_TIME * 1.4)
		pt.tween_property(portrait, "scale", Vector2.ONE, PUNCH_TIME).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tweens.append(pt)
	info["tweens"] = tweens


func _clear_punch(info: Dictionary) -> void:
	for tw: Tween in info["tweens"]:
		if tw != null and tw.is_valid():
			tw.kill()
	info["tweens"] = []
	var label: Label = info["damage"]
	label.scale = Vector2.ONE
	label.rotation = 0.0
	label.modulate = Color.WHITE
	var portrait: Control = info.get("portrait")
	if portrait != null:
		portrait.scale = Vector2.ONE
		portrait.modulate = Color.WHITE


## kos: player_id -> KOs marcados por esse jogador. Mostra VIDAS: cada KO do
## adversário apaga uma cabecinha (vidas = ko_target - KOs do outro). Na morte
## súbita (empate na meta) cada um fica com 1 vida acesa: o próximo KO decide.
func set_kos(kos: Dictionary) -> void:
	var a: int = int(kos.get("p1", 0))
	var b: int = int(kos.get("p2", 0))
	var sudden := a == b and a >= ko_target
	for pid in panels:
		var lives: Lives = panels[pid]["lives"]
		var other_kos: int = int(kos.get("p2" if pid == "p1" else "p1", 0))
		lives.set_lives(1 if sudden else ko_target - other_kos)
		lives.queue_redraw()


## Vidas acesas de um jogador (testes).
func lives_of(pid: String) -> int:
	return (panels[pid]["lives"] as Lives).lives


func refresh_damage() -> void:
	for pid in panels:
		_show_damage(pid, panels[pid]["fighter"].damage_percent, false)


## Aviso grande no centro. duration 0 = fica até hide_banner().
func show_banner(text: String, duration := 0.0, color := Color.WHITE) -> void:
	_banner_id += 1
	var id := _banner_id
	banner.text = text
	banner.add_theme_color_override("font_color", color)
	banner.visible = true
	if _banner_tween != null and _banner_tween.is_valid():
		_banner_tween.kill()
	# Entra pequeno e transparente, passa um pouco do tamanho e assenta (quique)
	var area := banner.size if banner.size.x > 0.0 else get_viewport().get_visible_rect().size
	banner.pivot_offset = area * 0.5
	banner.scale = Vector2(0.35, 0.35)
	banner.modulate.a = 0.0
	_banner_tween = create_tween().set_parallel(true)
	_banner_tween.tween_property(banner, "scale", Vector2.ONE, BANNER_TIME).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_banner_tween.tween_property(banner, "modulate:a", 1.0, BANNER_TIME * 0.35)
	if duration > 0.0:
		var t := create_tween()
		t.tween_interval(duration)
		t.tween_callback(func() -> void:
			if id == _banner_id:
				hide_banner())


func hide_banner() -> void:
	_banner_id += 1
	if _banner_tween != null and _banner_tween.is_valid():
		_banner_tween.kill()
	banner.modulate.a = 1.0
	banner.scale = Vector2.ONE
	banner.visible = false
