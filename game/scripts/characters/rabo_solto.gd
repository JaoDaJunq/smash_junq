class_name RaboSolto
extends Node2D
## Rabo do Calango que se soltou: fica no chão se mexendo por LIFETIME s e some piscando.

const LIFETIME := 4.0
var tex: Texture2D
var _age := 0.0


func _ready() -> void:
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	z_index = -1


func _process(delta: float) -> void:
	_age += delta
	if _age > LIFETIME:
		queue_free()
	queue_redraw()


func _draw() -> void:
	if _age > LIFETIME - 1.0 and int(_age * 10.0) % 2 == 0:
		return
	if tex != null:
		var n := 2   # rabo.png: 2 quadros (curvado para um lado e para o outro)
		var fw := float(tex.get_width()) / n
		var i := int(_age * 6.0) % n
		var size := Vector2(fw, tex.get_height()) * 2.0
		draw_texture_rect_region(tex, Rect2(Vector2(-size.x * 0.5, -size.y), size), Rect2(i * fw, 0, fw, tex.get_height()))
		return
	# Sem arte: rabinho desenhado (curva que balança)
	var pts := PackedVector2Array()
	for k in 12:
		var t := k / 11.0
		pts.append(Vector2(-30.0 + 60.0 * t, -4.0 - sin(t * 6.0 + _age * 10.0) * 6.0 * t))
	draw_polyline(pts, Color("2a0f12"), 7.0)
	draw_polyline(pts, Color("8a8a3a"), 4.0)
