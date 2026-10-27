class_name Projectile
extends Node2D
## Projétil genérico: anda em linha reta, acerta o primeiro lutador que não é o dono
## e some. Quem cria define dados do golpe, dono, velocidade e vida útil.
## Ganchos: ao acertar chama owner_fighter._on_projectile_hit(alvo, p), o MoveFx do
## dono (regra "proj_hit") e on_hit (Callable opcional); hit_fx toca um efeito do
## dono no alvo. Sinais: landed_still (acabaram os quiques no chão sem acertar
## ninguém) e expired (acabou a vida no ar).

signal landed_still(p: Projectile)
signal expired(p: Projectile)

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
## Arco: gravidade (px/s²) e quiques no chão/plataforma antes de sumir (0 = linha reta).
var gravity := 0.0
var bounces := 0
var _return_speed := 0.0
## Efeito (fx_* do dono) tocado no alvo ao acertar; "" = nenhum.
var hit_fx := ""
var hit_fx_px := 2.0
## Chamado com o alvo depois de um acerto (ex.: areia do Calango cega).
var on_hit := Callable()
## Desenho por código quando não há sprite: "" (círculo), "pipoca", "areia".
var look := ""
## Lentidão (bolha de moleza): quem quer deixar o projétil lento faz
## slow_factor = minf(slow_factor, x) a cada quadro; volta sozinho a 1.0.
var slow_factor := 1.0


## Cria o projétil como filho do pai do dono e o posiciona. Retorna o projétil.
static func spawn(scene: PackedScene, owner_f: Fighter, attack_data: AttackData, at: Vector2, vel: Vector2, life: float) -> Projectile:
	var p := scene.instantiate() as Projectile
	p.data = attack_data
	p.owner_fighter = owner_f
	p.velocity = vel
	p.lifetime = life
	p.color = owner_f.body_color.lightened(0.35)
	p.add_to_group("match_cleanup")  # a revanche limpa projéteis que sobraram
	p.add_to_group("projectiles")
	owner_f.get_parent().add_child(p)
	p.global_position = at
	return p


## Quantos quadros tem a tira (animacoes.json da pasta; sem ele, quadros de 64).
## Personagens com MARGEM no importador têm quadros mais largos que 64.
static func strip_frames(tex: Texture2D) -> int:
	var path := tex.resource_path
	var meta_path := path.get_base_dir().path_join("animacoes.json")
	var key := path.get_file().get_basename()
	if FileAccess.file_exists(meta_path):
		var meta = JSON.parse_string(FileAccess.get_file_as_string(meta_path))
		if meta is Dictionary and meta.has(key):
			return maxi(1, int(meta[key].get("quadros", 1)))
	return maxi(1, tex.get_width() / 64)


## Usa uma tira de pixel art no lugar do círculo provisório.
func set_sprite(tex: Texture2D, scale_px := 2.0) -> void:
	sprite = tex
	sprite_scale = scale_px
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_frames.clear()
	var img := tex.get_image()
	var n := strip_frames(tex)
	var fw := tex.get_width() / n
	for i in n:
		var used := img.get_region(Rect2i(i * fw, 0, fw, tex.get_height())).get_used_rect()
		if used.size != Vector2i.ZERO:
			_frames.append(Rect2(used.position + Vector2i(i * fw, 0), used.size))
	queue_redraw()


## Como set_sprite, mas com a largura NA TELA fixa (px) a partir do 1º quadro:
## resolve folha que veio grande/pequena sem depender do gerador acertar o tamanho.
func set_sprite_fit(tex: Texture2D, width_px: float) -> void:
	set_sprite(tex, 2.0)
	if not _frames.is_empty() and _frames[0].size.x > 0.0:
		sprite_scale = width_px / _frames[0].size.x


func _process(delta: float) -> void:
	_age += delta
	queue_redraw()


