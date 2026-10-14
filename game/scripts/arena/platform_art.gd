extends Node2D
## Arte das plataformas flutuantes: versão fina do estilo do palco, com brilho suave
## embaixo. Topo em y=0, colisão de y=0 a y=16, largura 260 (mesma da colisão).

const Util := preload("res://scripts/arena/arena_util.gd")
const Pulse := preload("res://scripts/arena/glow_pulse.gd")

@export var width := 260.0
@export var rng_seed := 5
@export var pulse_phase := 0.0

# --- Cores ---
const COLOR_RIM := Color("fff4e0")
const COLOR_TOP_A := Color("e6edff")
const COLOR_TOP_B := Color("aab7d8")
const COLOR_FACE_A := Color("5f6d98")
const COLOR_FACE_B := Color("353e66")
const COLOR_SEAM := Color(0.1, 0.12, 0.24, 0.6)
const COLOR_ROCK_A := Color("39427a")
const COLOR_ROCK_B := Color("1a1e3f")
const COLOR_CRYSTAL := Color("7ff5e6")
const COLOR_GLOW := Color(0.3, 0.85, 0.95, 0.4)
const COLOR_ACCENT := Color(0.35, 0.95, 0.9, 0.8)

const TOP_H := 5.0
const BODY_H := 16.0
const ROCK_DEPTH := 26.0

var _tips := PackedVector2Array()
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	var half := width * 0.5
	# Brilho suave embaixo da plataforma (atrás da arte).
	var glow := Util.glow_sprite(Vector2(width * 1.5, 120.0), COLOR_GLOW)
	glow.position = Vector2(0.0, BODY_H + 18.0)
	var holder := Node2D.new()
	holder.show_behind_parent = true
	holder.add_child(glow)
	add_child(holder)
	var p := Pulse.new()
	p.speed = 0.09
	p.min_alpha = 0.55
	p.phase = pulse_phase
	holder.add_child(p)
	# Pontinhos de luz nas emendas (aditivos).
	var dots := Dots.new()
	dots.half = half
	add_child(dots)
	var p2 := Pulse.new()
	p2.speed = 0.14
	p2.min_alpha = 0.45
	p2.phase = pulse_phase + 0.4
	dots.add_child(p2)


func _draw() -> void:
	_rng.seed = rng_seed
	var half := width * 0.5
	# Rocha afunilada embaixo do corpo.
	var pts := PackedVector2Array()
	var cols := PackedColorArray()
	var n := 14
	for k in n + 1:
		var t := -1.0 + 2.0 * float(k) / float(n)
		var prof := pow(1.0 - absf(t), 0.7)
		var d := (4.0 + (ROCK_DEPTH - 4.0) * prof) * (_rng.randf_range(0.7, 1.0) if k % 2 == 1 else 1.0)
		pts.append(Vector2(t * (half - 10.0), BODY_H - 1.0 + d))
		cols.append(COLOR_ROCK_A.lerp(COLOR_ROCK_B, d / ROCK_DEPTH))
	draw_polygon(pts, cols)
	draw_polyline(pts, Color(0.55, 0.62, 0.9, 0.2), 1.5, true)
	# Corpo: face frontal e faixa clara do topo.
	var face := PackedVector2Array([
		Vector2(-half, TOP_H), Vector2(half, TOP_H),
		Vector2(half - 4.0, BODY_H), Vector2(-half + 4.0, BODY_H)])
	draw_polygon(face, PackedColorArray([COLOR_FACE_A, COLOR_FACE_A, COLOR_FACE_B, COLOR_FACE_B]))
	var top := PackedVector2Array([
		Vector2(-half, 0.0), Vector2(half, 0.0), Vector2(half, TOP_H), Vector2(-half, TOP_H)])
	draw_polygon(top, PackedColorArray([COLOR_TOP_A, COLOR_TOP_A, COLOR_TOP_B, COLOR_TOP_B]))
	# Emendas verticais na face.
	var seams := 4
	for k in range(1, seams):
		var x := -half + width * float(k) / float(seams)
		draw_line(Vector2(x, TOP_H), Vector2(x, BODY_H), COLOR_SEAM, 2.0)
	draw_line(Vector2(-half + 4.0, BODY_H), Vector2(half - 4.0, BODY_H), Color(0.1, 0.12, 0.24, 0.8), 2.0)
	# Realce da borda de cima.
	draw_line(Vector2(-half, 0.8), Vector2(half, 0.8), COLOR_RIM, 2.0)
	# Cristal pequeno pendurado no centro.
	var c := Vector2(0.0, BODY_H + ROCK_DEPTH - 6.0)
	draw_colored_polygon(PackedVector2Array([c + Vector2(-5, 0), c + Vector2(5, 0), c + Vector2(0, 14)]), COLOR_CRYSTAL)


## Pontinhos luminosos na face frontal (aditivos).
class Dots extends Node2D:
	const C := Color(0.35, 0.95, 0.9, 0.8)
	var half := 130.0

	func _ready() -> void:
		material = preload("res://scripts/arena/arena_util.gd").additive()

	func _draw() -> void:
		for k in range(1, 4):
			var x := -half + half * 2.0 * float(k) / 4.0
			draw_rect(Rect2(x - 10.0, 9.5, 20.0, 2.0), C)
		draw_circle(Vector2(0.0, 30.0), 3.0, C)
