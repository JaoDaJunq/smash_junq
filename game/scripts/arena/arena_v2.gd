extends Node2D
## Arena montada a partir de um formato (LAYOUTS) e da arte importada por
## tools/importar_arena.py (game/assets/arenas/<nome>/). Cria o cenário pintado
## ao fundo, os blocos de terreno (quebra-cabeça de 9 partes) com as colisões e
## as bordas, as plataformas finas (atravessáveis por baixo) e as que se movem.
## Fica na raiz da cena da arena como "ArtArena"; a cena só tem os pontos de
## entrada (SpawnP1/SpawnP2).
##
## Terreno: a fileira de cima usa os blocos (cantos e meio); embaixo, a ilha
## afina como um triângulo de cabeça para baixo, preenchida com o miolo.
## Unidade: 1 bloco = 64 pixels de arte x 2 = 128 de mundo (mesma escala dos
## lutadores). y = 0 é o topo do palco principal; y cresce para baixo.

const NATIVE := 64
const K := 2.0
const TILE := NATIVE * K
const LAYER_STAGE := 1
const LAYER_PLATFORM := 2

## Formatos. solids: retângulos de terreno (x da esquerda, y do topo, largura e
## altura em blocos); o primeiro é o palco principal. ledges: cantos que dá para
## agarrar ("l", "r"). soft: plataformas finas [centro, y do topo]. moving: finas
## que se movem [centro, y do topo, deslocamento, período em s, fase 0..1].
## decor: enfeites [x, índice 0..2] em cima do palco principal.
const LAYOUTS := {
	"pantanal": {
		"desc": "Uma ilha de barro no meio da lagoa e duas vitórias-régias que sobem e descem dos lados: boas para voltar, ruins para ficar parado.",
		"solids": [{"x": -448.0, "y": 0.0, "w": 7, "h": 2, "ledges": ["l", "r"]}],
		"soft": [[0.0, -330.0]],
		"moving": [[-600.0, -150.0, Vector2(0, -110), 5.0, 0.0], [600.0, -150.0, Vector2(0, -110), 5.0, 0.5]],
		"decor": [[-320.0, 0], [250.0, 1], [380.0, 2]],
	},
	"caatinga": {
		"desc": "Chão largo com uma laje de pedra alta do lado esquerdo e tábuas em alturas diferentes: mapa torto, bom para quem gosta de pular por cima.",
		"solids": [
			{"x": -640.0, "y": 0.0, "w": 10, "h": 2, "ledges": ["r"]},
			{"x": -640.0, "y": -128.0, "w": 3, "h": 1, "ledges": ["l"], "on_top_of_main": true},
		],
		"soft": [[320.0, -230.0], [-450.0, -380.0]],
		"moving": [],
		"decor": [[-180.0, 0], [200.0, 1], [520.0, 2]],
	},
	"cerrado": {
		"desc": "Palco compacto e alto, duas ilhas de terra mais baixas dos lados e três galhos de ipê em triângulo: muito vão para jogar o adversário fora.",
		"solids": [
			{"x": -384.0, "y": 0.0, "w": 6, "h": 3, "ledges": ["l", "r"]},
			{"x": -896.0, "y": 140.0, "w": 2, "h": 2, "ledges": ["l", "r"]},
			{"x": 640.0, "y": 140.0, "w": 2, "h": 2, "ledges": ["l", "r"]},
		],
		"soft": [[-300.0, -210.0], [300.0, -210.0], [0.0, -410.0]],
		"moving": [],
		"decor": [[-250.0, 0], [120.0, 2], [-760.0, 1]],
	},
}

@export var arena := ""
@export_dir var folder := ""
## Cenário um pouco mais escuro que a pintura, para palco e lutadores se destacarem.
@export var sky_tint := Color(0.9, 0.9, 0.95)

var _blocks: Texture2D
var _core: Texture2D
var _outline := Color("2a1a10")
var _platforms: Texture2D
var _surf := 8
var _plat_surf: Array = [8, 8]
var _movers: Array[Dictionary] = []
var _time := 0.0


func _ready() -> void:
	var meta: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(folder.path_join("arena.json")))
	_surf = int(meta.get("superficie_blocos", 8))
	var plat: Array = meta.get("superficie", [8, 8, 8, 8, 8, 8])
	_plat_surf = [plat[4], plat[5]]
	_blocks = load(folder.path_join("blocos.png"))
	_core = load(folder.path_join("miolo.png"))
	_outline = Color(String(meta.get("contorno", "#2a1a10")))
	_platforms = load(folder.path_join("palco.png"))
	_add_sky(load(folder.path_join("fundo.png")))
	var layout: Dictionary = LAYOUTS[arena]
	for s in layout["solids"]:
		_build_solid(s)
	for p in layout["soft"]:
		_build_soft(Vector2(p[0], p[1]))
	for m in layout["moving"]:
		_build_moving(Vector2(m[0], m[1]), m[2], m[3], m[4])
	for d in layout["decor"]:
		_decor(float(d[0]), int(d[1]))


