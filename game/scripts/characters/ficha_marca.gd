class_name FichaMarca
extends Node2D
## Carimbos da "ficha corrida" da Dona Onça em cima do adversário (1 a 3 estrelinhas
## douradas de distintivo; na 3ª ficam vermelhas). Some quando a contagem volta a 0.

var count := 0:
	set(v):
		count = v
		visible = v > 0
		queue_redraw()


func _draw() -> void:
	var gap := 22.0
	var x0 := -gap * (count - 1) * 0.5
	for i in count:
		var c := Vector2(x0 + i * gap, 0)
		var pts := PackedVector2Array()
		for k in 10:
			var r := 9.0 if k % 2 == 0 else 4.0
			pts.append(c + Vector2.from_angle(-PI / 2 + k * PI / 5) * r)
		draw_colored_polygon(pts, Color("2a0f12"))
		var inner := PackedVector2Array()
		for p in pts:
			inner.append(c + (p - c) * 0.72)
		draw_colored_polygon(inner, Color("e8b83a") if count < 3 else Color("ff5a3a"))
