class_name CodeFx
extends Node2D
## Efeito desenhado por código, no lugar de uma folha fx_* que ainda não chegou
## (MoveFx usa quando a regra tem "draw"). Desenho em "pixels" de 2 px com
## contorno escuro, para combinar com a pixel art. Toca uma vez e some.
##   tranco     estalo laranja em estrela (bico blindado aguentou o golpe)
##   estrelas   3 estrelinhas girando (tonto da trave do Tucão)
##   parado_ai  balão "!" vermelho + arcos de voz (Parado aí! da Dona Onça)
##   carimbo    carimbo vermelho que bate e deixa a estrela (ficha da Onça)
##   poeira     baforadas de poeira bege que crescem e somem (carrinho, corrida)
##   rasgo      saquinho rasgando: fiapos de juta e castanhas (Cutia)
##   poof       fumacinha branca em nuvem (rabo do Calango soltando)
##   areia_olho grãos de areia rodando na frente dos olhos (cegado)

const INK := Color("2a0f12")

var kind := ""
var duration := 0.4
var size_mult := 1.0
var _t := 0.0


static func spawn(parent: Node, what: String, at: Vector2, time := 0.4, mult := 1.0) -> CodeFx:
	var fx := CodeFx.new()
	fx.kind = what
	fx.duration = time
	fx.size_mult = mult
	fx.z_index = 5
	fx.add_to_group("match_cleanup")
	parent.add_child(fx)
	fx.global_position = at
	return fx


func _process(delta: float) -> void:
	_t += delta
	if _t >= duration:
		queue_free()
		return
	if kind == "areia_olho" and has_meta("follow"):
		var t = get_meta("follow")
		if not is_instance_valid(t) or float(t.get("sand_time")) <= 0.0:
			queue_free()   # a areia saiu do olho (errou o golpe ou passou o tempo)
			return
	queue_redraw()


## Quadrado de "pixel" (2 px * escala) com contorno.
func _px(p: Vector2, s: float, c: Color, outline := true) -> void:
	var q := (p / 2.0).round() * 2.0
	if outline:
		draw_rect(Rect2(q - Vector2(s, s) * 0.5 - Vector2(2, 2), Vector2(s, s) + Vector2(4, 4)), INK)
	draw_rect(Rect2(q - Vector2(s, s) * 0.5, Vector2(s, s)), c)


func _star(c: Vector2, r: float, col: Color, rot := 0.0) -> void:
	var pts := PackedVector2Array()
	for k in 10:
		var rr := r if k % 2 == 0 else r * 0.45
		pts.append(c + Vector2.from_angle(-PI / 2 + rot + k * PI / 5) * rr)
	draw_colored_polygon(pts, INK)
	var inner := PackedVector2Array()
	for p in pts:
		inner.append(c + (p - c) * 0.68)
	draw_colored_polygon(inner, col)


