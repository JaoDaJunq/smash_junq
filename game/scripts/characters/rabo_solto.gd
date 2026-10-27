class_name RaboSolto
extends Node2D
## Rabo do Calango que se soltou: fica no chão se mexendo por LIFETIME s e some
## piscando. É ISCA (grupo "iscas"): o primeiro golpe de adversário que encostar
## nele é gasto ali (Fighter._check_hits) e o rabo pula e some num poof.

const LIFETIME := 4.0
const POP_TIME := 0.35
var tex: Texture2D
var owner_fighter: Fighter
var flip := false
var _age := 0.0
var _pop := -1.0
var _frames: Array[Rect2] = []
var _settled := false


func _ready() -> void:
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	z_index = -1


## Assenta no chão (palco ou plataforma) logo abaixo.
func _settle() -> void:
	var q := PhysicsRayQueryParameters2D.create(global_position + Vector2(0, -20), global_position + Vector2(0, 200),
		Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	if not hit.is_empty():
		global_position = hit.position


func _cut_frames() -> void:
	if tex == null or not _frames.is_empty():
		return
	var img := tex.get_image()
	var n := Projectile.strip_frames(tex)
	var fw := tex.get_width() / n
	for i in n:
		var used := img.get_region(Rect2i(i * fw, 0, fw, tex.get_height())).get_used_rect()
		if used.size != Vector2i.ZERO:
			_frames.append(Rect2(used.position + Vector2i(i * fw, 0), used.size))


## Caixa que leva golpe (o rabo se contorcendo: 44x40 em cima do chão).
func hurt_rect() -> Rect2:
	return Rect2(global_position + Vector2(-22, -40), Vector2(44, 40))


## Um golpe pegou a isca: pula e some.
func pop(_by: Node2D) -> void:
	if _pop >= 0.0:
		return
	_pop = 0.0
	remove_from_group("iscas")
	if owner_fighter != null and is_instance_valid(owner_fighter) and owner_fighter.move_fx != null:
		owner_fighter.move_fx.play_at("fx_rabo_poof", global_position + Vector2(0, -10), 2.0, 0.4, "poof")


func _process(delta: float) -> void:
	if not _settled:
		_settled = true
		_settle()
	_age += delta
	if _pop >= 0.0:
		_pop += delta
		if _pop >= POP_TIME:
			queue_free()
	elif _age > LIFETIME:
		queue_free()
	queue_redraw()


func _draw() -> void:
	if _pop < 0.0 and _age > LIFETIME - 1.0 and int(_age * 10.0) % 2 == 0:
		return
	var lift := 0.0
	var spin := 0.0
	if _pop >= 0.0:
		var k := _pop / POP_TIME
		lift = -60.0 * sin(k * PI)
		spin = k * TAU
		modulate.a = 1.0 - k
	_cut_frames()
	if not _frames.is_empty():
		var src: Rect2 = _frames[int(_age * 6.0) % _frames.size()]
		var size := src.size * 2.0
		draw_set_transform(Vector2(0, lift - size.y * 0.5 + 2.0), spin, Vector2(-1.0 if flip else 1.0, 1.0))
		draw_texture_rect_region(tex, Rect2(-size * 0.5, size), src)
		draw_set_transform(Vector2.ZERO)
		return
	# Sem arte: rabinho desenhado (curva que balança)
	var pts := PackedVector2Array()
	for k in 12:
		var t := k / 11.0
		pts.append(Vector2(-30.0 + 60.0 * t, lift - 4.0 - sin(t * 6.0 + _age * 10.0) * 6.0 * t))
	draw_polyline(pts, Color("2a0f12"), 7.0)
	draw_polyline(pts, Color("8a8a3a"), 4.0)
