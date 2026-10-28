class_name CocoPedaco
extends Projectile
## Pedaço de coquinho do Preguinho (especial para o lado): rola rente ao chão para um lado,
## girando. Quando o chão acaba (borda do palco), cai e some.

const FLOOR_PROBE := 70.0

var _rot := 0.0


## Cria um pedaço no mundo, rolando com a velocidade horizontal `vx`.
static func launch(owner_f: Fighter, attack_data: AttackData, at: Vector2, vx: float, tex: Texture2D) -> CocoPedaco:
	var p := CocoPedaco.new()
	p.data = attack_data
	p.owner_fighter = owner_f
	p.velocity = Vector2(vx, 0.0)
	p.lifetime = 1.1
	p.color = owner_f.body_color.lightened(0.35)
	p.add_to_group("match_cleanup")
	p.add_to_group("projectiles")
	p.z_index = 3
	owner_f.get_parent().add_child(p)
	p.global_position = at
	if tex != null:
		p.set_sprite(tex, 1.6)
	return p


func _physics_process(delta: float) -> void:
	super(delta)
	if is_queued_for_deletion():
		return
	_rot += delta * signf(velocity.x) * 11.0
	if gravity <= 0.0 and not _floor_below():
		gravity = 1800.0   # passou da borda: cai e some


func _floor_below() -> bool:
	var from := global_position + Vector2(signf(velocity.x) * 8.0, 0.0)
	var q := PhysicsRayQueryParameters2D.create(from, from + Vector2(0, FLOOR_PROBE), Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
	return not get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func _draw() -> void:
	if sprite == null or _frames.is_empty():
		super()
		return
	var src: Rect2 = _frames[0]
	var size := src.size * sprite_scale
	draw_set_transform(Vector2.ZERO, _rot, Vector2.ONE)
	draw_texture_rect_region(sprite, Rect2(-size * 0.5, size), src)
	draw_set_transform(Vector2.ZERO)
