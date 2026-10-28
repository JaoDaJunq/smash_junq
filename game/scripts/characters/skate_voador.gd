class_name SkateVoador
extends Projectile
## Skate do Beija (especial para o lado): segue sozinho como projétil. Rola rente ao
## chão e, quando o chão acaba (borda do palco), cai e some. Lançado no ar, voa reto.
## Arte: assets/characters/beija_flor/pixel/skate.png (2 quadros, mesmo skate do parado, 31 px).

const FLOOR_PROBE := 70.0
const SHEET := "res://assets/characters/beija_flor/pixel/skate.png"
const PX := 2.0   # mesma escala de pixel do lutador

var _tex: Texture2D
var _n := 2

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
	p.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	if ResourceLoader.exists(SHEET):
		p._tex = load(SHEET)
		p._n = Projectile.strip_frames(p._tex)
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
	if _tex == null:
		return
	var flip := -1.0 if velocity.x < 0.0 else 1.0
	var tilt := 0.0 if needs_floor else sin(_spin * 14.0) * 0.25
	draw_set_transform(Vector2.ZERO, tilt * flip, Vector2(flip, 1.0))
	var w := float(_tex.get_width()) / float(_n)
	var h := float(_tex.get_height())
	var f := int(_spin * 12.0) % maxi(1, _n)   # rodinhas girando
	var size := Vector2(w, h) * PX
	draw_texture_rect_region(_tex, Rect2(-size * 0.5, size), Rect2(f * w, 0, w, h))
	draw_set_transform(Vector2.ZERO)
