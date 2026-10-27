class_name FaixaInterditada
extends Node2D
## Faixa "Interditado!" da Dona Onça (especial para baixo): dois cones com uma fita
## zebrada entre eles, fincados no chão de palco. É a única BARREIRA do jogo:
##  - adversário no chão não atravessa andando (tem que pular por cima);
##  - projéteis dos outros param nela;
##  - conta como TRAVE para o gol de peixinho do Tucão (grupo "traves");
##  - 2 golpes do adversário rasgam a fita; some sozinha em LIFETIME s.
## Desenhada por código enquanto a folha faixa_interditado.png (4 quadros: 0-2
## balançando, 3 rasgando) não chega.

const LIFETIME := 6.0
const WIDTH := 150.0
const TALL := 50.0
const HITS := 2
const MIN_GAP := 120.0           # distância de estandarte, cama elástica e castanha
const RIP_TIME := 0.4
const SPRITE_PATH := "res://assets/characters/onca/pixel/faixa_interditado.png"
const INK := Color("2a0f12")

var owner_fighter: Fighter
var _age := 0.0
var _hp := HITS
var _hit_cooldown := 0.0
var _rip := -1.0                 # >= 0: rasgando
var _wobble := 0.0
var _tex: Texture2D


## Finca a faixa em `at` (ponto no chão). Só em chão de palco (LAYER_STAGE); sem
## chão embaixo não finca e retorna null. Afasta-se de outros objetos de chão.
static func plant(by: Fighter, at: Vector2) -> FaixaInterditada:
	var space := by.get_world_2d().direct_space_state
	var spot := at
	for other in by.get_tree().get_nodes_in_group("estandartes") + by.get_tree().get_nodes_in_group("camas_elasticas") \
			+ by.get_tree().get_nodes_in_group("castanhas_enterradas"):
		var o := other as Node2D
		if o != null and absf(o.global_position.x - spot.x) < MIN_GAP and absf(o.global_position.y - spot.y) < 80.0:
			spot.x = o.global_position.x + MIN_GAP * (1.0 if spot.x >= o.global_position.x else -1.0)
	var q := PhysicsRayQueryParameters2D.create(spot + Vector2(0, -40), spot + Vector2(0, 60), Fighter.LAYER_STAGE)
	var hit := space.intersect_ray(q)
	if hit.is_empty():
		return null
	var f := FaixaInterditada.new()
	f.owner_fighter = by
	f.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	f.add_to_group("match_cleanup")
	f.add_to_group("faixas")
	f.add_to_group("traves")
	by.get_parent().add_child(f)
	by.get_parent().move_child(f, by.get_index())
	f.global_position = hit.position
	return f


func _ready() -> void:
	if ResourceLoader.exists(SPRITE_PATH):
		_tex = load(SPRITE_PATH)


func is_up() -> bool:
	return _rip < 0.0


## Caixa da fita (mundo): usada pela trave do Tucão.
func trave_rect() -> Rect2:
	return Rect2(global_position + Vector2(-WIDTH * 0.5, -TALL), Vector2(WIDTH, TALL))


func blocks_projectile(p: Node2D) -> bool:
	if not is_up() or p.get("owner_fighter") == owner_fighter:
		return false
	var r: float = p.data.hitbox_radius if p.get("data") != null else 8.0
	return Combat.circle_hits_rect(p.global_position, r, trave_rect())


func on_projectile_blocked(_p: Node2D) -> void:
	_wobble = 1.0


func rip() -> void:
	if _rip < 0.0:
		_rip = 0.0


