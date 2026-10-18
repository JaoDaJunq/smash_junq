extends Node2D
## Visual de uma arena feita com arte (pixel art importada por
## tools/importar_arena.py de game/assets/arenas/<nome>/). Monta, a partir da
## pasta: o céu (camada distante), a camada do meio, o palco principal (ponta,
## meios repetidos, ponta e o corpo embaixo) e as duas plataformas pequenas.
## A geometria (colisões, bordas, plataformas) é a mesma da arena original;
## este nó só desenha. Fica na raiz da cena da arena, como "ArtArena".

@export_dir var folder := ""
## Largura do palco principal e das plataformas (iguais às colisões da cena).
@export var stage_width := 1120.0
@export var platform_width := 260.0
## Plataformas pequenas (posição do topo, em coordenadas da arena).
@export var platforms: Array[Vector2] = [Vector2(-300, -210), Vector2(300, -210)]
## Camada do meio: ampliação (pixel nativo -> mundo), quanto acompanha a câmera
## e onde fica a base da imagem (coordenadas de mundo).
@export var near_scale := 5.0
@export var near_scroll := 0.5
@export var near_bottom := 620.0
## Fundos um pouco mais escuros que a arte, para o palco e os lutadores se destacarem.
@export var sky_tint := Color(0.82, 0.82, 0.88)
@export var near_tint := Color(0.88, 0.88, 0.92)

const NATIVE := 64


func _ready() -> void:
	var meta: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(folder.path_join("arena.json")))
	var surf: Array = meta.get("superficie", [8, 8, 8, 8, 8, 8])
	var tiles: Texture2D = load(folder.path_join("palco.png"))
	_add_sky(load(folder.path_join("fundo_longe.png")))
	_add_near(load(folder.path_join("fundo_perto.png")))
	_build_stage(tiles, surf)
	for p in platforms:
		_build_platform(tiles, surf, p)


## Céu: preso à tela (cobre tudo em qualquer zoom da câmera), atrás de tudo.
func _add_sky(tex: Texture2D) -> void:
	var layer := CanvasLayer.new()
	layer.layer = -10
	add_child(layer)
	var rect := TextureRect.new()
	rect.texture = tex
	rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.modulate = sky_tint
	layer.add_child(rect)


## Camada do meio: no mundo, com parallax, repetida para os lados.
func _add_near(tex: Texture2D) -> void:
	var layer := Parallax2D.new()
	layer.scroll_scale = Vector2(near_scroll, near_scroll)
	layer.repeat_size = Vector2(tex.get_width() * near_scale, 0)
	layer.repeat_times = 4
	layer.z_index = -30
	add_child(layer)
	var s := Sprite2D.new()
	s.texture = tex
	s.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	s.scale = Vector2(near_scale, near_scale)
	s.position = Vector2(0, near_bottom - tex.get_height() * near_scale * 0.5)
	s.modulate = near_tint
	layer.add_child(s)


func _tile(tiles: Texture2D, index: int, pos: Vector2, k: float, flip := false) -> void:
	var s := Sprite2D.new()
	s.texture = tiles
	s.region_enabled = true
	s.region_rect = Rect2(index * NATIVE, 0, NATIVE, NATIVE)
	s.centered = false
	s.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	s.scale = Vector2(k, k)
	s.flip_h = flip
	s.position = pos
	s.z_index = -5
	add_child(s)


## Palco principal: ponta, meios, ponta; o topo de cada bloco (sua linha de
## superfície) fica em y = 0. Os blocos já trazem a parte de baixo (raízes,
## pedra); o bloco 4 fica de reserva para palcos mais altos.
func _build_stage(tiles: Texture2D, surf: Array) -> void:
	var count := maxi(3, roundi(stage_width / (NATIVE * 2.0)))
	var k := stage_width / (count * NATIVE)
	var x0 := -stage_width * 0.5
	for i in count:
		var idx := 1
		if i == 0:
			idx = 0
		elif i == count - 1:
			idx = 2
		var x := x0 + i * NATIVE * k
		_tile(tiles, idx, Vector2(x, -float(surf[idx]) * k), k)


func _build_platform(tiles: Texture2D, surf: Array, top: Vector2) -> void:
	var k := platform_width / (2.0 * NATIVE)
	var x0 := top.x - platform_width * 0.5
	_tile(tiles, 4, Vector2(x0, top.y - float(surf[4]) * k), k)
	_tile(tiles, 5, Vector2(x0 + NATIVE * k, top.y - float(surf[5]) * k), k)
