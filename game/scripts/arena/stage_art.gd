extends Node2D
## Arte do palco principal: ilha de pedra e tecnologia flutuante. Desenhada uma vez em
## _draw (cache do canvas); os brilhos ficam em nós aditivos separados que só pulsam.
## Geometria: topo em y=0 (onde os lutadores pisam), colisão 1120x60 de x=-560 a 560.

const Util := preload("res://scripts/arena/arena_util.gd")
const Pulse := preload("res://scripts/arena/glow_pulse.gd")

const HALF_W := 560.0
const TOP_H := 12.0 # faixa clara da superfície
const FACE_BOTTOM := 60.0 # fim da face frontal (base da colisão)
const ROCK_DEPTH := 235.0 # profundidade da rocha embaixo da face
const SEAM_STEP := 112.0 # largura das placas

# --- Cores ---
const COLOR_RIM := Color("fff4e0")
const COLOR_TOP_A := Color("f0f4ff")
const COLOR_TOP_B := Color("b2bedc")
const COLOR_TOP_SLOT := Color("8794bb")
const COLOR_FACE_A := Color("66749e")
const COLOR_FACE_B := Color("353e66")
const COLOR_SEAM_DARK := Color(0.1, 0.12, 0.24, 0.65)
const COLOR_SEAM_LIGHT := Color(0.7, 0.78, 0.95, 0.3)
const COLOR_FACE_EDGE := Color("1a1f3a")
const COLOR_ROCK_BACK_A := Color("2b3260")
const COLOR_ROCK_BACK_B := Color("15182f")
const COLOR_ROCK_MID_A := Color("3a4378")
const COLOR_ROCK_MID_B := Color("1e2347")
const COLOR_FACET := Color(0.55, 0.62, 0.9, 0.3)
const COLOR_STRATA := Color(0.1, 0.12, 0.25, 0.55)
const COLOR_CRYSTAL_A := Color("7ff5e6")
const COLOR_CRYSTAL_B := Color("2a9fb4")
const COLOR_EMBLEM := Color("1c2145")
const COLOR_SHADOW := Color(0.04, 0.02, 0.1, 0.5)
# Brilhos (aditivos)
const COLOR_ACCENT := Color(0.35, 0.95, 0.9, 0.75)
const COLOR_ACCENT_SOFT := Color(0.25, 0.8, 0.85, 0.5)
const COLOR_LEDGE := Color(1.0, 0.72, 0.38, 0.95)

var _rng := RandomNumberGenerator.new()
var _crystal_tips := PackedVector2Array()


func _ready() -> void:
	# Sombra suave sob o palco (atrás da própria arte).
	var shadow := Util.glow_sprite(Vector2(1700.0, 340.0), COLOR_SHADOW, false)
	shadow.position = Vector2(0.0, 340.0)
	shadow.show_behind_parent = true
	add_child(shadow)
	# Os brilhos dependem das pontas dos cristais, calculadas junto com a rocha.
	_rng.seed = 2024
	var back := _rock_outline(1.0, 1.0)
	_crystal_tips = _pick_tips(back)
	_build_glows()


func _draw() -> void:
	_rng.seed = 2024
	_draw_rock()
	_draw_face()
	_draw_top()


