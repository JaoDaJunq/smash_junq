extends Node
## Teste de fumaça da CPU (T20): aproxima, acerta, nunca fica parada, volta para a
## arena quando é lançada e marca KO num adversário parado.
##   godot --path game res://tests/cpu_smoke.tscn

const MAIN := preload("res://scenes/main.tscn")

var results: Array[String] = []
var failures := 0
var p1: Fighter
var cpu: Fighter


func _ready() -> void:
	Engine.time_scale = 4.0
	Engine.max_physics_steps_per_frame = 16
	var main := MAIN.instantiate()
	add_child(main)
	p1 = main.get_node("P1")
	cpu = main.get_node("P2")
	cpu.set_cpu(CpuBrain.new(7))
	await _run()
	Engine.time_scale = 1.0
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	await _frames(30)
	p1.global_position = Vector2(-200, -56)
	p1.velocity = Vector2.ZERO
	cpu.global_position = Vector2(400, -56)
	await _frames(10)
	var start_dist := p1.global_position.distance_to(cpu.global_position)
	await _frames(90)
	var dist := p1.global_position.distance_to(cpu.global_position)
	_check("CPU se aproxima do adversário", dist < start_dist - 150.0, "%.0f -> %.0f px" % [start_dist, dist])

	var hit_frame := -1
	for i in 600:
		await get_tree().physics_frame
		if p1.damage_percent > 0.0:
			hit_frame = i
			break
	_check("CPU acerta um adversário parado", hit_frame >= 0, "quadro %d" % hit_frame)

	# Nunca fica parada: mede o maior trecho sem mudar de posição nem de estado
	var still := 0
	var worst := 0
	var last_pos := cpu.global_position
	var last_state := cpu.state
	var kos := 0
	var last_damage := p1.damage_percent
	for i in 3600:
		await get_tree().physics_frame
		if cpu.global_position.distance_to(last_pos) < 1.0 and cpu.state == last_state:
			still += 1
			worst = maxi(worst, still)
		else:
			still = 0
		last_pos = cpu.global_position
		last_state = cpu.state
		if last_damage > 0.0 and p1.damage_percent == 0.0:
			kos += 1  # P1 voltou ao ponto inicial (KO provisório da cena de teste)
		last_damage = p1.damage_percent
		if kos >= 1 and i > 600:
			break
	_check("CPU nunca fica parada mais de 3 s", worst < 180, "maior pausa %d quadros" % worst)
	_check("CPU marca KO num adversário parado", kos >= 1, "%d KO(s), P1 em %.0f%%" % [kos, p1.damage_percent])

	# Recuperação: lançada para fora em vários pontos, volta para o palco
	p1.global_position = Vector2(0, -56)
	var starts := [Vector2(-820, -150), Vector2(820, -150), Vector2(-760, 120), Vector2(760, 160), Vector2(-700, 40)]
	var back := 0
	for s in starts:
		cpu.respawn()
		cpu.global_position = s
		cpu.velocity = Vector2(signf(s.x) * 300.0, 0.0)
		cpu.state = Fighter.State.AIR
		var ok := false
		for i in 300:
			await get_tree().physics_frame
			if cpu.is_on_floor() and absf(cpu.global_position.x) < 560.0:
				ok = true
				break
			if cpu.state == Fighter.State.LEDGE:
				ok = true
				break
		if ok:
			back += 1
	_check("CPU volta para a arena quando é lançada (≥4 de 5)", back >= 4, "%d de 5" % back)


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
