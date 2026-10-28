class_name SkateVoador
extends Projectile
## Skate do Beija (especial para o lado): segue sozinho como projétil. Rola rente ao
## chão e, quando o chão acaba (borda do palco), cai e some. Lançado no ar, voa reto.
## Desenhado por código (a arte não tem folha própria do skate).

const FLOOR_PROBE := 70.0

## Segue rente ao chão: perde o chão na borda e então cai.
var needs_floor := true
var _spin := 0.0


## Cria o skate no mundo, indo para `dir` (1 ou -1). Só um por dono: o anterior some.
static func launch(owner_f: Fighter, attack_data: AttackData, at: Vector2, dir: int, speed: float, on_floor: bool) -> SkateVoador:
	for n in owner_f.get_tree().get_nodes_in_group("skates"):
		if n.get("owner_fighter") == owner_f:
			n.queue_free()
	var p := SkateVoador.new()
	p.data = attack_data
	p.owner_fighter = owner_f
	p.velocity = Vector2(speed * dir, 0.0)
	p.lifetime = 1.4
	p.needs_floor = on_floor
	p.color = owner_f.body_color.lightened(0.35)
	p.add_to_group("match_cleanup")
	p.add_to_group("projectiles")
	p.add_to_group("skates")
	p.z_index = 3
	owner_f.get_parent().add_child(p)
	p.global_position = at
	return p


func _physics_process(delta: float) -> void:
	super(delta)
	if is_queued_for_deletion():
		return
	_spin += delta
	if needs_floor and gravity <= 0.0 and not _floor_below():
		needs_floor = false
		gravity = 1800.0   # passou da borda: cai e some


func _floor_below() -> bool:
	var from := global_position + Vector2(signf(velocity.x) * 8.0, 0.0)
	var q := PhysicsRayQueryParameters2D.create(from, from + Vector2(0, FLOOR_PROBE), Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
	return not get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func _draw() -> void:
	var flip := -1.0 if velocity.x < 0.0 else 1.0
	var tilt := 0.0 if needs_floor else sin(_spin * 14.0) * 0.25
	draw_set_transform(Vector2.ZERO, tilt * flip, Vector2(flip, 1.0))
	var ink := Color("2a0f12")
	# shape (amarelo, pontas levantadas), trucks e rodinhas
	draw_rect(Rect2(-24, -4, 48, 8), ink)
	draw_rect(Rect2(-22, -3, 44, 5), Color("f2b52a"))
	draw_rect(Rect2(-22, 0, 44, 2), Color("c98a1a"))
	draw_rect(Rect2(-27, -7, 7, 5), ink)
	draw_rect(Rect2(-26, -6, 5, 3), Color("f2b52a"))
	draw_rect(Rect2(20, -7, 7, 5), ink)
	draw_rect(Rect2(21, -6, 5, 3), Color("f2b52a"))
	for x in [-14.0, 14.0]:
		draw_rect(Rect2(x - 3, 4, 6, 3), Color("6b6b78"))
		draw_circle(Vector2(x, 9), 5.0, ink)
		draw_circle(Vector2(x, 9), 3.5, Color("fff4d6"))
		draw_circle(Vector2(x, 9), 1.2, Color("c98a1a"))
	draw_set_transform(Vector2.ZERO)
