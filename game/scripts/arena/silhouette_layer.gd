extends Node2D
## Camada de silhuetas distantes (montanhas ou ilhas flutuantes com ruínas), gerada em
## _draw com ruído e semente fixos. O desenho é feito uma vez só (cache do canvas).

enum Kind { MOUNTAINS, ISLANDS }

const X_MIN := -3400.0
const X_MAX := 3400.0
const BOTTOM_Y := 2800.0
const FADE_HEIGHT := 520.0 # distância da crista até a cor cheia da neblina

@export var kind := Kind.MOUNTAINS
@export var rng_seed := 1
## Altura do "chão" das montanhas (base das cristas) em coordenadas da camada.
@export var base_y := 100.0
@export var amplitude := 300.0
@export var step := 56.0
@export var noise_frequency := 0.0032
## Cor da crista/topo e cor da neblina na base.
@export var top_color := Color(0.42, 0.3, 0.55)
@export var bottom_color := Color(0.5, 0.33, 0.55)
## Luz do sol na borda superior (alfa 0 desliga).
@export var rim_color := Color(1.0, 0.65, 0.5, 0.0)
@export var island_count := 8
@export var island_y_range := Vector2(-700.0, -150.0)
@export var island_width_range := Vector2(220.0, 520.0)
@export var ruins := true
## Janelinhas quentes acesas nas ruínas (alfa 0 desliga).
@export var window_color := Color(1.0, 0.72, 0.4, 0.0)
## Faixa central (x) onde as ilhas são evitadas, para não poluir atrás dos lutadores.
@export var clear_x := Vector2(0.0, 0.0)

var _rng := RandomNumberGenerator.new()


func _draw() -> void:
	_rng.seed = rng_seed
	if kind == Kind.MOUNTAINS:
		_draw_mountains()
	else:
		_draw_islands()


# --- Montanhas ---
func _draw_mountains() -> void:
	var noise := FastNoiseLite.new()
	noise.seed = rng_seed
	noise.frequency = noise_frequency
	noise.fractal_octaves = 3
	var ridge := PackedVector2Array()
	var x := X_MIN
	while x <= X_MAX:
		var n := noise.get_noise_1d(x)
		# Crista "ridged": picos pontudos onde o ruído cruza zero.
		var h := 1.0 - clampf(absf(n) * 2.4, 0.0, 1.0)
		var jag := noise.get_noise_1d(x * 5.0 + 900.0) * 0.06
		var y := base_y - amplitude * (0.12 + 0.88 * pow(h, 1.4) + jag)
		ridge.append(Vector2(x, y))
		x += step
	# Faixa degradê da crista até a neblina.
	var poly := PackedVector2Array(ridge)
	var cols := PackedColorArray()
	for i in ridge.size():
		cols.append(top_color)
	var fade_y := base_y + FADE_HEIGHT
	poly.append(Vector2(X_MAX, fade_y))
	poly.append(Vector2(X_MIN, fade_y))
	cols.append(bottom_color)
	cols.append(bottom_color)
	draw_polygon(poly, cols)
	# Preenchimento sólido abaixo, até o fim do mundo visível.
	draw_rect(Rect2(X_MIN, fade_y - 1.0, X_MAX - X_MIN, BOTTOM_Y - fade_y + 1.0), bottom_color)
	if rim_color.a > 0.0:
		draw_polyline(ridge, rim_color, 2.0, true)


# --- Ilhas flutuantes ---
func _draw_islands() -> void:
	var slot := (X_MAX - X_MIN - 400.0) / float(island_count)
	for i in island_count:
		var w := _rng.randf_range(island_width_range.x, island_width_range.y)
		var cx := X_MIN + 200.0 + slot * (float(i) + _rng.randf_range(0.15, 0.85))
		var cy := _rng.randf_range(island_y_range.x, island_y_range.y)
		var h := w * _rng.randf_range(0.35, 0.6)
		var has_ruin := ruins and _rng.randf() < 0.75
		var inside_clear := cx > clear_x.x and cx < clear_x.y
		if inside_clear:
			continue
		_draw_island(Vector2(cx, cy), w, h, has_ruin)


