extends Node
## Teste de fumaça do combate (T09 e T10): acerto, dano %, lançamento que cresce
## com o dano, peso, pausa no impacto, atordoamento, aéreo com aterrissagem e
## especial para cima sem pulo depois. Salva screenshots em evidence/etapa-2/.
##   godot --path game res://tests/combat_smoke.tscn

const MAIN := preload("res://scenes/main.tscn")

var results: Array[String] = []
var failures := 0
var p1: Fighter
var p2: Fighter
var evidence_dir := ""


func _ready() -> void:
	evidence_dir = ProjectSettings.globalize_path("res://").path_join("../evidence/etapa-2")
	DirAccess.make_dir_recursive_absolute(evidence_dir)
	var main := MAIN.instantiate()
	add_child(main)
	p1 = main.get_node("P1")
	p2 = main.get_node("P2")
	await _run()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	# Fórmula pura
	var ftilt := p1.moveset.ftilt
	var low := Combat.launch_speed(ftilt, 10.0, 100.0)
	var high := Combat.launch_speed(ftilt, 100.0, 100.0)
	_check("Fórmula: mais dano, lançamento maior", high > low, "%.0f -> %.0f" % [low, high])
	_check("Fórmula: mais peso, lançamento menor", Combat.launch_speed(ftilt, 100.0, 125.0) < high, "")
	_check("Fórmula: base quando dano é 0", is_equal_approx(Combat.launch_speed(ftilt, 0.0, 100.0), ftilt.base_knockback), "")

	await _frames(40)
	await _face_off(0.0)
	await _tap("p1_attack")
	await _frames(6)
	_check("Golpe rápido acerta e soma dano", is_equal_approx(p2.damage_percent, p1.moveset.jab.damage), "%.1f%%" % p2.damage_percent)
	_check("Quem apanha fica atordoado", p2.state == Fighter.State.HITSTUN, Fighter.State.keys()[p2.state])

	# Pausa no impacto: logo após o acerto, os dois ficam congelados alguns quadros
	await _face_off(0.0)
	Input.action_press("p1_right")
	await _tap("p1_attack")
	Input.action_release("p1_right")
	var froze := false
	for i in 20:
		await get_tree().physics_frame
		if p2.state == Fighter.State.HITSTUN and p2._hitstop > 0 and p1._hitstop > 0:
			froze = true
			await _shot("05-golpe-forte")
			break
	_check("Pausa no impacto nos dois lutadores", froze, "")

	var dist_low := await _launch_distance(0.0)
	var dist_high := await _launch_distance(100.0)
	_check("Com mais dano o mesmo golpe lança mais longe", dist_high > dist_low * 1.5, "0%%: %.0f px, 100%%: %.0f px" % [dist_low, dist_high])

	# Aéreo que pousa no meio do golpe gera tempo de aterrissagem
	await _place(p1, Vector2(-400, -56), 1)
	await _place(p2, Vector2(400, -56), -1)
	Input.action_press("p1_jump")
	await _frames(2)
	Input.action_release("p1_jump")
	await _frames(4)
	Input.action_press("p1_down")
	await _tap("p1_attack")
	Input.action_release("p1_down")
	var saw_lag := false
	for i in 60:
		await get_tree().physics_frame
		if p1.state == Fighter.State.LAG:
			saw_lag = true
			break
	_check("Aéreo interrompido no chão gera aterrissagem", saw_lag, Fighter.State.keys()[p1.state])

	# Especial para cima: sobe e fica sem pulo até pousar
	await _place(p1, Vector2(0, -56), 1)
	var y0 := p1.global_position.y
	Input.action_press("p1_up")
	await _tap("p1_special")
	Input.action_release("p1_up")
	var top := y0
	for i in 30:
		await get_tree().physics_frame
		top = minf(top, p1.global_position.y)
	_check("Especial para cima sobe", y0 - top > 150, "%.0f px" % (y0 - top))
	var waited := 0
	while p1.state == Fighter.State.ATTACK and waited < 60:
		await get_tree().physics_frame
		waited += 1
	var airborne := not p1.is_on_floor()
	var jumps_before := p1.jumps_left
	await _tap("p1_jump")
	_check("Depois do especial para cima fica sem pulo no ar", airborne and p1.helpless and p1.jumps_left == jumps_before and p1.velocity.y > 0.0,
		"no ar=%s helpless=%s estado=%s y=%.0f" % [airborne, p1.helpless, Fighter.State.keys()[p1.state], p1.global_position.y])
	var landed := false
	for i in 90:
		await get_tree().physics_frame
		if p1.is_on_floor() and p1.state != Fighter.State.ATTACK:
			landed = true
			break
	_check("Ao pousar volta a poder pular", landed and not p1.helpless, "")


## Coloca os dois lutadores lado a lado no centro, P2 com o dano indicado.
func _face_off(p2_damage: float) -> void:
	await _place(p1, Vector2(-70, -56), 1)
	await _place(p2, Vector2(0, -56), -1)
	p2.damage_percent = p2_damage


func _place(f: Fighter, pos: Vector2, face: int) -> void:
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstop = 0
	f._hitstun = 0.0
	f.state = Fighter.State.AIR
	f.facing = face
	await _frames(8)


func _launch_distance(p2_damage: float) -> float:
	await _face_off(p2_damage)
	var x0 := p2.global_position.x
	Input.action_press("p1_right")
	await _tap("p1_attack")
	Input.action_release("p1_right")
	var far := 0.0
	for i in 50:
		await get_tree().physics_frame
		far = maxf(far, p2.global_position.x - x0)
	return far


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _tap(action: String, strength := 1.0, hold := 2) -> void:
	Input.action_press(action, strength)
	await _frames(hold)
	Input.action_release(action)
	await _frames(1)


func _shot(name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return  # sem renderização não há screenshot
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	img.save_png(evidence_dir.path_join(name + ".png"))
