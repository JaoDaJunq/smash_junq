extends Node
## Teste de fumaça do movimento (T05 a T08). Simula entradas do Jogador 1, confere
## estados e posições e salva screenshots em evidence/etapa-2/.
## Rodar com janela (screenshots precisam de renderização), a partir da raiz do repo:
##   godot --path game res://tests/movement_smoke.tscn

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
	await _frames(60)
	_check("Pousa na plataforma flutuante", p1.is_on_floor() and absf(p1.global_position.y - (-210 - 55)) < 4, p1.global_position)
	await _shot("01-inicio")

	await _tap("p1_down")
	await _frames(45)
	_check("Desce da plataforma atravessável até o palco", p1.is_on_floor() and absf(p1.global_position.y - (-55)) < 4, p1.global_position)

	var x0 := p1.global_position.x
	Input.action_press("p1_right", 0.6)
	await _frames(20)
	_check("Inclinação parcial anda", p1.state == Fighter.State.WALK and p1.global_position.x > x0, Fighter.State.keys()[p1.state])
	Input.action_release("p1_right")
	await _frames(15)

	await _tap("p1_right", 0.6, 3)
	await _frames(3)
	Input.action_press("p1_right", 0.6)
	await _frames(12)
	_check("Toque duplo corre", p1.state == Fighter.State.RUN, Fighter.State.keys()[p1.state])
	Input.action_release("p1_right")
	await _frames(20)

	Input.action_press("p1_left", 1.0)
	await _frames(6)
	_check("Alavanca empurrada rápido corre", p1.state == Fighter.State.RUN, Fighter.State.keys()[p1.state])
	Input.action_release("p1_left")
	await _frames(25)

	# Pulos testados no centro do palco, longe das plataformas flutuantes.
	p1.global_position = Vector2(0, -56)
	p1.velocity = Vector2.ZERO
	await _frames(10)
	var ground_y := p1.global_position.y
	Input.action_press("p1_jump")
	var peak := ground_y
	for i in 40:
		await get_tree().physics_frame
		peak = minf(peak, p1.global_position.y)
	Input.action_release("p1_jump")
	_check("Pulo completo sobe ~180 px", ground_y - peak > 150, "%.0f px" % (ground_y - peak))
	await _frames(40)

	Input.action_press("p1_jump")
	await _frames(2)
	Input.action_release("p1_jump")
	var short_peak := ground_y
	for i in 40:
		await get_tree().physics_frame
		short_peak = minf(short_peak, p1.global_position.y)
	_check("Pulo curto sobe menos que o completo", ground_y - short_peak < (ground_y - peak) * 0.6, "%.0f px" % (ground_y - short_peak))
	await _frames(30)

	Input.action_press("p1_jump")
	await _frames(15)
	Input.action_release("p1_jump")
	await _frames(5)
	await _tap("p1_jump")
	_check("Pulo duplo gasta o pulo extra", p1.jumps_left == 0 and p1.velocity.y < 0, "pulos restantes %d" % p1.jumps_left)
	await _shot("02-pulo-duplo")
	# Espera passar do auge do pulo duplo antes de apertar para baixo.
	while p1.velocity.y < 0.0:
		await get_tree().physics_frame
	await _frames(3)
	await _tap("p1_down")
	await _frames(2)
	_check("Queda rápida após o auge", p1.fast_falling, "vel.y %.0f" % p1.velocity.y)
	await _frames(40)

	p1.global_position = Vector2(-610, -60)
	p1.velocity = Vector2.ZERO
	p1.state = Fighter.State.AIR
	await _frames(30)
	_check("Agarra a borda esquerda", p1.state == Fighter.State.LEDGE, Fighter.State.keys()[p1.state])
	await _shot("03-borda")
	await _tap("p1_up")
	await _frames(20)
	_check("Sobe da borda para o palco", p1.is_on_floor() and p1.global_position.x > -560, p1.global_position)

	p2.global_position = Vector2(300, 1500)
	await _frames(2)
	_check("Fora da arena volta ao ponto inicial (provisório)", p2.global_position.distance_to(p2.spawn_point) < 60, p2.global_position)

	p1.global_position = Vector2(-450, -55)
	p2.global_position = Vector2(1300, -700)
	await _frames(90)
	await _shot("04-camera-afastada")
	var cam: Camera2D = get_viewport().get_camera_2d()
	_check("Câmera afasta para enquadrar os dois", cam.zoom.x < 0.95, "zoom %.2f" % cam.zoom.x)


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
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	img.save_png(evidence_dir.path_join(name + ".png"))