# --- Rocha de baixo: camadas com degradê, facetas, estratos e cristais ---
func _rock_outline(width_scale: float, depth_scale: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	var n := 36
	for k in n + 1:
		var t := -1.0 + 2.0 * float(k) / float(n)
		var prof := pow(1.0 - absf(t), 0.6)
		var d := (22.0 + (ROCK_DEPTH - 22.0) * prof) * depth_scale
		# Irregularidade: estalactites a cada poucos vértices.
		if k % 3 == 0:
			d *= _rng.randf_range(1.04, 1.16) if prof > 0.15 else 1.0
		else:
			d *= _rng.randf_range(0.8, 0.97)
		pts.append(Vector2(t * (HALF_W - 6.0) * width_scale, FACE_BOTTOM - 2.0 + d))
	return pts


## Escolhe pontas de estalactite (mínimos locais de profundidade) para os cristais.
func _pick_tips(outline: PackedVector2Array) -> PackedVector2Array:
	var tips := PackedVector2Array()
	for k in range(3, outline.size() - 3, 1):
		if k % 6 == 0 and absf(outline[k].x) < HALF_W - 120.0:
			tips.append(outline[k])
	return tips


func _draw_rock() -> void:
	# Camada de trás (mais escura e larga).
	var back := _rock_outline(1.0, 1.0)
	_fill_rock(back, COLOR_ROCK_BACK_A, COLOR_ROCK_BACK_B)
	# Camada da frente: menor, mais clara, dá volume e dobras.
	var mid := _rock_outline(0.86, 0.72)
	_fill_rock(mid, COLOR_ROCK_MID_A, COLOR_ROCK_MID_B)
	# Facetas: linhas descendo da face até o centro da base.
	for k in 14:
		var x0 := _rng.randf_range(-HALF_W + 30.0, HALF_W - 30.0)
		var tip := Vector2(x0 * 0.45, FACE_BOTTOM + _rng.randf_range(90.0, 210.0) * (1.0 - absf(x0) / (HALF_W * 1.3)))
		draw_polyline(PackedVector2Array([Vector2(x0, FACE_BOTTOM + 2.0), Vector2(x0 * 0.8, FACE_BOTTOM + (tip.y - FACE_BOTTOM) * 0.45), tip]), COLOR_FACET, 2.0, true)
	# Estratos: arcos escuros acompanhando o formato da rocha.
	for level: float in [0.28, 0.5, 0.72]:
		var arc := PackedVector2Array()
		var n := 24
		for k in n + 1:
			var t := -1.0 + 2.0 * float(k) / float(n)
			var prof := pow(1.0 - absf(t), 0.6)
			var d := (22.0 + (ROCK_DEPTH - 22.0) * prof) * level
			arc.append(Vector2(t * (HALF_W - 14.0) * (1.0 - level * 0.12), FACE_BOTTOM + d + sin(t * 9.0 + level * 7.0) * 3.0))
		draw_polyline(arc, COLOR_STRATA, 3.0, true)
	# Sombra projetada pela face frontal sobre a rocha.
	draw_rect(Rect2(-HALF_W + 4.0, FACE_BOTTOM - 2.0, (HALF_W - 4.0) * 2.0, 10.0), Color(0.04, 0.05, 0.12, 0.45))
	# Emblema tecnológico no centro da rocha.
	var c := Vector2(0.0, FACE_BOTTOM + 78.0)
	var diamond := PackedVector2Array([c + Vector2(0, -34), c + Vector2(26, 0), c + Vector2(0, 34), c + Vector2(-26, 0)])
	draw_colored_polygon(diamond, COLOR_EMBLEM)
	draw_polyline(PackedVector2Array([diamond[0], diamond[1], diamond[2], diamond[3], diamond[0]]), Color(0.45, 0.55, 0.85, 0.5), 2.0, true)
	# Cristais pendurados nas pontas.
	for tip in _crystal_tips:
		_draw_crystal(tip + Vector2(0.0, -6.0), _rng.randf_range(0.8, 1.3))


func _fill_rock(outline: PackedVector2Array, col_top: Color, col_bottom: Color) -> void:
	var poly := PackedVector2Array(outline)
	var cols := PackedColorArray()
	for p in poly:
		var f := clampf((p.y - FACE_BOTTOM) / ROCK_DEPTH, 0.0, 1.0)
		cols.append(col_top.lerp(col_bottom, f))
	draw_polygon(poly, cols)
	# Contorno claro sutil (luz vinda de cima/esquerda).
	draw_polyline(poly, Color(0.55, 0.62, 0.9, 0.18), 1.5, true)


func _draw_crystal(base: Vector2, s: float) -> void:
	var w := 9.0 * s
	var h := 28.0 * s
	draw_colored_polygon(PackedVector2Array([base + Vector2(-w, 0), base + Vector2(w, 0), base + Vector2(0, h)]), COLOR_CRYSTAL_B)
	draw_colored_polygon(PackedVector2Array([base + Vector2(-w, 0), base + Vector2(0, -4.0 * s), base + Vector2(0, h)]), COLOR_CRYSTAL_A)


# --- Face frontal: placas com emendas, parafusos e friso ---
func _draw_face() -> void:
	var y0 := TOP_H
	var y1 := FACE_BOTTOM
	var poly := PackedVector2Array([
		Vector2(-HALF_W, y0), Vector2(HALF_W, y0),
		Vector2(HALF_W - 8.0, y1), Vector2(-HALF_W + 8.0, y1)])
	draw_polygon(poly, PackedColorArray([COLOR_FACE_A, COLOR_FACE_A, COLOR_FACE_B, COLOR_FACE_B]))
	# Friso horizontal claro e ranhura escura.
	draw_line(Vector2(-HALF_W, y0 + 11.0), Vector2(HALF_W, y0 + 11.0), COLOR_SEAM_LIGHT, 2.0)
	draw_line(Vector2(-HALF_W + 6.0, y1 - 9.0), Vector2(HALF_W - 6.0, y1 - 9.0), COLOR_SEAM_DARK, 3.0)
	# Emendas entre placas.
	var x := -HALF_W + SEAM_STEP
	while x < HALF_W - 1.0:
		draw_line(Vector2(x, y0 + 1.0), Vector2(x, y1), COLOR_SEAM_DARK, 3.0)
		draw_line(Vector2(x + 2.0, y0 + 1.0), Vector2(x + 2.0, y1), COLOR_SEAM_LIGHT, 1.5)
		draw_circle(Vector2(x - 8.0, y0 + 8.0), 2.0, COLOR_SEAM_DARK)
		draw_circle(Vector2(x + 10.0, y0 + 8.0), 2.0, COLOR_SEAM_DARK)
		x += SEAM_STEP
	# Borda inferior escura (separa da rocha).
	draw_line(Vector2(-HALF_W + 8.0, y1), Vector2(HALF_W - 8.0, y1), COLOR_FACE_EDGE, 3.0)


# --- Superfície de cima: faixa clara com realce e ranhuras ---
func _draw_top() -> void:
	var poly := PackedVector2Array([
		Vector2(-HALF_W, 0.0), Vector2(HALF_W, 0.0), Vector2(HALF_W, TOP_H), Vector2(-HALF_W, TOP_H)])
	draw_polygon(poly, PackedColorArray([COLOR_TOP_A, COLOR_TOP_A, COLOR_TOP_B, COLOR_TOP_B]))
	# Ranhuras no centro de cada placa.
	var x := -HALF_W
	while x < HALF_W - 1.0:
		var cx := x + SEAM_STEP * 0.5
		draw_line(Vector2(cx - 22.0, 6.0), Vector2(cx + 22.0, 6.0), COLOR_TOP_SLOT, 3.0)
		if x > -HALF_W + 1.0:
			draw_line(Vector2(x, 1.0), Vector2(x, TOP_H), COLOR_TOP_SLOT, 1.5)
		x += SEAM_STEP
	# Realce de borda no topo.
	draw_line(Vector2(-HALF_W, 1.0), Vector2(HALF_W, 1.0), COLOR_RIM, 2.5)
	# Quinas de cima ligeiramente chanfradas/claras.
	draw_line(Vector2(-HALF_W, 0.0), Vector2(-HALF_W, TOP_H), COLOR_RIM, 2.0)
	draw_line(Vector2(HALF_W, 0.0), Vector2(HALF_W, TOP_H), COLOR_RIM, 2.0)


# --- Brilhos aditivos que pulsam devagar ---
func _build_glows() -> void:
	# Frisos ciano na face frontal e nas emendas.
	var lines := AccentLines.new()
	lines.name = "AccentLines"
	add_child(lines)
	_add_pulse(lines, 0.1, 0.6, 1.0, 0.0)
	# Brilho dos cristais e do emblema central.
	var crystals := Node2D.new()
	crystals.name = "CrystalGlow"
	for tip in _crystal_tips:
		var g := Util.glow_sprite(Vector2(70, 70), COLOR_ACCENT_SOFT)
		g.position = tip + Vector2(0.0, 10.0)
		crystals.add_child(g)
	var core := Util.glow_sprite(Vector2(240, 240), Color(0.3, 0.85, 0.9, 0.4))
	core.position = Vector2(0.0, FACE_BOTTOM + 78.0)
	crystals.add_child(core)
	add_child(crystals)
	_add_pulse(crystals, 0.07, 0.45, 1.0, 0.33)
	# Marcas âmbar nas bordas (onde os lutadores se agarram).
	for side in [-1.0, 1.0]:
		var mark := LedgeMark.new()
		mark.name = "LedgeMark" + ("L" if side < 0.0 else "R")
		mark.position = Vector2(side * HALF_W, 0.0)
		mark.scale = Vector2(side, 1.0)
		add_child(mark)
		var halo := Util.glow_sprite(Vector2(120, 120), Color(1.0, 0.6, 0.25, 0.45))
		halo.position = Vector2(-10.0, 24.0)
		mark.add_child(halo)
		_add_pulse(mark, 0.15, 0.55, 1.0, 0.5 if side > 0.0 else 0.0)


func _add_pulse(n: Node2D, speed: float, lo: float, hi: float, phase: float) -> void:
	# O nó Pulse age sobre o pai (n).
	var p := Pulse.new()
	p.speed = speed
	p.min_alpha = lo
	p.max_alpha = hi
	p.phase = phase
	n.add_child(p)


## Friso ciano da face frontal (aditivo).
class AccentLines extends Node2D:
	const A := Color(0.35, 0.95, 0.9, 0.75)
	const STEP := 112.0
	const HALF := 560.0

	func _ready() -> void:
		material = preload("res://scripts/arena/arena_util.gd").additive()

	func _draw() -> void:
		var x := -HALF
		while x < HALF - 1.0:
			draw_line(Vector2(x + 14.0, 40.0), Vector2(x + STEP - 14.0, 40.0), A, 2.0)
			draw_line(Vector2(x + 14.0, 40.0), Vector2(x + 14.0, 34.0), A, 2.0)
			draw_line(Vector2(x + STEP - 14.0, 40.0), Vector2(x + STEP - 14.0, 34.0), A, 2.0)
			x += STEP


## Marca de ponta de plataforma (âmbar): barra vertical e setas na borda.
class LedgeMark extends Node2D:
	const C := Color(1.0, 0.72, 0.38, 0.95)

	func _ready() -> void:
		material = preload("res://scripts/arena/arena_util.gd").additive()

	func _draw() -> void:
		draw_rect(Rect2(-8.0, 14.0, 4.0, 38.0), C)
		draw_polyline(PackedVector2Array([Vector2(-36.0, 3.0), Vector2(-22.0, 9.0), Vector2(-36.0, 15.0)]), C, 2.0, true)
		draw_polyline(PackedVector2Array([Vector2(-52.0, 3.0), Vector2(-38.0, 9.0), Vector2(-52.0, 15.0)]), Color(C.r, C.g, C.b, 0.5), 2.0, true)
