class_name KoBeam
extends Node2D
## Feixe do KO: uma cunha de luz que sai da borda da tela na direção do centro,
## abre rápido e some. Desenhado no _draw (sem textura).

var color := Color.WHITE
var length := 900.0
var width := 260.0
var duration := 0.6
var _t := 0.0


func _ready() -> void:
	z_index = 15


func _process(delta: float) -> void:
	_t += delta
	if _t >= duration:
		queue_free()
		return
	queue_redraw()


func _draw() -> void:
	var k := _t / duration
	var open := ease(minf(k * 4.0, 1.0), 0.4)  # abre rápido
	var fade := 1.0 - ease(k, 2.0)
	var w := width * open * (1.0 - k * 0.5)
	var outer := PackedVector2Array([Vector2(0, -w * 0.15), Vector2(length * open, -w * 0.5),
		Vector2(length * open, w * 0.5), Vector2(0, w * 0.15)])
	draw_colored_polygon(outer, Color(color.r, color.g, color.b, 0.55 * fade))
	var inner := PackedVector2Array([Vector2(0, -w * 0.05), Vector2(length * open * 0.9, -w * 0.18),
		Vector2(length * open * 0.9, w * 0.18), Vector2(0, w * 0.05)])
	draw_colored_polygon(inner, Color(1, 1, 1, 0.85 * fade))