func _draw() -> void:
	var k := clampf(_t / duration, 0.0, 1.0)
	var m := size_mult
	match kind:
		"tranco":
			# estalo: raios laranja e amarelos saindo do peito, curtos e grossos
			var r0 := 10.0 * m
			var r1 := (22.0 + 26.0 * k) * m
			for i in 8:
				var d := Vector2.from_angle(i * TAU / 8.0 + 0.2)
				var a := d * r0 * (1.0 + k)
				var b := d * r1
				draw_line(a, b, INK, 8.0 * m)
				draw_line(a, b, Color("ff8a1e") if i % 2 == 0 else Color("ffd84a"), 4.0 * m)
			if k < 0.5:
				draw_circle(Vector2.ZERO, 9.0 * m * (1.0 - k), Color("fff4d6"))
		"estrelas":
			for i in 3:
				var ang := _t * 7.0 + i * TAU / 3.0
				var p := Vector2(cos(ang) * 30.0, sin(ang) * 9.0) * m
				_star(p, 9.0 * m, Color("ffd84a"), _t * 4.0)
		"parado_ai":
			# arcos de voz para a frente e um balão vermelho com "!"
			var grow := 0.6 + 0.6 * k
			for i in 3:
				var rr := (24.0 + i * 18.0) * grow * m
				var col := Color(1, 1, 1, 1.0 - k)
				draw_arc(Vector2(-10, 0) * m, rr, -0.7, 0.7, 10, INK, 7.0 * m)
				draw_arc(Vector2(-10, 0) * m, rr, -0.7, 0.7, 10, col, 3.0 * m)
			var b := Vector2(18, -44) * m
			var pop := minf(1.0, k * 5.0)
			var w := 26.0 * m * pop
			draw_rect(Rect2(b - Vector2(w, w) * 0.5 - Vector2(3, 3), Vector2(w, w) + Vector2(6, 6)), INK)
			draw_rect(Rect2(b - Vector2(w, w) * 0.5, Vector2(w, w)), Color("e8402a"))
			if pop >= 1.0:
				draw_rect(Rect2(b + Vector2(-3, -9) * m, Vector2(6, 12) * m), Color.WHITE)
				draw_rect(Rect2(b + Vector2(-3, 5) * m, Vector2(6, 5) * m), Color.WHITE)
		"carimbo":
			# carimbo: cai de cima e bate (k < 0.35), depois a marca pisca
			var drop := maxf(0.0, 1.0 - k / 0.35)
			var c := Vector2(0, -drop * 30.0 * m)
			var sc := (1.0 + 0.4 * drop) * m
			draw_circle(c, 15.0 * sc, INK)
			draw_circle(c, 12.0 * sc, Color("c8202a"))
			draw_circle(c, 9.0 * sc, Color("f2e6c8"))
			_star(c, 7.0 * sc, Color("c8202a"))
			if drop <= 0.0 and k < 0.6:
				for i in 6:
					var d := Vector2.from_angle(i * TAU / 6.0)
					draw_line(d * 18.0 * m, d * 26.0 * m, Color("ffd84a"), 3.0 * m)
		"poeira":
			for i in 3:
				var p := Vector2((-10 + i * 12) * m - 18.0 * k * m, (8 - i * 3) * m - 10.0 * k * m)
				var r := (6.0 + 10.0 * k + i * 2.0) * m
				var a := 1.0 - k
				draw_circle(p, r + 2.0, Color(INK, a * 0.8))
				draw_circle(p, r, Color(0.86, 0.76, 0.58, a))
				draw_circle(p + Vector2(-r * 0.3, -r * 0.3), r * 0.45, Color(0.95, 0.9, 0.78, a))
		"rasgo":
			# fiapos de juta (marrom-claro) e 2 castanhas voando para fora
			for i in 7:
				var d := Vector2.from_angle(-PI * 0.5 + (i - 3) * 0.45)
				var p := d * (6.0 + 40.0 * k) * m + Vector2(0, 60.0 * k * k) * m
				_px(p, 6.0 * m, Color("e0c088") if i % 2 else Color("c09858"))
			for i in 2:
				var p := Vector2((-1 + 2 * i) * 22.0 * k, -26.0 * k + 50.0 * k * k) * m
				draw_circle(p, 6.0 * m, INK)
				draw_circle(p, 4.0 * m, Color("7a3a1a"))
		"poof":
			for i in 5:
				var d := Vector2.from_angle(i * TAU / 5.0 + 0.4)
				var p := d * (6.0 + 18.0 * k) * m
				var r := (8.0 + 6.0 * k) * m * (1.0 - 0.5 * k)
				draw_circle(p, r + 2.0, Color(INK, 1.0 - k))
				draw_circle(p, r, Color(0.96, 0.96, 0.92, 1.0 - k * 0.8))
		"areia_olho":
			for i in 8:
				var ang := _t * 9.0 + i * TAU / 8.0
				var p := Vector2(cos(ang) * 20.0, sin(ang) * 6.0) * m
				_px(p, 3.0 * m, Color("f2dc8c") if i % 2 else Color("c9a24a"))
