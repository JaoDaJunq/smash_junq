class_name UiArt
## Peças visuais das telas fora da partida, na "vibe" do jogo: fundo pintado,
## lutador em pixel art animado, placas de madeira com fita, selos e faixas.
## Tudo cai num reserva simples se a arte ainda não existir.

const MENU_BG := "res://assets/ui/menu_fundo.png"
const LOGO := "res://assets/ui/logo.png"
const MAP := "res://assets/ui/mapa_brasil.png"

const WOOD := Color("7a4a26")
const WOOD_DARK := Color("4a2a14")
const WOOD_LIGHT := Color("a8693a")
const INK := Color("2a0f12")     # contorno vinho-escuro (bíblia visual)
const GOLD := Color("ffc83d")
const CREAM := Color("fff1d0")
const RIBBON := Color("2fa84f")   # verde da faixa de campeonato
const PANEL_BG := Color(0.11, 0.07, 0.06, 0.88)


static func tex(path: String) -> Texture2D:
	return load(path) if ResourceLoader.exists(path) else null


## Arte de apresentação (pintada, corpo inteiro, fundo transparente) do lutador.
static func splash(char_id: String) -> Texture2D:
	return tex("res://assets/ui/apresentacao_%s.png" % char_id)


## Retrato quadrado em pixel art; sem ele, o rosto do 1º quadro do "parado".
static func portrait(char_id: String) -> Texture2D:
	var t := tex("res://assets/characters/%s/retrato_pixel.png" % char_id)
	if t != null:
		return t
	var sheet := tex("res://assets/characters/%s/pixel/parado.png" % char_id)
	if sheet == null:
		return null
	var a := AtlasTexture.new()
	a.atlas = sheet
	a.region = Rect2(14, 4, 36, 36)
	return a


## Índice em Game.CHARACTERS do lutador (pela cena dele); -1 se não achar.
static func char_index_of(fighter: Node) -> int:
	if fighter != null:
		for i in Game.CHARACTERS.size():
			if Game.CHARACTERS[i]["scene"] == fighter.scene_file_path:
				return i
	return -1


## Texto com quebras de linha manuais vira um parágrafo só (o autowrap quebra).
static func flat(text: String) -> String:
	return text.replace("\r", "").replace(":\n", ": ").replace("\n", " ")


## Maior tamanho de fonte (até size) em que o texto cabe em width.
static func fit_size(l: Label, size: int, width: float, min_size := 18) -> void:
	var font := l.get_theme_font("font")
	var s := size
	while s > min_size and font.get_string_size(l.text, HORIZONTAL_ALIGNMENT_LEFT, -1, s).x > width:
		s -= 2
	l.add_theme_font_size_override("font_size", s)


## Fundo pintado cobrindo a tela (escurecido por "dim"), com um zoom lento de
## "respiração" para a tela não ficar parada.
static func backdrop(dim := 0.0, breathe := true) -> Control:
	var t := tex(MENU_BG)
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_STOP
	root.clip_contents = true
	if t == null:
		var c := ColorRect.new()
		c.color = Color("1d2240")
		c.set_anchors_preset(Control.PRESET_FULL_RECT)
		c.mouse_filter = Control.MOUSE_FILTER_IGNORE
		root.add_child(c)
		return root
	var r := TextureRect.new()
	r.texture = t
	r.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	r.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	r.set_anchors_preset(Control.PRESET_FULL_RECT)
	r.mouse_filter = Control.MOUSE_FILTER_IGNORE
	r.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	root.add_child(r)
	if breathe:
		r.resized.connect(func() -> void: r.pivot_offset = r.size * 0.5)
		var tw := r.create_tween().set_loops().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tw.tween_property(r, "scale", Vector2.ONE * 1.05, 14.0).set_trans(Tween.TRANS_SINE)
		tw.tween_property(r, "scale", Vector2.ONE, 14.0).set_trans(Tween.TRANS_SINE)
	if dim > 0.0:
		var d := ColorRect.new()
		d.color = Color(0.05, 0.03, 0.08, dim)
		d.set_anchors_preset(Control.PRESET_FULL_RECT)
		d.mouse_filter = Control.MOUSE_FILTER_IGNORE
		root.add_child(d)
	return root


