class_name HitSpark
extends Node2D
## Faísca de acerto que se lê em qualquer fundo (céu claro, lutador amarelo,
## caverna escura): brilho ADITIVO atrás, contorno escuro e núcleo claro em
## mistura NORMAL por cima. Nasce grande e encolhe (o pico do impacto é o
## primeiro quadro, não o último). Desenhada com polígonos sem suavização, para
## ficar com borda dura como o pixel art dos lutadores.

const OUTLINE := Color("2A0F12")
const GLOW_TEX := preload("res://assets/fx/circle_05.png")

## Raio das pontas compridas no primeiro quadro (px do mundo).
var radius := 34.0
## Espessura do contorno escuro (px do mundo; 2 px nativos x2).
var outline := 4.0
## Cor do núcleo e do miolo (cor do jogador, clareada).
var core := Color(1.0, 0.97, 0.85)
var accent := Color.WHITE
## Cor do brilho aditivo de trás (cor de quem bateu, clareada).
var glow := Color.WHITE
## Duração total; a escala vai de scale_from a scale_to.
var life := 0.18
var scale_from := 1.0
var scale_to := 0.3
## Pontas: compridas e curtas alternadas.
var spikes := 4

var _t := 0.0
var _spin := 0.0


func _ready() -> void:
	z_as_relative = false
	z_index = 7
	_spin = randf_range(-0.35, 0.35)
	rotation = _spin
	scale = Vector2.ONE * scale_from
	var halo := Sprite2D.new()
	halo.texture = GLOW_TEX
	halo.show_behind_parent = true
	halo.modulate = glow * Color(1, 1, 1, 0.55)
	halo.scale = Vector2.ONE * radius * 2.6 / float(GLOW_TEX.get_width())
	var mat := CanvasItemMaterial.new()
	mat.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	halo.material = mat
	add_child(halo)


func _process(delta: float) -> void:
	_t += delta
	var k := clampf(_t / life, 0.0, 1.0)
	# encolhe rápido no começo e devagar no fim
	scale = Vector2.ONE * lerpf(scale_from, scale_to, 1.0 - pow(1.0 - k, 2.0))
	modulate.a = 1.0 if k < 0.55 else 1.0 - (k - 0.55) / 0.45
	if k >= 1.0:
		queue_free()


func _draw() -> void:
	draw_colored_polygon(_star(radius + outline * 1.6, radius * 0.34 + outline), OUTLINE)
	draw_colored_polygon(_star(radius, radius * 0.34), core)
	draw_colored_polygon(_star(radius * 0.45, radius * 0.17), accent)


func _star(long: float, short: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	var n := spikes * 2
	for i in n * 2:
		var a := TAU * float(i) / float(n * 2) - PI * 0.5
		var r := short
		if i % 2 == 0:
			r = long if (i / 2) % 2 == 0 else long * 0.6   # pontas grandes e pequenas
		pts.append(Vector2(cos(a), sin(a)) * r)
	return pts
