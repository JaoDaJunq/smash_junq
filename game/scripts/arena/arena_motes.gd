extends Node2D
## Partículas de poeira/luz flutuando pela tela. Posições normalizadas na janela da
## câmera, então a densidade não muda com o zoom; cada partícula tem profundidade
## própria (paralaxe). Sem alocações por quadro.

const Util := preload("res://scripts/arena/arena_util.gd")
const COLOR_WARM := Color(1.0, 0.82, 0.6)
const COLOR_COOL := Color(0.6, 0.95, 1.0)

@export var count := 70
@export var rng_seed := 11
@export var alpha_max := 0.5

var _base := PackedVector2Array()
var _drift := PackedVector2Array()
var _depth := PackedFloat32Array()
var _size := PackedFloat32Array()
var _phase := PackedFloat32Array()
var _cool := PackedByteArray()
var _t := 0.0


func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = rng_seed
	for i in count:
		_base.append(Vector2(rng.randf(), rng.randf()))
		_drift.append(Vector2(rng.randf_range(-0.004, 0.004), rng.randf_range(-0.012, -0.003)))
		_depth.append(rng.randf_range(0.15, 0.9))
		_size.append(rng.randf_range(4.0, 11.0))
		_phase.append(rng.randf() * TAU)
		_cool.append(1 if rng.randf() < 0.3 else 0)


func _process(delta: float) -> void:
	_t += delta
	queue_redraw()


func _draw() -> void:
	var inv := get_global_transform_with_canvas().affine_inverse()
	var view := get_viewport_rect().size
	var tl := inv * Vector2.ZERO
	var size := inv * view - tl
	var k := size.x / view.x # unidades de mundo por pixel de tela
	var tex := Util.soft_glow()
	for i in count:
		# Paralaxe: partículas "mais perto" andam mais com a câmera.
		var n := _base[i] + _drift[i] * _t
		var cam_shift := (tl + size * 0.5) * (1.0 - _depth[i]) / size
		var u := Vector2(fposmod(n.x - cam_shift.x, 1.0), fposmod(n.y - cam_shift.y, 1.0))
		var pos := tl + u * size
		var s := _size[i] * (0.6 + 0.4 * _depth[i]) * k
		var tw := 0.55 + 0.45 * sin(_t * 0.9 + _phase[i])
		var c := COLOR_COOL if _cool[i] == 1 else COLOR_WARM
		c.a = alpha_max * tw * (0.4 + 0.6 * _depth[i])
		draw_texture_rect(tex, Rect2(pos - Vector2(s, s), Vector2(s, s) * 2.0), false, c)
