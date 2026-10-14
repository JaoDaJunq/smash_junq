extends Camera2D
## Câmera da luta: enquadra todos os lutadores com margem, aproximando e afastando
## de forma suave dentro de um limite de zoom.

@export var margin := Vector2(420, 300)
@export var min_zoom := 0.45
@export var max_zoom := 1.0
@export var smoothing := 4.0
## Ponto que a câmera puxa levemente para não perder a arena de vista.
@export var stage_center := Vector2(0, -150)
@export var stage_pull := 0.25


func _ready() -> void:
	make_current()
	_update(1.0)


func _process(delta: float) -> void:
	_update(1.0 - exp(-smoothing * delta))


func _update(weight: float) -> void:
	var fighters := get_tree().get_nodes_in_group("fighters")
	if fighters.is_empty():
		return
	var box := Rect2(fighters[0].global_position, Vector2.ZERO)
	for f in fighters:
		box = box.expand(f.global_position)
	box = box.grow_individual(margin.x, margin.y, margin.x, margin.y)
	var target_pos := box.get_center().lerp(stage_center, stage_pull)
	var view := get_viewport_rect().size
	var fit := minf(view.x / box.size.x, view.y / box.size.y)
	var target_zoom := clampf(fit, min_zoom, max_zoom)
	global_position = global_position.lerp(target_pos, weight)
	zoom = zoom.lerp(Vector2(target_zoom, target_zoom), weight)
