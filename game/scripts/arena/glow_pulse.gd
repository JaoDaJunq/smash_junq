extends Node
## Faz o nó pai pulsar devagar (só altera o alfa, sem redesenhar nada).

@export var speed := 0.12
@export var min_alpha := 0.55
@export var max_alpha := 1.0
@export var phase := 0.0

var _t := 0.0
var _target: CanvasItem


func _ready() -> void:
	_t = phase
	_target = get_parent() as CanvasItem


func _process(delta: float) -> void:
	_t += delta * speed
	_target.modulate.a = lerpf(min_alpha, max_alpha, 0.5 + 0.5 * sin(_t * TAU))
