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
		"solids": [{"x": -448.0, "y": 0.0, "w": 7, "h": 2, "ledges": ["l", "r"], "shape": "tigela", "seed": 11}],
		"soft": [[0.0, -330.0]],
		"moving": [[-600.0, -150.0, Vector2(0, -110), 5.0, 0.0], [600.0, -150.0, Vector2(0, -110), 5.0, 0.5]],
		"decor": [[-320.0, 0], [250.0, 1], [380.0, 2]],
	},
	"caatinga": {
		"desc": "Chão largo com uma laje de pedra alta do lado esquerdo e tábuas em alturas diferentes: mapa torto, bom para quem gosta de pular por cima.",
		"solids": [
			{"x": -640.0, "y": 0.0, "w": 10, "h": 2, "ledges": ["r"], "shape": "torta", "seed": 7},
			{"x": -640.0, "y": -128.0, "w": 3, "h": 1, "ledges": ["l"], "on_top_of_main": true},
		],
		"soft": [[320.0, -230.0], [-450.0, -380.0]],
		"moving": [],
		"decor": [[-180.0, 0], [200.0, 1], [520.0, 2]],
	},
	"cerrado": {
		"desc": "Palco compacto e alto, duas ilhas de terra mais baixas dos lados e três galhos de ipê em triângulo: muito vão para jogar o adversário fora.",
		"solids": [
			{"x": -384.0, "y": 0.0, "w": 6, "h": 3, "ledges": ["l", "r"], "shape": "v", "seed": 3},
			{"x": -896.0, "y": 140.0, "w": 2, "h": 2, "ledges": ["l", "r"], "shape": "degraus", "seed": 21},
			{"x": 640.0, "y": 140.0, "w": 2, "h": 2, "ledges": ["l", "r"], "shape": "torta_e", "seed": 5},
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
	var on_main: bool = s.get("on_top_of_main", false)
	var top := Vector2(s["x"], s["y"])
	if on_main:
		top.y = -float(s.get("h_px", 120.0))
	var width := w * TILE
	var body := StaticBody2D.new()
	body.collision_layer = LAYER_STAGE
	body.collision_mask = 0
	body.name = "Terreno%d" % get_child_count()
	add_child(body)
	# Uma peça só: o contorno vai da superfície, desce pelos lados e fecha embaixo.
	var poly: PackedVector2Array
	if on_main:
		# Laje em cima do palco: paredes retas até o chão (some atrás da grama dele).
		poly = PackedVector2Array([top, Vector2(top.x, 10.0), Vector2(top.x + width, 10.0), top + Vector2(width, 0)])
	else:
		poly = _island_outline(top.x, width, top.y, String(s.get("shape", "v")), int(s.get("seed", int(top.x))))
	var z_fill := -3 if on_main else -6
	var fill := Polygon2D.new()
	fill.polygon = poly
	fill.texture = _core
	fill.texture_scale = Vector2(1.0 / K, 1.0 / K)
	fill.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	fill.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	fill.z_index = z_fill
	add_child(fill)
	if not on_main:
		var shade := Polygon2D.new()
		shade.polygon = poly
		var deepest := 1.0
		for v in poly:
			deepest = maxf(deepest, v.y - top.y)
		var cols := PackedColorArray()
		for v in poly:
			cols.append(Color(0, 0, 0, 0.5 * clampf((v.y - top.y - TILE * 0.3) / deepest, 0.0, 1.0)))
		shade.vertex_colors = cols
		shade.z_index = z_fill
		add_child(shade)
	# Contorno: lados e fundo (o lado de cima fica sob a faixa de grama). Na laje,
	# só as duas paredes, até o chão.
	var edges: Array[PackedVector2Array] = [poly]
	if on_main:
		edges = [PackedVector2Array([poly[0], Vector2(top.x, 0)]), PackedVector2Array([poly[3], Vector2(top.x + width, 0)])]
	for e in edges:
		var line := Line2D.new()
		line.points = e
		line.width = 2.0 * K
		line.default_color = _outline
		line.joint_mode = Line2D.LINE_JOINT_SHARP
		line.z_index = z_fill + 1
		add_child(line)
	_top_strip(top, width, z_fill + 1)
	body.add_child(_collision(poly))
	for side in s.get("ledges", []):
		var m := Marker2D.new()
		m.add_to_group("ledges")
		var sign := -1 if side == "l" else 1
		m.set_meta("side", sign)
		m.position = Vector2(top.x if side == "l" else top.x + width, top.y)
		m.name = "Borda%s%d" % [side.to_upper(), get_child_count()]
		add_child(m)


func _collision(poly: PackedVector2Array) -> CollisionPolygon2D:
	var c := CollisionPolygon2D.new()
	c.polygon = poly
	return c


## Faixa da superfície (grama, beirada) por cima da peça: só a parte de cima do
## bloco do meio, repetida e cortada reto nas pontas (sem os cantos redondos).
func _top_strip(top: Vector2, width: float, z: int) -> void:
	var rows := _surf + 7
	var x := 0.0
	# Onde há uma laje em cima, a faixa do chão não aparece (a laje é a mesma peça).
	for o in LAYOUTS[arena]["solids"]:
		if o.get("on_top_of_main", false) and absf(float(o["x"]) - top.x) < 1.0 and top.y > -1.0:
			x = float(o["w"]) * TILE
	while x < width - 0.5:
		var piece := minf(TILE, width - x)
		var sp := Sprite2D.new()
		sp.texture = _blocks
		sp.region_enabled = true
		sp.region_rect = Rect2(NATIVE, 0, piece / K, rows)
		sp.centered = false
		sp.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		sp.scale = Vector2(K, K)
		sp.position = Vector2(top.x + x, top.y - _surf * K)
		sp.z_index = z
		add_child(sp)
		x += piece


## Contorno de uma ilha (uma peça só): canto de cima esquerdo, parede curta,
## fundo com o formato pedido, parede curta e canto de cima direito.
## Formatos: "v" (fundo no meio), "tigela" (redonda), "torta" (funda para a
## direita), "torta_e" (para a esquerda), "degraus" (blocos de pedra).
func _island_outline(x0: float, width: float, y: float, shape: String, seed: int) -> PackedVector2Array:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed
	var step := 4.0 * K
	var depth := clampf(width * 0.42, TILE * 1.4, TILE * 2.4)
	var wall_l := snappedf(TILE * rng.randf_range(0.35, 0.6), step)
	var wall_r := snappedf(TILE * rng.randf_range(0.35, 0.6), step)
	var pts := PackedVector2Array([Vector2(x0, y), Vector2(x0, y + wall_l)])
	var n := maxi(7, int(width / (TILE * 0.45)))
	var steps_h := 0.0
	for k in range(1, n):
		var t := float(k) / float(n)
		var f := 0.0
		match shape:
			"tigela":
				f = sqrt(maxf(0.0, 1.0 - pow(2.0 * t - 1.0, 2.0)))
			"torta":
				f = t / 0.68 if t < 0.68 else (1.0 - t) / 0.32
			"torta_e":
				f = t / 0.32 if t < 0.32 else (1.0 - t) / 0.68
			"degraus":
				if k % 2 == 1:
					steps_h = sqrt(maxf(0.0, 1.0 - pow(2.0 * t - 1.0, 2.0))) * rng.randf_range(0.75, 1.05)
				f = steps_h
			_:
				f = 1.0 - absf(2.0 * t - 1.0)
		f = clampf(f, 0.0, 1.0)
		var wall := lerpf(wall_l, wall_r, t)
		var d := wall + (depth - wall) * pow(f, 0.85)
		if shape != "degraus":
			d *= rng.randf_range(0.88, 1.08) if k % 2 == 0 else rng.randf_range(0.95, 1.12)
		var px := x0 + width * t + (rng.randf_range(-0.2, 0.2) * TILE * 0.45 if shape != "degraus" else 0.0)
		pts.append(Vector2(snappedf(px, step), y + snappedf(maxf(d, wall * 0.8), step)))
	pts.append(Vector2(x0 + width, y + wall_r))
	pts.append(Vector2(x0 + width, y))
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
			y = -float(s.get("h_px", 120.0))
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
	_tile(self, _blocks, 9 + i, Vector2(x - TILE * 0.5, y - TILE + K), -1)
	var last := get_child(get_child_count() - 1)
	last.add_to_group("decor")
	last.set_meta("floor_y", y)
