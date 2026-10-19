extends Node
## Teste de fumaça do Maracajá: arte importada, golpes básicos com acerto e os
## especiais (espreita carregável, bote que prende e arremessa, salto de parede
## em dois impulsos, arranha-chão) e o grude na parede com pulo dela.
##   godot --headless --path game res://tests/maracaja_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")

var results: Array[String] = []
var failures := 0
var cat: Fighter
var foe: Fighter


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var idx := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i].get("id", "") == "maracaja":
			idx = i
	_check("Maracajá está no elenco jogável", idx >= 0, str(idx))
	if idx < 0:
		_finish()
		return
	Game.set_character("p1", idx)
	Game.set_character("p2", 0)
	var m := MATCH.instantiate()
	add_child(m)
	await _frames(240)
	for f in m.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			cat = f
		else:
			foe = f
	_check("P1 é o Maracajá com arte", cat is Maracaja and cat.has_art, "%s" % cat)
	await _run()
	_finish()


func _finish() -> void:
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	var vis := cat.get_node("Visual")
	for a in ["parado", "andar", "correr", "pulo", "jab", "jab_b", "jab_c", "golpe_frente", "defesa_esquiva", "dor"]:
		if not vis.has_anim(a):
			_check("Animação %s importada" % a, false, "")
	_check("Animações do lote 1 importadas", true, "")

	# Golpes básicos acertam o boneco
	for mv in ["jab", "ftilt", "utilt", "dtilt"]:
		await _face_off()
		var before := foe.damage_percent
		cat.start_attack(mv)
		await _frames(40)
		_check("%s acerta" % mv, foe.damage_percent > before, "%.1f%%" % foe.damage_percent)

	# Espreita: carregar mais vai mais longe
	var d_short := await _leap(0)
	var d_long := await _leap(40)
	_check("Espreita carregada salta mais longe", d_long > d_short + 120.0, "%.0f x %.0f px" % [d_short, d_long])

	# Bote prende e arremessa
	await _face_off(120.0)
	foe.damage_percent = 0.0
	cat.start_special("side")
	var held := false
	for i in 60:
		await get_tree().physics_frame
		if foe.state == Fighter.State.HELD:
			held = true
	await _frames(60)
	_check("Bote prende o adversário", held, Fighter.State.keys()[foe.state])
	_check("Bote arremessa com dano", foe.damage_percent >= 8.0, "%.1f%%" % foe.damage_percent)

	# Salto de parede: dois impulsos para cima
	await _place(cat, Vector2(-200, -300))
	cat.start_special("up")
	var y0 := cat.global_position.y
	var impulses := 0
	var last_vy := 0.0
	for i in 40:
		await get_tree().physics_frame
		if cat.velocity.y < -800.0 and last_vy > -800.0:
			impulses += 1
		last_vy = cat.velocity.y
	_check("Salto de parede dá dois impulsos", impulses >= 2, "%d impulsos, subiu %.0f px" % [impulses, y0 - cat.global_position.y])
	await _frames(90)

	# Arranha-chão acerta dos dois lados
	for side in [-1, 1]:
		await _face_off()
		foe.global_position = cat.global_position + Vector2(55 * side, 0)
		var b := foe.damage_percent
		cat.start_special("down")
		await _frames(30)
		_check("Arranha-chão acerta do lado %s" % ("esquerdo" if side < 0 else "direito"), foe.damage_percent > b, "")

	# Gruda numa parede (de teste, alta) e pula dela
	var wall := StaticBody2D.new()
	wall.collision_layer = 1
	var ws := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(60, 600)
	ws.shape = rect
	wall.add_child(ws)
	wall.global_position = Vector2(900, -400)
	add_child(wall)
	await _place(cat, Vector2(1000, -500), -1)
	Input.action_press("p1_left")
	var clung := false
	for i in 60:
		await get_tree().physics_frame
		if (cat as Maracaja).is_clinging():
			clung = true
			break
	Input.action_release("p1_left")
	_check("Gruda na lateral do palco", clung, "x=%.0f y=%.0f" % [cat.global_position.x, cat.global_position.y])
	if clung:
		Input.action_press("p1_jump")
		await _frames(3)
		Input.action_release("p1_jump")
		await _frames(6)
		_check("Pula da parede para longe dela e para cima", cat.velocity.y < 0.0 and cat.velocity.x > 0.0, str(cat.velocity))
	wall.queue_free()


func _leap(charge_frames: int) -> float:
	await _face_off(0.0)
	foe.global_position = Vector2(3000, -3000)
	var x0 := cat.global_position.x
	Input.action_press("p1_special")
	cat.start_special("neutral")
	await _frames(6 + charge_frames)
	Input.action_release("p1_special")
	await _frames(45)
	return absf(cat.global_position.x - x0)


func _stage_right_edge() -> float:
	var best := -INF
	for l in get_tree().get_nodes_in_group("ledges"):
		best = maxf(best, (l as Node2D).global_position.x)
	return best


func _face_off(gap := 70.0) -> void:
	await _place(cat, Vector2(-200, -60), 1)
	await _place(foe, Vector2(-200 + gap, -60), -1)
	await _frames(20)


func _place(f: Fighter, pos: Vector2, face := 1) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstop = 0
	f._hitstun = 0.0
	f.state = Fighter.State.AIR
	f.facing = face
	f.damage_percent = 0.0
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1
