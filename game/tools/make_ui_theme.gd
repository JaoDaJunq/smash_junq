extends SceneTree
## Gera o tema do projeto em assets/ui/theme.tres (fontes Kenney, botões, painéis, rótulos).
## Rodar a partir da pasta game/:
##   godot --headless --script res://tools/make_ui_theme.gd
## Pode ser rodado de novo sempre que a paleta ou os tamanhos mudarem.

const OUT := "res://assets/ui/theme.tres"
const FONT_BODY := "res://assets/fonts/kenney_future_narrow.ttf"
const FONT_TITLE := "res://assets/fonts/kenney_future.ttf"

# Paleta: azul-marinho escuro, texto off-white e acento quente (dourado/laranja)
const NAVY := Color("1b2030")
const NAVY_LIGHT := Color("262d44")
const NAVY_HOVER := Color("323b5a")
const NAVY_DISABLED := Color("171b28")
const BORDER := Color("46506f")
const BORDER_SOFT := Color("343c58")
const TEXT := Color("f3efe6")
const TEXT_MUTED := Color("a9b1c8")
const TEXT_DISABLED := Color("5f6781")
const GOLD := Color("ffc83d")
const ORANGE := Color("ff9a2e")
const PRESSED_FILL := Color("5a4320")
const DARK_OUTLINE := Color(0.03, 0.04, 0.08, 0.92)


func _init() -> void:
	var body := load(FONT_BODY) as Font
	var title := load(FONT_TITLE) as Font
	if body == null or title == null:
		push_error("Fontes não encontradas (rode --import antes).")
		quit(1)
		return
	var t := Theme.new()
	t.default_font = body
	t.default_font_size = 28

	_buttons(t)
	_panels(t)
	_labels(t, title)

	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path("res://assets/ui"))
	var err := ResourceSaver.save(t, OUT)
	print("Tema salvo em %s (erro %d)" % [OUT, err])
	quit(err)


static func box(fill: Color, border: Color, border_width := 2, radius := 12) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = fill
	s.border_color = border
	s.set_border_width_all(border_width)
	s.set_corner_radius_all(radius)
	s.content_margin_left = 26
	s.content_margin_right = 26
	s.content_margin_top = 10
	s.content_margin_bottom = 10
	s.anti_aliasing = true
	return s


func _buttons(t: Theme) -> void:
	var normal := box(NAVY_LIGHT, BORDER)
	normal.shadow_color = Color(0, 0, 0, 0.35)
	normal.shadow_size = 6
	normal.shadow_offset = Vector2(0, 3)
	var hover := box(NAVY_HOVER, Color("6a769c"))
	hover.shadow_color = Color(0, 0, 0, 0.35)
	hover.shadow_size = 6
	hover.shadow_offset = Vector2(0, 3)
	var pressed := box(PRESSED_FILL, GOLD)
	# O foco é só um contorno quente por cima do estado atual (teclado e gamepad)
	var focus := box(Color(0, 0, 0, 0), GOLD, 4, 12)
	focus.draw_center = false
	focus.shadow_color = Color(GOLD, 0.35)
	focus.shadow_size = 10
	var disabled := box(NAVY_DISABLED, BORDER_SOFT)
	t.set_stylebox("normal", "Button", normal)
	t.set_stylebox("hover", "Button", hover)
	t.set_stylebox("hover_pressed", "Button", pressed)
	t.set_stylebox("pressed", "Button", pressed)
	t.set_stylebox("focus", "Button", focus)
	t.set_stylebox("disabled", "Button", disabled)
	t.set_color("font_color", "Button", TEXT)
	t.set_color("font_hover_color", "Button", Color.WHITE)
	t.set_color("font_hover_pressed_color", "Button", Color.WHITE)
	t.set_color("font_pressed_color", "Button", GOLD)
	t.set_color("font_focus_color", "Button", Color("fff1c9"))
	t.set_color("font_disabled_color", "Button", TEXT_DISABLED)
	t.set_font_size("font_size", "Button", 30)

	# Botão pequeno (setas e Confirmar da escolha de lutador)
	t.set_type_variation("SmallButton", "Button")
	var small_normal := box(NAVY_LIGHT, BORDER, 2, 10)
	small_normal.content_margin_top = 6
	small_normal.content_margin_bottom = 6
	small_normal.content_margin_left = 16
	small_normal.content_margin_right = 16
	var small_hover := small_normal.duplicate() as StyleBoxFlat
	small_hover.bg_color = NAVY_HOVER
	small_hover.border_color = Color("6a769c")
	var small_pressed := small_normal.duplicate() as StyleBoxFlat
	small_pressed.bg_color = PRESSED_FILL
	small_pressed.border_color = GOLD
	var small_disabled := small_normal.duplicate() as StyleBoxFlat
	small_disabled.bg_color = NAVY_DISABLED
	small_disabled.border_color = BORDER_SOFT
	t.set_stylebox("normal", "SmallButton", small_normal)
	t.set_stylebox("hover", "SmallButton", small_hover)
	t.set_stylebox("pressed", "SmallButton", small_pressed)
	t.set_stylebox("hover_pressed", "SmallButton", small_pressed)
	t.set_stylebox("disabled", "SmallButton", small_disabled)
	t.set_font_size("font_size", "SmallButton", 26)


