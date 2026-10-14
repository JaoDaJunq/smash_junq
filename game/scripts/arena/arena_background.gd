extends Node2D
## Fundo da arena: céu de entardecer, sol, estrelas, montanhas e ilhas distantes e nuvens
## em camadas Parallax2D. Tudo procedural. Cores no topo para facilitar o ajuste.

const Util := preload("res://scripts/arena/arena_util.gd")
const Silhouette := preload("res://scripts/arena/silhouette_layer.gd")
const Stars := preload("res://scripts/arena/arena_stars.gd")
const CLOUD_TEXTURES: Array[Texture2D] = [
	preload("res://assets/fx/smoke_04.png"),
	preload("res://assets/fx/smoke_07.png"),
]

# --- Céu (degradê fixo em coordenadas de mundo, do alto até abaixo do horizonte) ---
const SKY_TOP_Y := -2400.0
const SKY_BOTTOM_Y := 450.0
const SKY_STOPS: Array[float] = [0.0, 0.3, 0.55, 0.72, 0.84, 0.92, 1.0]
const SKY_COLORS: Array[Color] = [
	Color("0a0e2b"), Color("1b1a4e"), Color("372566"), Color("63397f"),
	Color("a24d7e"), Color("e0806f"), Color("f4b07c"),
]
# --- Sol e brilhos ---
const SUN_POS := Vector2(560.0, -10.0)
const COLOR_SUN_DISC := Color("ffd9a6")
const COLOR_SUN_GLOW := Color(1.0, 0.55, 0.35, 0.5)
const COLOR_SUN_HALO := Color(0.9, 0.35, 0.6, 0.28)
# --- Silhuetas (topo, neblina na base, luz de borda) ---
const COLOR_MTN_FAR := Color("7a4c88")
const FOG_MTN_FAR := Color("8a5588")
const COLOR_MTN_MID := Color("4d3270")
const FOG_MTN_MID := Color("5e3b78")
const COLOR_MTN_NEAR := Color("2b2352")
const FOG_MTN_NEAR := Color("3a2a62")
const COLOR_ISL_FAR := Color("6c4a8c")
const FOG_ISL_FAR := Color("6a4a88")
const COLOR_ISL_MID := Color("46306c")
const FOG_ISL_MID := Color("3b2a60")
const COLOR_ISL_NEAR := Color("2a2352")
const FOG_ISL_NEAR := Color("20204a")
const COLOR_RIM := Color(1.0, 0.72, 0.5, 0.45)
const COLOR_WINDOW := Color(1.0, 0.75, 0.42, 0.8)
# --- Nuvens ---
const COLOR_CLOUD_HIGH := Color(0.95, 0.55, 0.7, 0.22)
const COLOR_CLOUD_MID := Color(0.85, 0.5, 0.65, 0.2)
const COLOR_MIST_LOW := Color(0.45, 0.35, 0.65, 0.22)

var _sky_bg: ColorRect
var _sky_tex: TextureRect
var _sky_bottom: ColorRect
var _bottom_color := SKY_COLORS[SKY_COLORS.size() - 1]
var _layers: Array[Parallax2D] = []
var _scrolls := PackedFloat32Array()

## Centro da câmera numa luta típica; as camadas são desenhadas para esse enquadramento.
const NOMINAL_CENTER := Vector2(0.0, -150.0)


func _ready() -> void:
	_build_sky()
	# Da camada mais distante para a mais próxima (ordem de desenho).
	_add_layer(0.02, _make_stars())
	_add_layer(0.05, _make_sun())
	_add_clouds(0.08, 3600.0, 7, Vector2(-520.0, -80.0), Vector2(1100.0, 1500.0), 0.5, COLOR_CLOUD_HIGH, -7.0, 21)
	_add_layer(0.1, _make_mountains(0.1, 11, 130.0, 300.0, COLOR_MTN_FAR, FOG_MTN_FAR, true))
	_add_layer(0.2, _make_islands(0.2, 31, 9, Vector2(-760.0, -250.0), Vector2(150.0, 300.0), COLOR_ISL_FAR, FOG_ISL_FAR, false, Vector2(-500.0, 500.0)))
	_add_clouds(0.22, 3600.0, 6, Vector2(-300.0, 120.0), Vector2(900.0, 1300.0), 0.45, COLOR_CLOUD_MID, -12.0, 22)
	_add_layer(0.3, _make_mountains(0.3, 12, 190.0, 260.0, COLOR_MTN_MID, FOG_MTN_MID, true))
	_add_layer(0.42, _make_islands(0.42, 41, 7, Vector2(-620.0, -180.0), Vector2(220.0, 420.0), COLOR_ISL_MID, FOG_ISL_MID, true, Vector2(-650.0, 650.0)))
	_add_clouds(0.5, 4000.0, 5, Vector2(120.0, 330.0), Vector2(1300.0, 1800.0), 0.35, COLOR_MIST_LOW, -18.0, 23)
	_add_layer(0.62, _make_mountains(0.62, 13, 330.0, 190.0, COLOR_MTN_NEAR, FOG_MTN_NEAR, false))
	_add_layer(0.7, _make_islands(0.7, 51, 5, Vector2(-520.0, -80.0), Vector2(300.0, 560.0), COLOR_ISL_NEAR, FOG_ISL_NEAR, false, Vector2(-1000.0, 1000.0)))


func _process(_delta: float) -> void:
	_update_sky()
	_update_layers()