func _draw_island(c: Vector2, w: float, h: float, has_ruin: bool) -> void:
	var half := w * 0.5
	var pts := PackedVector2Array()
	var cols := PackedColorArray()
	var top_edge := PackedVector2Array()
	# Borda superior: quase plana, com leves ondulações.
	var n := 12
	for k in n + 1:
		var t := float(k) / float(n)
		var p := Vector2(c.x + (t - 0.5) * w, c.y + _rng.randf_range(-3.0, 3.0) + pow(absf(2.0 * t - 1.0), 3.0) * 5.0)
		top_edge.append(p)
		pts.append(p)
		cols.append(top_color)
	# Parte de baixo: cone invertido irregular.
	var bottom_cols_color := top_color.lerp(bottom_color, 0.85)
	var m := 14
	for k in range(m, -1, -1):
		var t := float(k) / float(m)
		var prof := pow(1.0 - absf(2.0 * t - 1.0), 0.8)
		var depth := h * (0.22 + 0.78 * prof) * _rng.randf_range(0.78, 1.05)
		var p2 := Vector2(c.x + (t - 0.5) * w * (0.96 - 0.5 * (1.0 - prof)), c.y + depth)
		pts.append(p2)
		cols.append(bottom_cols_color)
	draw_polygon(pts, cols)
	# Ruínas sobre a ilha: colunas quebradas e, às vezes, um arco.
	if has_ruin:
		_draw_ruin(top_edge, half)
	# Pedras soltas flutuando embaixo.
	var rocks := _rng.randi_range(1, 3)
	for r in rocks:
		var rc := Vector2(c.x + _rng.randf_range(-half * 0.5, half * 0.5), c.y + h + _rng.randf_range(20.0, 90.0))
		_draw_rock(rc, _rng.randf_range(10.0, 26.0), bottom_cols_color)
	if rim_color.a > 0.0:
		draw_polyline(top_edge, rim_color, 2.0, true)


func _draw_ruin(top_edge: PackedVector2Array, half: float) -> void:
	var col := top_color.darkened(0.12)
	var base_x := top_edge[0].x + _rng.randf_range(0.2, 0.55) * half * 2.0
	var count := _rng.randi_range(2, 4)
	var arch := _rng.randf() < 0.5
	var x := base_x
	var prev_top := Vector2.ZERO
	for k in count:
		var cw := _rng.randf_range(8.0, 15.0)
		var ch := _rng.randf_range(28.0, 90.0)
		var gy := _ground_y(top_edge, x)
		var slant := _rng.randf_range(-8.0, 8.0)
		var poly := PackedVector2Array([
			Vector2(x, gy + 3.0), Vector2(x, gy - ch),
			Vector2(x + cw * 0.5, gy - ch - 6.0 + slant), Vector2(x + cw, gy - ch + slant * 0.5),
			Vector2(x + cw, gy + 3.0)])
		draw_colored_polygon(poly, col)
		if window_color.a > 0.0 and ch > 45.0:
			draw_rect(Rect2(x + cw * 0.5 - 1.5, gy - ch * 0.55, 3.0, 5.0), window_color)
		if arch and k == 1:
			# Verga unindo duas colunas.
			draw_rect(Rect2(prev_top.x, prev_top.y - 7.0, x + cw - prev_top.x, 8.0), col)
		prev_top = Vector2(x, gy - ch)
		x += cw + _rng.randf_range(14.0, 34.0)


func _ground_y(top_edge: PackedVector2Array, x: float) -> float:
	var best := top_edge[0].y
	var best_d := INF
	for p in top_edge:
		var d := absf(p.x - x)
		if d < best_d:
			best_d = d
			best = p.y
	return best


func _draw_rock(c: Vector2, r: float, col: Color) -> void:
	var poly := PackedVector2Array()
	for k in 7:
		var a := TAU * float(k) / 7.0
		poly.append(c + Vector2(cos(a) * r * _rng.randf_range(0.8, 1.2), sin(a) * r * 0.7 * _rng.randf_range(0.8, 1.2)))
	draw_colored_polygon(poly, col)