## Placa de madeira (botão do menu, painéis). focused: borda dourada.
static func plank(focused := false, radius := 10) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = WOOD_LIGHT if focused else WOOD
	s.border_color = GOLD if focused else INK
	s.set_border_width_all(4)
	s.border_width_bottom = 9
	s.set_corner_radius_all(radius)
	s.set_content_margin_all(14)
	s.shadow_color = Color(0, 0, 0, 0.35)
	s.shadow_size = 6
	s.shadow_offset = Vector2(0, 5)
	return s


## Painel escuro com borda de madeira (cartões de informação).
static func panel(border := INK, width := 4) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = PANEL_BG
	s.border_color = border
	s.set_border_width_all(width)
	s.set_corner_radius_all(12)
	s.set_content_margin_all(16)
	s.shadow_color = Color(0, 0, 0, 0.4)
	s.shadow_size = 8
	return s


## Aplica o visual de placa nos estados de um botão.
static func style_button(b: Button, font_size := 34) -> void:
	b.add_theme_stylebox_override("normal", plank(false))
	b.add_theme_stylebox_override("hover", plank(true))
	b.add_theme_stylebox_override("focus", plank(true))
	b.add_theme_stylebox_override("pressed", plank(true))
	b.add_theme_stylebox_override("disabled", plank(false))
	b.add_theme_color_override("font_color", CREAM)
	b.add_theme_color_override("font_focus_color", GOLD)
	b.add_theme_color_override("font_hover_color", GOLD)
	b.add_theme_color_override("font_pressed_color", GOLD)
	b.add_theme_color_override("font_hover_pressed_color", GOLD)
	b.add_theme_color_override("font_disabled_color", Color(CREAM, 0.4))
	b.add_theme_stylebox_override("hover_pressed", plank(true))
	b.add_theme_color_override("font_outline_color", INK)
	b.add_theme_constant_override("outline_size", 8)
	b.add_theme_font_size_override("font_size", font_size)


## Texto com contorno grosso (títulos e nomes).
static func outlined(l: Label, size: int, color := CREAM, outline := 10) -> Label:
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	l.add_theme_color_override("font_outline_color", INK)
	l.add_theme_constant_override("outline_size", outline)
	return l


## Faixa de campeonato (fita verde com pontas em V) atrás de um título.
static func ribbon(text: String, size := 54, color := RIBBON) -> Control:
	var box := PanelContainer.new()
	var s := StyleBoxFlat.new()
	s.bg_color = color
	s.border_color = INK
	s.set_border_width_all(4)
	s.skew = Vector2(-0.12, 0)
	s.content_margin_left = 46
	s.content_margin_right = 46
	s.content_margin_top = 6
	s.content_margin_bottom = 10
	box.add_theme_stylebox_override("panel", s)
	var l := Label.new()
	l.text = text
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	outlined(l, size, CREAM, 10)
	l.add_theme_font_override("font", load("res://assets/fonts/kenney_future.ttf"))
	box.add_child(l)
	box.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return box


## Lutador em pixel art tocando uma animação em loop (folha horizontal de quadros
## de 64x64). Usa TextureRect para caber em layouts de Control.
class FighterIdle extends TextureRect:
	var frames := 1
	var fps := 6.0
	var _t := 0.0
	var _atlas := AtlasTexture.new()

	func setup(sheet_path: String, px: float, speed := 6.0) -> FighterIdle:
		fps = speed
		var sheet: Texture2D = UiArt.tex(sheet_path)
		texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		custom_minimum_size = Vector2(64, 64) * px
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		if sheet != null:
			frames = maxi(1, int(sheet.get_width() / 64))
			_atlas.atlas = sheet
			_atlas.region = Rect2(0, 0, 64, 64)
			texture = _atlas
		return self

	func _process(delta: float) -> void:
		if _atlas.atlas == null:
			return
		_t += delta
		_atlas.region = Rect2((int(_t * fps) % frames) * 64, 0, 64, 64)