func _physics_process(delta: float) -> void:
	_time += delta
	for m in _movers:
		var t: float = sin((_time / m["period"] + m["phase"]) * TAU) * 0.5 + 0.5
		(m["body"] as AnimatableBody2D).position = m["from"] + m["offset"] * t


# --- Cenário ---

func _add_sky(tex: Texture2D) -> void:
	var layer := CanvasLayer.new()
	layer.layer = -10
	add_child(layer)
	var rect := TextureRect.new()
	rect.texture = tex
	rect.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.modulate = sky_tint
	layer.add_child(rect)


# --- Terreno ---

## Bloco i da tira blocos.png: 0-2 cima (esq, meio, dir), 3-5 corpo (esq, miolo,
## dir), 6-8 baixo (esq, meio, dir), 9-11 enfeites.
func _tile(parent: Node2D, tex: Texture2D, i: int, pos: Vector2, z := -5) -> void:
	var s := Sprite2D.new()
	s.texture = tex
	s.region_enabled = true
	s.region_rect = Rect2(i * NATIVE, 0, NATIVE, NATIVE)
	s.centered = false
	s.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	s.scale = Vector2(K, K)
	s.position = pos
	s.z_index = z
	parent.add_child(s)


func _build_solid(s: Dictionary) -> void:
	var w: int = s["w"]
	var h: int = s["h"]
	var on_main: bool = s.get("on_top_of_main", false)
	var top := Vector2(s["x"], s["y"])
	if on_main:
		# Laje em cima do palco: uma fileira só, com o fim do bloco encostado no chão.
		top.y = -(NATIVE - _surf) * K
	var width := w * TILE
	var y0 := top.y - _surf * K   # a linha da superfície do bloco fica no topo
	var yb := y0 + TILE           # fim da fileira de cima
	var body := StaticBody2D.new()
	body.collision_layer = LAYER_STAGE
	body.collision_mask = 0
	body.name = "Terreno%d" % get_child_count()
	add_child(body)
	# Fileira de cima (superfície, cantos com contorno)
	for col in w:
		_tile(self, _blocks, _kind(col, w), Vector2(top.x + col * TILE, y0))
	var shape := CollisionPolygon2D.new()
	if on_main:
		# Preenche de trás da fileira até o chão: a laje fica grudada no palco.
		var x0 := top.x + 2.0 * K
		var x1 := top.x + width - 2.0 * K
		var fill_l := Polygon2D.new()
		fill_l.polygon = PackedVector2Array([Vector2(x0, yb - TILE * 0.45), Vector2(x1, yb - TILE * 0.45), Vector2(x1, 6.0), Vector2(x0, 6.0)])
		fill_l.texture = _core
		fill_l.texture_scale = Vector2(1.0 / K, 1.0 / K)
		fill_l.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		fill_l.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		fill_l.z_index = -6
		add_child(fill_l)
		for xe in [x0, x1]:
			var edge_l := Line2D.new()
			edge_l.points = PackedVector2Array([Vector2(xe, yb - TILE * 0.45), Vector2(xe, 4.0)])
			edge_l.width = 2.0 * K
			edge_l.default_color = _outline
			edge_l.z_index = -5
			add_child(edge_l)
		shape.polygon = PackedVector2Array([top, top + Vector2(width, 0), top + Vector2(width, -top.y), Vector2(top.x, 0)])
	else:
		# Embaixo: ilha afinando para baixo como a arena original (curva funda no
		# meio, rasa nas pontas, borda irregular), em degraus de pixel.
		var under := yb - TILE * 0.45  # começa por trás da fileira de cima: sem fresta
		var poly := _island_outline(top.x, width, under, s.get("seed", int(top.x)))
		var fill := Polygon2D.new()
		fill.polygon = poly
		fill.texture = _core
		fill.texture_scale = Vector2(1.0 / K, 1.0 / K)
		fill.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		fill.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		fill.z_index = -6
		add_child(fill)
		var shade := Polygon2D.new()
		shade.polygon = poly
		var cols := PackedColorArray()
		var deepest := 1.0
		for v in poly:
			deepest = maxf(deepest, v.y - under)
		for v in poly:
			cols.append(Color(0, 0, 0, 0.5 * clampf((v.y - under) / deepest, 0.0, 1.0)))
		shade.vertex_colors = cols
		shade.z_index = -6
		add_child(shade)
		var line := Line2D.new()
		var edge := poly.slice(1)  # sem o lado de cima (escondido atrás da fileira)
		line.points = edge
		line.width = 2.0 * K
		line.default_color = _outline
		line.joint_mode = Line2D.LINE_JOINT_SHARP
		line.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		line.z_index = -5
		add_child(line)
		var col_pts := PackedVector2Array([top, top + Vector2(width, 0)])
		for i in range(poly.size() - 1, 0, -1):
			col_pts.append(poly[i])
		shape.polygon = col_pts
	body.add_child(shape)
	for side in s.get("ledges", []):
		var m := Marker2D.new()
		m.add_to_group("ledges")
		var sign := -1 if side == "l" else 1
		m.set_meta("side", sign)
		m.position = Vector2(top.x if side == "l" else top.x + width, top.y)
		m.name = "Borda%s%d" % [side.to_upper(), get_child_count()]
		add_child(m)


