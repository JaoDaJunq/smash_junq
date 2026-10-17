class_name PixelFx
extends Node2D
## Efeito de pixel art que toca uma tira uma vez e some (ex.: explosão de folhas
## do Sumiço do Mico). A tira vem do importador: quadros de 64x64 lado a lado.
## O centro do efeito fica no centro do quadro.

const NATIVE := 64

var texture: Texture2D
var frames := 1
var duration := 0.4
var pixel_scale := 2.0
var _t := 0.0


## Cria o efeito como filho de `parent`, na posição global `at`.
static func spawn(parent: Node, tex: Texture2D, at: Vector2, time := 0.4, scale_px := 2.0) -> PixelFx:
	var fx := PixelFx.new()
	fx.texture = tex
	fx.frames = maxi(1, tex.get_width() / NATIVE)
	fx.duration = time
	fx.pixel_scale = scale_px
	fx.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
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
	queue_redraw()


func _draw() -> void:
	if texture == null:
		return
	var i := mini(frames - 1, int(_t / duration * frames))
	var size := Vector2(NATIVE, NATIVE) * pixel_scale
	draw_texture_rect_region(texture, Rect2(-size * 0.5, size), Rect2(i * NATIVE, 0, NATIVE, NATIVE))
