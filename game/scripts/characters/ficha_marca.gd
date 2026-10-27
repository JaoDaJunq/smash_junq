class_name FichaMarca
extends Node2D
## Carimbos da "ficha corrida" da Dona Onça em cima do adversário (1 a 3 estrelinhas
## douradas de distintivo; na 3ª ficam vermelhas). Some quando a contagem volta a 0.
## Cada ficha nova dá um "pulo" (a estrela nova cresce e assenta) junto com o
## carimbo (MoveFx da Onça, evento "ficha").

const POP := 0.25

var count := 0:
	set(v):
		if v > count:
			_pop = POP
		count = v
		visible = v > 0
		queue_redraw()
var _pop := 0.0


func _process(delta: float) -> void:
	if _pop > 0.0:
		_pop = maxf(_pop - delta, 0.0)
		queue_redraw()


func _draw() -> void:
	var gap := 22.0
	var x0 := -gap * (count - 1) * 0.5
	for i in count:
		var c := Vector2(x0 + i * gap, 0)
		var s := 1.0
		if i == count - 1 and _pop > 0.0:
			s = 1.0 + 0.8 * (_pop / POP)   # a estrela nova chega grande e assenta
		var pts := PackedVector2Array()
		for k in 10:
			var r := (9.0 if k % 2 == 0 else 4.0) * s
			pts.append(c + Vector2.from_angle(-PI / 2 + k * PI / 5) * r)
		draw_colored_polygon(pts, Color("2a0f12"))
		var inner := PackedVector2Array()
		for p in pts:
			inner.append(c + (p - c) * 0.72)
		draw_colored_polygon(inner, Color("e8b83a") if count < 3 else Color("ff5a3a"))