## Contorno da parte de baixo de uma ilha: começa no canto esquerdo de cima,
## desce em curva (funda no meio, rasa nas pontas, com bicos irregulares) e
## sobe até o canto direito. Pontos em degraus de 4 pixels de arte.
func _island_outline(x0: float, width: float, y: float, seed: int) -> PackedVector2Array:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed
	var depth := clampf(width * 0.26, TILE * 0.9, TILE * 2.2)
	var step := 4.0 * K
	var pts := PackedVector2Array([Vector2(x0 + 2.0 * K, y)])
	var n := maxi(8, int(width / (TILE * 0.5)))
	for k in n + 1:
		var t := -1.0 + 2.0 * float(k) / float(n)
		var prof := pow(1.0 - absf(t), 0.7)
		var d := (step + (depth - step) * prof)
		if k % 3 == 0 and prof > 0.2:
			d *= rng.randf_range(1.05, 1.18)
		else:
			d *= rng.randf_range(0.85, 0.97)
		var px := x0 + width * 0.5 + t * (width * 0.5 - 2.0 * K)
		pts.append(Vector2(snappedf(px, step), y + snappedf(d, step)))
	pts.append(Vector2(x0 + width - 2.0 * K, y))
	return pts


## 0 = canto esquerdo, 1 = meio, 2 = canto direito.
func _kind(col: int, w: int) -> int:
	if col == 0:
		return 0
	if col == w - 1:
		return 2
	return 1


# --- Plataformas finas ---

func _platform_art(parent: Node2D, center_x: float) -> void:
	var x0 := center_x - TILE
	_tile(parent, _platforms, 4, Vector2(x0, -float(_plat_surf[0]) * K), -4)
	_tile(parent, _platforms, 5, Vector2(x0 + TILE, -float(_plat_surf[1]) * K), -4)


func _platform_shape() -> CollisionShape2D:
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(2 * TILE, 16)
	shape.shape = rect
	shape.position = Vector2(0, 8)
	shape.one_way_collision = true
	return shape


func _build_soft(top: Vector2) -> void:
	var body := StaticBody2D.new()
	body.collision_layer = LAYER_PLATFORM
	body.collision_mask = 0
	body.position = top
	add_child(body)
	body.add_child(_platform_shape())
	_platform_art(body, 0.0)


func _build_moving(top: Vector2, offset: Vector2, period: float, phase: float) -> void:
	var body := AnimatableBody2D.new()
	body.collision_layer = LAYER_PLATFORM
	body.collision_mask = 0
	body.sync_to_physics = true
	body.position = top
	add_child(body)
	body.add_child(_platform_shape())
	_platform_art(body, 0.0)
	_movers.append({"body": body, "from": top, "offset": offset, "period": period, "phase": phase})


## Topo (y da superfície) do terreno que cobre a posição x; NAN se não houver.
func surface_y(x: float) -> float:
	var best := NAN
	for s in LAYOUTS[arena]["solids"]:
		var x0: float = s["x"]
		var y: float = s["y"]
		if s.get("on_top_of_main", false):
			y = -(NATIVE - _surf) * K
		if x >= x0 and x <= x0 + s["w"] * TILE and (is_nan(best) or y < best):
			best = y
	return best


func _decor(x: float, i: int) -> void:
	# Apoia no terreno que estiver embaixo (o importador encosta o desenho na
	# última linha do bloco). Sem terreno embaixo, não desenha.
	var y := surface_y(x)
	if is_nan(y):
		push_warning("enfeite fora do terreno em x=%s" % x)
		return
	_tile(self, _blocks, 9 + i, Vector2(x - TILE * 0.5, y - TILE + K), -3)
	var last := get_child(get_child_count() - 1)
	last.add_to_group("decor")
	last.set_meta("floor_y", y)