func _physics_process(delta: float) -> void:
	delta *= clampf(slow_factor, 0.05, 1.0)   # tempo, gravidade e voo andam juntos
	slow_factor = 1.0
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
	if gravity > 0.0:
		velocity.y += gravity * delta
		var to := global_position + velocity * delta
		if velocity.y > 0.0:
			var q := PhysicsRayQueryParameters2D.create(global_position, to + Vector2(0, 6), Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
			var hit := get_world_2d().direct_space_state.intersect_ray(q)
			if not hit.is_empty():
				if bounces <= 0:
					global_position = hit["position"] - Vector2(0, 6)
					landed_still.emit(self)
					queue_free()
					return
				bounces -= 1
				global_position = hit["position"] - Vector2(0, 6)
				velocity.y = -absf(velocity.y) * 0.6
				velocity.x *= 0.85
				return
	global_position += velocity * delta
	lifetime -= delta
	if lifetime <= 0.0 or absf(global_position.x) > 2400.0 or absf(global_position.y) > 1600.0:
		expired.emit(self)
		queue_free()
		return
	# Faixa "Interditado" da Dona Onça segura projéteis dos outros.
	for n in get_tree().get_nodes_in_group("faixas"):
		if n.has_method("blocks_projectile") and n.blocks_projectile(self):
			n.on_projectile_blocked(self)
			queue_free()
			return
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == null or target == owner_fighter or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(global_position, data.hitbox_radius, target.hurtbox()):
			var travel := 1 if velocity.x >= 0.0 else -1
			if target.receive_hit(owner_fighter, data, travel):
				_on_landed_hit(target)
			queue_free()
			return


func _on_landed_hit(target: Fighter) -> void:
	if owner_fighter == null or not is_instance_valid(owner_fighter):
		return
	if owner_fighter.has_method("_on_projectile_hit"):
		owner_fighter._on_projectile_hit(target, self)
	if owner_fighter.move_fx != null:
		owner_fighter.move_fx.on_proj_hit(target, self)
		if hit_fx != "":
			owner_fighter.move_fx.play(hit_fx, "target", target, hit_fx_px, false, 0.3)
	if on_hit.is_valid():
		on_hit.call(target)


func _draw() -> void:
	if sprite and not _frames.is_empty():
		var src: Rect2 = _frames[int(_age * spin_fps) % _frames.size()]
		var size := src.size * sprite_scale
		var flip := -1.0 if velocity.x < 0.0 else 1.0
		draw_set_transform(Vector2.ZERO, 0.0, Vector2(flip, 1.0))
		draw_texture_rect_region(sprite, Rect2(-size * 0.5, size), src)
		draw_set_transform(Vector2.ZERO)
		return
	match look:
		"pipoca":
			# pipoca estourada: 3 bolinhas creme com contorno, girando
			var a := _age * 9.0
			for k in 3:
				draw_circle(Vector2.from_angle(a + k * TAU / 3.0) * 4.0, 6.5, Color("2a0f12"))
			for k in 3:
				draw_circle(Vector2.from_angle(a + k * TAU / 3.0) * 4.0, 5.0, Color("fff4d6"))
			draw_circle(Vector2(1, 1), 2.0, Color("e8b83a"))
			return
		"areia":
			# punhado de areia: grãos que se abrem em leque achatado
			var spread := 6.0 + minf(_age, 0.25) * 40.0
			for k in 9:
				var ang := k * 2.399
				var rr := spread * (0.35 + 0.65 * fmod(k * 0.37, 1.0))
				var gp := Vector2(cos(ang) * rr * 1.4, sin(ang) * rr * 0.6)
				draw_rect(Rect2(gp - Vector2(2, 2), Vector2(4, 4)), Color("2a0f12"))
				draw_rect(Rect2(gp - Vector2(1, 1), Vector2(2, 2)), Color("f2dc8c") if k % 3 else Color("c9a24a"))
			return
	var r := data.hitbox_radius if data else 12.0
	draw_circle(Vector2.ZERO, r, color)
	draw_arc(Vector2.ZERO, r, 0.0, TAU, 20, Color.WHITE, 2.0)