# --- Céu: texto de degradê esticado conforme a câmera, ancorado ao mundo ---
func _build_sky() -> void:
	var layer := CanvasLayer.new()
	layer.layer = -50
	layer.name = "SkyLayer"
	add_child(layer)
	_sky_bg = ColorRect.new()
	_sky_bg.color = SKY_COLORS[0]
	_sky_bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(_sky_bg)
	var grad := Gradient.new()
	grad.offsets = PackedFloat32Array(SKY_STOPS)
	grad.colors = PackedColorArray(SKY_COLORS)
	var gt := GradientTexture2D.new()
	gt.gradient = grad
	gt.fill_from = Vector2(0, 0)
	gt.fill_to = Vector2(0, 1)
	gt.width = 4
	gt.height = 512
	_sky_tex = TextureRect.new()
	_sky_tex.texture = gt
	_sky_tex.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_sky_tex.stretch_mode = TextureRect.STRETCH_SCALE
	layer.add_child(_sky_tex)
	_sky_bottom = ColorRect.new()
	_sky_bottom.color = _bottom_color
	layer.add_child(_sky_bottom)
	_update_sky()


func _update_sky() -> void:
	var ct := get_viewport().get_canvas_transform()
	var sy := ct.y.y
	var view := get_viewport_rect().size
	var top := ct.origin.y + SKY_TOP_Y * sy
	var bottom := ct.origin.y + SKY_BOTTOM_Y * sy
	_sky_tex.position = Vector2(0.0, top)
	_sky_tex.size = Vector2(view.x, bottom - top)
	_sky_bottom.position = Vector2(0.0, bottom - 1.0)
	_sky_bottom.size = Vector2(view.x, 6000.0)


# --- Camadas ---
## Cada camada é um Parallax2D (cuida de repetição e autoscroll), mas o deslocamento pela
## câmera é calculado aqui, em coordenadas de mundo, para ficar correto em qualquer zoom.
func _add_layer(scroll: float, content: Node) -> Parallax2D:
	var p := Parallax2D.new()
	p.scroll_scale = Vector2(scroll, scroll)
	p.ignore_camera_scroll = true
	p.add_child(content)
	add_child(p)
	_layers.append(p)
	_scrolls.append(scroll)
	return p


func _update_layers() -> void:
	var ct := get_viewport().get_canvas_transform()
	var center := ct.affine_inverse() * (get_viewport_rect().size * 0.5)
	var delta_cam := center - NOMINAL_CENTER
	for i in _layers.size():
		_layers[i].position = delta_cam * (1.0 - _scrolls[i])


func _make_stars() -> Node2D:
	var s := Stars.new()
	return s


func _make_sun() -> Node2D:
	var root := Node2D.new()
	root.position = SUN_POS
	root.add_child(Util.glow_sprite(Vector2(3600, 2600), COLOR_SUN_HALO))
	root.add_child(Util.glow_sprite(Vector2(1700, 1500), COLOR_SUN_GLOW))
	root.add_child(Util.glow_sprite(Vector2(520, 520), Color(1.0, 0.8, 0.55, 0.9)))
	var disc := SunDisc.new()
	root.add_child(disc)
	return root


func _make_mountains(scroll: float, sd: int, base: float, amp: float, top: Color, fog: Color, rim: bool) -> Node2D:
	var l := Silhouette.new()
	l.kind = Silhouette.Kind.MOUNTAINS
	l.rng_seed = sd
	l.base_y = base
	l.amplitude = amp
	l.top_color = top
	l.bottom_color = fog
	if rim:
		l.rim_color = COLOR_RIM
	return l


func _make_islands(scroll: float, sd: int, count: int, y_range: Vector2, w_range: Vector2, top: Color, fog: Color, windows: bool, clear: Vector2) -> Node2D:
	var l := Silhouette.new()
	l.kind = Silhouette.Kind.ISLANDS
	l.rng_seed = sd
	l.island_count = count
	l.island_y_range = y_range
	l.island_width_range = w_range
	l.top_color = top
	l.bottom_color = fog
	l.rim_color = COLOR_RIM if scroll < 0.6 else Color(1.0, 0.6, 0.5, 0.25)
	if windows:
		l.window_color = COLOR_WINDOW
	l.clear_x = clear
	return l


## Nuvens que derivam devagar (autoscroll) e repetem na horizontal.
func _add_clouds(scroll: float, repeat_w: float, count: int, y_range: Vector2, w_range: Vector2, squash: float, color: Color, speed: float, sd: int) -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = sd
	var root := Node2D.new()
	for i in count:
		var s := Sprite2D.new()
		s.texture = CLOUD_TEXTURES[rng.randi() % CLOUD_TEXTURES.size()]
		var w := rng.randf_range(w_range.x, w_range.y)
		var tex_w := float(s.texture.get_width())
		s.scale = Vector2(w / tex_w, w / tex_w * squash)
		s.position = Vector2(repeat_w * (float(i) + rng.randf_range(0.1, 0.9)) / float(count), rng.randf_range(y_range.x, y_range.y))
		s.flip_h = rng.randf() < 0.5
		var c := color
		c.a *= rng.randf_range(0.7, 1.15)
		s.modulate = c
		root.add_child(s)
	var p := _add_layer(scroll, root)
	p.repeat_size = Vector2(repeat_w, 0.0)
	p.repeat_times = 3
	p.autoscroll = Vector2(speed, 0.0)


## Disco do sol (círculo sólido), desenhado em _draw.
class SunDisc extends Node2D:
	func _draw() -> void:
		draw_circle(Vector2.ZERO, 86.0, Color(1.0, 0.86, 0.62, 0.95))
		draw_circle(Vector2.ZERO, 64.0, Color(1.0, 0.93, 0.78, 1.0))
