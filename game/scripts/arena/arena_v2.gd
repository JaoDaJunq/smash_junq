extends Node2D
## Arena montada a partir de um formato (LAYOUTS) e da arte importada por
## tools/importar_arena.py (game/assets/arenas/<nome>/). Cria o cenário pintado
## ao fundo, os blocos de terreno (quebra-cabeça de 9 partes) com as colisões e
## as bordas, as plataformas finas (atravessáveis por baixo) e as que se movem.
## Fica na raiz da cena da arena como "ArtArena"; a cena só tem os pontos de
## entrada (SpawnP1/SpawnP2).
##
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
	var top := Vector2(s["x"], s["y"])
	var body := StaticBody2D.new()
	body.collision_layer = LAYER_STAGE
	body.collision_mask = 0
	body.name = "Terreno%d" % get_child_count()
	add_child(body)
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(w * TILE, h * TILE)
	shape.shape = rect
	shape.position = top + rect.size * 0.5
	body.add_child(shape)
	var y0 := top.y - _surf * K   # a linha da superfície do bloco fica no topo
	for row in h:
		for col in w:
			var kind := 1
			if col == 0:
				kind = 0
			elif col == w - 1:
				kind = 2
			var base := 0 if row == 0 else 3
			_tile(self, _blocks, base + kind, Vector2(top.x + col * TILE, y0 + row * TILE))
	# Em cima do palco: o corpo desce mais uma fileira, por cima do chão, para a
	# laje não parecer solta.
	if s.get("on_top_of_main", false):
		for col in w:
			var kind := 1
			if col == 0:
				kind = 0
			elif col == w - 1:
				kind = 2
			_tile(self, _blocks, 3 + kind, Vector2(top.x + col * TILE, y0 + h * TILE))
	# parte de baixo (raízes, pedras penduradas), sem colisão
	if not s.get("on_top_of_main", false):
		for col in w:
			var kind := 1
			if col == 0:
				kind = 0
			elif col == w - 1:
				kind = 2
			_tile(self, _blocks, 6 + kind, Vector2(top.x + col * TILE, y0 + h * TILE))
	for side in s.get("ledges", []):
		var m := Marker2D.new()
		m.add_to_group("ledges")
		var sign := -1 if side == "l" else 1
		m.set_meta("side", sign)
		m.position = Vector2(top.x if side == "l" else top.x + w * TILE, top.y)
		m.name = "Borda%s%d" % [side.to_upper(), get_child_count()]
		add_child(m)


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


func _decor(x: float, i: int) -> void:
	# enfeite apoiado na superfície do palco principal (atrás dos lutadores)
	_tile(self, _blocks, 9 + i, Vector2(x - TILE * 0.5, -TILE + 1.0), -3)
