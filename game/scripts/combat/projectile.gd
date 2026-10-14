class_name Projectile
extends Node2D
## Projétil genérico: anda em linha reta, acerta o primeiro lutador que não é o dono
## e some. Quem cria define dados do golpe, dono, velocidade e vida útil.

var data: AttackData
var owner_fighter: Fighter
var velocity := Vector2.ZERO
var lifetime := 1.2
var color := Color.WHITE


## Cria o projétil como filho do pai do dono e o posiciona. Retorna o projétil.
static func spawn(scene: PackedScene, owner_f: Fighter, attack_data: AttackData, at: Vector2, vel: Vector2, life: float) -> Projectile:
	var p := scene.instantiate() as Projectile
	p.data = attack_data
	p.owner_fighter = owner_f
	p.velocity = vel
	p.lifetime = life
	p.color = owner_f.body_color.lightened(0.35)
	p.add_to_group("match_cleanup")  # a revanche limpa projéteis que sobraram
	owner_f.get_parent().add_child(p)
	p.global_position = at
	return p


func _physics_process(delta: float) -> void:
	global_position += velocity * delta
	lifetime -= delta
	if lifetime <= 0.0 or absf(global_position.x) > 2400.0 or absf(global_position.y) > 1600.0:
		queue_free()
		return
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == null or target == owner_fighter or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(global_position, data.hitbox_radius, target.hurtbox()):
			var travel := 1 if velocity.x >= 0.0 else -1
			target.receive_hit(owner_fighter, data, travel)
			queue_free()
			return


func _draw() -> void:
	var r := data.hitbox_radius if data else 12.0
	draw_circle(Vector2.ZERO, r, color)
	draw_arc(Vector2.ZERO, r, 0.0, TAU, 20, Color.WHITE, 2.0)
