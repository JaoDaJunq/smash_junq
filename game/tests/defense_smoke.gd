extends Node
## Teste de fumaça da defesa e do agarrão (T14 e T15): escudo bloqueia, desgasta e
## quebra; rolagem e esquiva aérea sem poder ser atingido; agarrão vence escudo e
## perde para ataque; golpe segurando, arremessos e soltar com o tempo.
##   godot --path game res://tests/defense_smoke.tscn

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
	await _frames(40)

	# Escudo bloqueia: sem dano %, escudo desgasta
	await _face_off()
	Input.action_press("p2_shield")
	await _frames(4)
	var hp_before := p2.shield_hp
	Input.action_press("p1_right")
	await _tap("p1_attack")
	Input.action_release("p1_right")
	await _frames(14)
	await _shot("06-escudo")
	_check("Escudo bloqueia o golpe (sem dano %)", p2.damage_percent == 0.0 and p2.state == Fighter.State.SHIELD, "%.1f%% %s" % [p2.damage_percent, Fighter.State.keys()[p2.state]])
	_check("Golpe desgasta o escudo", p2.shield_hp < hp_before - 5.0, "%.1f -> %.1f" % [hp_before, p2.shield_hp])
	Input.action_release("p2_shield")
	await _frames(10)

	# Escudo quebra
	await _face_off()
	p2.shield_hp = 2.0
	Input.action_press("p2_shield")
	await _frames(20)
	_check("Escudo vazio quebra e atordoa", p2.state == Fighter.State.SHIELD_BREAK, Fighter.State.keys()[p2.state])
	Input.action_release("p2_shield")
	await _frames(int(p2.shield_break_time * 60.0) + 40)
	_check("Depois da quebra volta a agir", p2.state == Fighter.State.IDLE and p2.shield_hp > 0.0, Fighter.State.keys()[p2.state])

	# Rolagem: desloca e fica intocável no meio
	await _face_off()
	var x0 := p2.global_position.x
	Input.action_press("p2_shield")
	await _frames(3)
	await _tap("p2_left")
	Input.action_release("p2_shield")
	await _frames(6)
	_check("Rolagem fica intocável no meio", p2.state == Fighter.State.DODGE and not p2.can_be_hit(), Fighter.State.keys()[p2.state])
	await _frames(30)
	_check("Rolagem desloca o lutador", absf(p2.global_position.x - x0) > 100.0, "%.0f px" % absf(p2.global_position.x - x0))

	# Esquiva aérea: intocável e aterrissagem
	await _place(p1, Vector2(-400, -56), 1)
	Input.action_press("p1_jump")
	await _frames(8)
	Input.action_release("p1_jump")
	await _tap("p1_shield")
	await _frames(3)
	_check("Esquiva aérea fica intocável", p1.state == Fighter.State.DODGE and not p1.can_be_hit(), Fighter.State.keys()[p1.state])
	await _frames(40)
	_check("Só uma esquiva aérea por pulo, e pousa normalmente", p1.is_on_floor(), Fighter.State.keys()[p1.state])

	# Agarrão vence escudo
	await _face_off()
	Input.action_press("p2_shield")
	await _frames(4)
	await _tap("p1_grab")
	await _frames(grab_wait())
	_check("Agarrão passa pelo escudo", p1.state == Fighter.State.HOLDING and p2.state == Fighter.State.HELD, "%s / %s" % [Fighter.State.keys()[p1.state], Fighter.State.keys()[p2.state]])
	await _shot("07-agarrao")
	Input.action_release("p2_shield")

	# Golpe segurando
	await _tap("p1_attack")
	await _frames(5)
	_check("Golpe rápido segurando soma dano", is_equal_approx(p2.damage_percent, p1.pummel_damage), "%.1f%%" % p2.damage_percent)

	# Arremesso para frente
	var x_before := p2.global_position.x
	await _tap("p1_right")
	await _frames(30)
	_check("Arremesso para frente lança e causa dano", p2.global_position.x - x_before > 30.0 and p2.damage_percent > p1.pummel_damage, "%.0f px, %.1f%%" % [p2.global_position.x - x_before, p2.damage_percent])

	# Arremesso para trás
	await _face_off()
	await _tap("p1_grab")
	await _frames(grab_wait())
	x_before = p2.global_position.x
	await _tap("p1_left")
	await _frames(30)
	_check("Arremesso para trás lança para o outro lado", p2.global_position.x < x_before - 30.0, "%.0f px" % (p2.global_position.x - x_before))

	# Soltar sozinho com o tempo, mais rápido apertando botões
	await _face_off()
	await _tap("p1_grab")
	await _frames(grab_wait())
	var held_frames := 0
	while p2.state == Fighter.State.HELD and held_frames < 400:
		await get_tree().physics_frame
		held_frames += 1
	await _face_off()
	await _tap("p1_grab")
	await _frames(grab_wait())
	var mashed_frames := 0
	while p2.state == Fighter.State.HELD and mashed_frames < 400:
		Input.action_press("p2_jump")
		await get_tree().physics_frame
		Input.action_release("p2_jump")
		await get_tree().physics_frame
		mashed_frames += 2
	_check("Solta sozinho com o tempo", held_frames < 400 and p1.state == Fighter.State.IDLE, "%d quadros" % held_frames)
	_check("Apertar botões solta mais rápido", mashed_frames < held_frames, "%d < %d quadros" % [mashed_frames, held_frames])

	# Ataque vence agarrão: P1 dá golpe rápido enquanto P2 tenta agarrar
	await _face_off()
	await _tap("p2_grab")
	await _tap("p1_attack")
	await _frames(12)
	_check("Ataque interrompe o agarrão", p2.damage_percent > 0.0 and p1.state != Fighter.State.HELD and p2.state != Fighter.State.HOLDING, "P2 %.1f%%, P1 %s" % [p2.damage_percent, Fighter.State.keys()[p1.state]])


func grab_wait() -> int:
	return p1.grab_startup + p1.grab_active + 2


func _face_off() -> void:
	await _place(p1, Vector2(-70, -56), 1)
	await _place(p2, Vector2(0, -56), -1)
	p1.damage_percent = 0.0
	p2.damage_percent = 0.0
	p1.shield_hp = p1.shield_max
	p2.shield_hp = p2.shield_max


func _place(f: Fighter, pos: Vector2, face: int) -> void:
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
	await _frames(8)


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