func _physics_process(delta: float) -> void:
	_age += delta
	_hit_cooldown = maxf(_hit_cooldown - delta, 0.0)
	_wobble = maxf(_wobble - delta * 3.0, 0.0)
	queue_redraw()
	if _rip >= 0.0:
		_rip += delta
		if _rip >= RIP_TIME:
			queue_free()
		return
	if _age >= LIFETIME or owner_fighter == null or not is_instance_valid(owner_fighter):
		rip()
		return
	var box := trave_rect()
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == owner_fighter:
			continue
		# Golpe do adversário encostando na fita: rasga aos poucos.
		if _hit_cooldown <= 0.0 and f.attack != null and f.attack.is_active(f.attack_frame) \
				and Combat.circle_hits_rect(f.hitbox_center(f.attack), f.attack.hitbox_radius, box):
			_hp -= 1
			_hit_cooldown = 0.3
			_wobble = 1.0
			if _hp <= 0:
				rip()
				return
		# Barreira: com os pés abaixo do topo da fita, não entra na faixa.
		if f.state in [Fighter.State.HELD, Fighter.State.LEDGE, Fighter.State.RESPAWN]:
			continue
		var feet := f.global_position.y + Fighter.HEIGHT * 0.5
		if feet <= box.position.y + 6.0 or feet > global_position.y + 30.0:
			continue
		var half := WIDTH * 0.5 + Fighter.RADIUS
		var dx := f.global_position.x - global_position.x
		if absf(dx) < half:
			var side := 1.0 if dx >= 0.0 else -1.0
			f.global_position.x = global_position.x + side * half
			if signf(f.velocity.x) == -side:
				f.velocity.x = 0.0
			if f._launch.x * side < 0.0:
				f._launch.x = 0.0
			_wobble = maxf(_wobble, 0.5)


func _draw() -> void:
	var half := WIDTH * 0.5
	if _tex != null:
		var n := maxi(1, _tex.get_width() / 64)
		var i := (n - 1) if _rip >= 0.0 else int(_age * 6.0) % maxi(1, n - 1)
		draw_set_transform(Vector2.ZERO, 0.0, Vector2(2, 2))
		draw_texture_rect_region(_tex, Rect2(-32, -61, 64, 64), Rect2(i * 64, 0, 64, 64))
		draw_set_transform(Vector2.ZERO)
		return
	var fade := 1.0
	if _rip >= 0.0:
		fade = 1.0 - _rip / RIP_TIME
	elif _age > LIFETIME - 1.0 and int(_age * 10.0) % 2 == 0:
		fade = 0.5   # pisca antes de sumir
	modulate.a = fade
	# Cones de trânsito nas pontas (laranja com faixa branca, base escura).
	for sx in [-1.0, 1.0]:
		var cx: float = sx * (half - 8.0)
		var cone := PackedVector2Array([Vector2(cx - 12, -4), Vector2(cx + 12, -4), Vector2(cx + 3, -TALL), Vector2(cx - 3, -TALL)])
		draw_colored_polygon(PackedVector2Array([Vector2(cx - 15, -2), Vector2(cx + 15, -2), Vector2(cx + 5, -TALL - 3), Vector2(cx - 5, -TALL - 3)]), INK)
		draw_colored_polygon(cone, Color("ff7a1e"))
		draw_rect(Rect2(cx - 8, -30, 16, 7), Color("f4efe4"))
		draw_rect(Rect2(cx - 18, -6, 36, 6), INK)
		draw_rect(Rect2(cx - 16, -5, 32, 4), Color("4a2a1a"))
	# Fita zebrada amarela/preta entre os cones (cai um pouco no meio e balança).
	var y0 := -TALL + 12.0
	var sway := sin(_age * 30.0) * 4.0 * _wobble
	var pts: Array[Vector2] = []
	for k in 13:
		var t := k / 12.0
		var x := lerpf(-half + 10.0, half - 10.0, t)
		var sag := sin(t * PI) * 6.0 + sin(t * PI) * sway
		pts.append(Vector2(x, y0 + sag))
	if _rip >= 0.0:
		# rasgou: as duas metades caem penduradas nos cones
		var drop := _rip / RIP_TIME
		for k in pts.size():
			var t2 := k / 12.0
			var dist := minf(t2, 1.0 - t2)
			pts[k].y += drop * dist * 70.0
		pts.remove_at(6)
	for k in pts.size() - 1:
		if _rip >= 0.0 and k == 5:
			continue
		var a := pts[k]
		var b := pts[k + 1]
		draw_line(a, b, INK, 12.0)
		draw_line(a, b, Color("ffd21e") if k % 2 == 0 else Color("1e1a18"), 8.0)
