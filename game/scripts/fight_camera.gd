extends Camera2D
## Câmera da luta: enquadra todos os lutadores com margem, aproximando e afastando
## de forma suave dentro de um limite de zoom.

@export var margin := Vector2(420, 300)
## 0.6 (era 0.45): de longe os lutadores viravam formiguinhas.
@export var min_zoom := 0.6
@export var max_zoom := 1.0
@export var smoothing := 4.0
## Ponto que a câmera puxa levemente para não perder a arena de vista.
@export var stage_center := Vector2(0, -150)
@export var stage_pull := 0.25


## Tremor: TODO acerto treme, proporcional ao dano e com piso (com piso 0.1 o
## golpe leve dava 0 px). Lançamentos a partir de shake_threshold somam mais.
@export var shake_threshold := 700.0
@export var max_shake := 18.0
## Tremor do golpe mais fraco e quanto cada 1% de dano soma.
@export var shake_floor := 0.5
@export var shake_per_damage := 0.02
## Velocidade do ruído do tremor (suave: não pula de canto a canto a cada quadro).
@export var shake_speed := 25.0

var _trauma := 0.0
var _noise := FastNoiseLite.new()
var _noise_t := 0.0


func _ready() -> void:
	add_to_group("fight_camera")
	_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	_noise.frequency = 1.0
	_noise.seed = 7
	make_current()
	_update(1.0)


func _process(delta: float) -> void:
	# Na pausa de impacto a câmera não anda nem muda o zoom: só treme.
	if not _in_hitstop():
		_update(1.0 - exp(-smoothing * delta))
	_trauma = maxf(_trauma - delta * 2.5, 0.0)
	_noise_t += delta * shake_speed
	var amount := max_shake * _trauma * _trauma
	var n := Vector2(_noise.get_noise_2d(_noise_t, 0.0), _noise.get_noise_2d(0.0, _noise_t + 100.0))
	# direção do ruído (suave), força quase toda do trauma (o ruído cru é fraco)
	var raw := n.normalized() * amount * (0.6 + 0.4 * clampf(n.length() * 2.0, 0.0, 1.0)) if n.length() > 0.0001 else Vector2.ZERO
	# Pixel inteiro NA TELA (o zoom muda quanto vale 1 px do mundo).
	var z := maxf(zoom.x, 0.01)
	offset = (raw * z).round() / z


## Chamado ao acertar um golpe (velocidade do lançamento e dano do golpe) e no
## KO (só o lançamento, damage < 0).
func shake(launch_speed: float, damage := -1.0) -> void:
	if not Settings.screen_shake:
		return  # opção "Tremor de tela" desligada
	var extra := maxf(launch_speed - shake_threshold, 0.0) / 1200.0
	if damage < 0.0:
		if launch_speed >= shake_threshold:
			_trauma = minf(_trauma + extra + 0.3, 1.0)
		return
	var t := clampf(shake_floor + damage * shake_per_damage, shake_floor, 0.85) + extra * 0.5
	_trauma = minf(maxf(_trauma + t * 0.4, t), 1.0)


func _in_hitstop() -> bool:
	for f in get_tree().get_nodes_in_group("fighters"):
		if f is Fighter and (f as Fighter)._hitstop > 0:
			return true
	return false


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