func _panels(t: Theme) -> void:
	var panel := box(NAVY, BORDER, 2, 16)
	panel.content_margin_left = 28
	panel.content_margin_right = 28
	panel.content_margin_top = 22
	panel.content_margin_bottom = 22
	panel.shadow_color = Color(0, 0, 0, 0.4)
	panel.shadow_size = 12
	panel.shadow_offset = Vector2(0, 5)
	t.set_stylebox("panel", "PanelContainer", panel)
	t.set_stylebox("panel", "Panel", panel)

	# Painel do HUD: escuro translúcido, com faixa de cor no topo (a cor vem por código)
	t.set_type_variation("HudPanel", "PanelContainer")
	var hud := box(Color(0.05, 0.06, 0.09, 0.78), BORDER_SOFT, 0, 14)
	hud.border_width_top = 6
	hud.content_margin_left = 28
	hud.content_margin_right = 28
	hud.content_margin_top = 14
	hud.content_margin_bottom = 16
	t.set_stylebox("panel", "HudPanel", hud)


func _labels(t: Theme, title: Font) -> void:
	t.set_color("font_color", "Label", TEXT)
	t.set_font_size("font_size", "Label", 28)

	# Título de tela: fonte larga, dourado, contorno escuro
	t.set_type_variation("TitleLabel", "Label")
	t.set_font("font", "TitleLabel", title)
	t.set_font_size("font_size", "TitleLabel", 68)
	t.set_color("font_color", "TitleLabel", GOLD)
	t.set_color("font_outline_color", "TitleLabel", DARK_OUTLINE)
	t.set_constant("outline_size", "TitleLabel", 10)
	t.set_color("font_shadow_color", "TitleLabel", Color(ORANGE, 0.45))
	t.set_constant("shadow_offset_y", "TitleLabel", 5)

	# Título secundário (nome do lutador, "Jogador 1")
	t.set_type_variation("HeadingLabel", "Label")
	t.set_font("font", "HeadingLabel", title)
	t.set_font_size("font_size", "HeadingLabel", 32)
	t.set_color("font_outline_color", "HeadingLabel", DARK_OUTLINE)
	t.set_constant("outline_size", "HeadingLabel", 6)

	t.set_type_variation("SubtitleLabel", "Label")
	t.set_font_size("font_size", "SubtitleLabel", 30)
	t.set_color("font_color", "SubtitleLabel", TEXT_MUTED)

	t.set_type_variation("HintLabel", "Label")
	t.set_font_size("font_size", "HintLabel", 22)
	t.set_color("font_color", "HintLabel", TEXT_MUTED)

	t.set_type_variation("AccentLabel", "Label")
	t.set_font_size("font_size", "AccentLabel", 26)
	t.set_color("font_color", "AccentLabel", GOLD)

	# Dano grande do HUD: a cor é trocada por código conforme o dano
	t.set_type_variation("DamageLabel", "Label")
	t.set_font("font", "DamageLabel", title)
	t.set_font_size("font_size", "DamageLabel", 88)
	t.set_color("font_outline_color", "DamageLabel", DARK_OUTLINE)
	t.set_constant("outline_size", "DamageLabel", 12)

	# Aviso central (3, 2, 1, LUTEM!)
	t.set_type_variation("BannerLabel", "Label")
	t.set_font("font", "BannerLabel", title)
	t.set_font_size("font_size", "BannerLabel", 150)
	t.set_color("font_outline_color", "BannerLabel", DARK_OUTLINE)
	t.set_constant("outline_size", "BannerLabel", 20)
