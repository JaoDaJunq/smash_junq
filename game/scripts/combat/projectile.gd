class_name Projectile
extends Node2D
## Projétil genérico: anda em linha reta, acerta o primeiro lutador que não é o dono
## e some. Quem cria define dados do golpe, dono, velocidade e vida útil.

var data: AttackData
var owner_fighter: Fighter
var velocity := Vector2.ZERO
var lifetime := 1.2
var color := Color.WHITE
## Sprite opcional (tira de quadros 64x64 do importador, ex.: castanha do Juba).
## Sem sprite, desenha o círculo provisório.
var sprite: Texture2D
var sprite_scale := 2.0
var spin_fps := 14.0
var _frames: Array[Rect2] = []   # recorte de cada quadro (só a parte desenhada)
var _age := 0.0
## Bumerangue: depois deste tempo (s) volta para o dono e some ao chegar (-1 = não volta).
var return_after := -1.0
var _flight := 0.0
var _return_speed := 0.0


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


## Usa uma tira de pixel art no lugar do círculo provisório.
func set_sprite(tex: Texture2D, scale_px := 2.0) -> void:
	sprite = tex
	sprite_scale = scale_px
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_frames.clear()
	var img := tex.get_image()
	for i in maxi(1, tex.get_width() / 64):
		var used := img.get_region(Rect2i(i * 64, 0, 64, 64)).get_used_rect()
		if used.size != Vector2i.ZERO:
			_frames.append(Rect2(used.position + Vector2i(i * 64, 0), used.size))
	queue_redraw()


func _process(delta: float) -> void:
	if sprite:
		_age += delta
		queue_redraw()


func _physics_process(delta: float) -> void:
	_flight += delta
	if return_after >= 0.0 and _flight >= return_after and owner_fighter != null and is_instance_valid(owner_fighter):
		var to_owner := owner_fighter.global_position + Vector2(0, -20) - global_position
		if to_owner.length() < 40.0:
			queue_free()
			return
		if _return_speed <= 0.0:
			_return_speed = velocity.length()
		velocity = velocity.move_toward(to_owner.normalized() * _return_speed, 4000.0 * delta)
		lifetime = maxf(lifetime, 0.2)
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
	if sprite and not _frames.is_empty():
		var src: Rect2 = _frames[int(_age * spin_fps) % _frames.size()]
		var size := src.size * sprite_scale
		var flip := -1.0 if velocity.x < 0.0 else 1.0
		draw_set_transform(Vector2.ZERO, 0.0, Vector2(flip, 1.0))
		draw_texture_rect_region(sprite, Rect2(-size * 0.5, size), src)
		draw_set_transform(Vector2.ZERO)
		return
	var r := data.hitbox_radius if data else 12.0
	draw_circle(Vector2.ZERO, r, color)
	draw_arc(Vector2.ZERO, r, 0.0, TAU, 20, Color.WHITE, 2.0)
