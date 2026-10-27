extends Node
## Teste de fumaça da fila de entrada (buffer de 8 quadros, FighterControls).
##   godot --headless --path game res://tests/buffer_smoke.tscn
## Confere: toque pouco antes do fim do golpe sai no 1º quadro livre; toque
## velho demais some; pulo/especial guardados; ordem dos toques; sem golpe em dobro.

const MAIN := preload("res://scenes/main.tscn")
const GROUND := Vector2(0, -56)

var results: Array[String] = []
var failures := 0
var p1: Fighter
var p2: Fighter


func _ready() -> void:
	var main := MAIN.instantiate()
	add_child(main)
	p1 = main.get_node("P1")
	p2 = main.get_node("P2")
	await _frames(30)
	await _run()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	# 1) Ataque 5 quadros antes do fim do ftilt: jab no 1º quadro livre.
	var r := await _press_before_end("p1_attack", 5)
	_check("Ataque 5 quadros antes do fim do ftilt sai no 1º quadro livre",
		r["next"] == "jab" and r["gap"] == 1, "golpe=%s, quadros até sair=%d" % [r["next"], r["gap"]])
	# 2) 12 quadros antes: velho demais, nada sai.
	r = await _press_before_end("p1_attack", 12)
	_check("Ataque 12 quadros antes do fim do ftilt é descartado", r["next"] == "", "golpe=%s" % r["next"])
	# 3) Especial 5 quadros antes do fim do ftilt.
	r = await _press_before_end("p1_special", 5)
	_check("Especial 5 quadros antes do fim do ftilt sai no 1º quadro livre",
		String(r["next"]).begins_with("special") and r["gap"] == 1, "golpe=%s, quadros até sair=%d" % [r["next"], r["gap"]])
	# 4) Ordem: pulo e depois ataque durante o ftilt -> pulo e depois aéreo (não jab).
	var seq := await _order_jump_then_attack()
	_check("Pulo e depois ataque guardados: sai pulo e depois aéreo", seq.size() >= 2 and seq[0] == "pulo" \
		and String(seq[1]).ends_with("air") and not "jab" in seq, str(seq))
	# 5) Pulo 4 quadros antes do pouso (sem pulo duplo): pula ao pousar.
	var high := await _jump_before_landing(true)
	_check("Pulo 4 quadros antes do pouso pula no 1º quadro no chão", high["jumped"] and high["gap"] <= 1,
		"pulou=%s, quadros no chão antes=%d, altura=%.0f" % [high["jumped"], high["gap"], high["peak"]])
	# 6) Mesmo pulo guardado mas com o botão já solto quando sai: pulo curto.
	var low := await _jump_before_landing(false)
	_check("Pulo guardado com botão solto sai curto", low["jumped"] and low["peak"] < high["peak"] * 0.7,
		"curto=%.0f px, alto=%.0f px" % [low["peak"], high["peak"]])
	# 7) Sem golpe em dobro: um toque de ataque durante o jab dá um jab2 só.
	var ids := await _single_tap_in_jab()
	_check("Um toque durante o jab dá um jab2 só", ids == ["jab", "jab2"], str(ids))
	# 8) Especial 4 quadros antes do fim do lag de pouso.
	var sp := await _special_in_landing_lag()
	_check("Especial 4 quadros antes do fim do lag de pouso sai no 1º quadro livre",
		String(sp["next"]).begins_with("special") and sp["gap"] == 1, "golpe=%s, quadros até sair=%d" % [sp["next"], sp["gap"]])


## Começa o ftilt, aperta 'action' quando faltam 'before' quadros para o fim e
## devolve o próximo golpe e quantos quadros depois do fim do ftilt ele começou.
func _press_before_end(action: String, before: int) -> Dictionary:
	await _reset()
	p1.start_attack("ftilt")
	var total := p1.attack.total_frames()
	# No início de cada quadro (antes do lutador), attack_frame = k: o golpe acaba
	# no quadro em que attack_frame vira total -> faltam total - k quadros.
	while p1.attack_id == "ftilt" and total - p1.attack_frame > before:
		await get_tree().physics_frame
	Input.action_press(action)
	await get_tree().physics_frame
	Input.action_release(action)
	while p1.attack_id == "ftilt":
		await get_tree().physics_frame
	var gap := 0
	var next := ""
	for i in 20:
		if p1.attack_id != "":
			next = p1.attack_id
			break
		await get_tree().physics_frame
		gap += 1
	await _frames(40)
	return {"next": next, "gap": gap}


func _order_jump_then_attack() -> Array:
	await _reset()
	p1.start_attack("ftilt")
	var total := p1.attack.total_frames()
	while total - p1.attack_frame > 6:
		await get_tree().physics_frame
	Input.action_press("p1_jump")
	await get_tree().physics_frame
	Input.action_release("p1_jump")
	await get_tree().physics_frame
	Input.action_press("p1_attack")
	await get_tree().physics_frame
	Input.action_release("p1_attack")
	var seq: Array = []
	var was_ftilt := true
	for i in 30:
		await get_tree().physics_frame
		if was_ftilt and p1.attack_id != "ftilt":
			was_ftilt = false
		if was_ftilt:
			continue
		if p1.velocity.y < 0.0 and not "pulo" in seq and p1.attack_id == "":
			seq.append("pulo")
		if p1.attack_id != "" and not p1.attack_id in seq:
			seq.append(p1.attack_id)
	await _frames(60)
	return seq


## Larga o lutador do alto sem pulo extra e aperta pulo 4 quadros antes do pouso.
func _jump_before_landing(hold: bool) -> Dictionary:
	# Ensaio: quantos quadros até pousar.
	await _drop()
	var n := 0
	while not p1.is_on_floor() and n < 200:
		await get_tree().physics_frame
		n += 1
	await _frames(20)
	await _drop()
	for i in n - 4:
		await get_tree().physics_frame
	Input.action_press("p1_jump")
	await get_tree().physics_frame
	if not hold:
		Input.action_release("p1_jump")
	var landed := false
	var gap := 0
	var jumped := false
	var ground_y := GROUND.y
	var peak := 0.0
	for i in 60:
		await get_tree().physics_frame
		if p1.is_on_floor():
			landed = true
			gap += 1
		elif landed and p1.velocity.y < 0.0:
			jumped = true
		if landed:
			peak = maxf(peak, ground_y - p1.global_position.y)
		if jumped and p1.velocity.y >= 0.0:
			break
	Input.action_release("p1_jump")
	await _frames(60)
	return {"jumped": jumped, "gap": gap, "peak": peak}


func _single_tap_in_jab() -> Array:
	await _reset()
	await _frames(30)   # sai da janela do encadeamento do jab anterior
	Input.action_press("p1_attack")
	await get_tree().physics_frame
	Input.action_release("p1_attack")
	await _frames(2)
	Input.action_press("p1_attack")
	await get_tree().physics_frame
	Input.action_release("p1_attack")
	var ids: Array = []
	for i in 60:
		if p1.attack_id != "" and (ids.is_empty() or ids[-1] != p1.attack_id):
			ids.append(p1.attack_id)
		await get_tree().physics_frame
	await _frames(20)
	return ids


## Lag de pouso de 12 quadros; especial apertado quando faltam 4.
func _special_in_landing_lag() -> Dictionary:
	await _reset()
	p1.state = Fighter.State.LAG
	p1._lag_frames = 12
	while p1._lag_frames > 4:
		await get_tree().physics_frame
	Input.action_press("p1_special")
	await get_tree().physics_frame
	Input.action_release("p1_special")
	while p1.state == Fighter.State.LAG:
		await get_tree().physics_frame
	var gap := 0
	var got := ""
	for i in 20:
		if p1.attack_id != "":
			got = p1.attack_id
			break
		await get_tree().physics_frame
		gap += 1
	await _frames(90)
	return {"next": got, "gap": gap}


func _drop() -> void:
	await _reset()
	p1.global_position = GROUND + Vector2(0, -160)
	p1.velocity = Vector2.ZERO
	p1.state = Fighter.State.AIR
	p1.jumps_left = 0
	await get_tree().physics_frame
	p1.jumps_left = 0


func _reset() -> void:
	for a in ["attack", "special", "jump", "shield", "grab", "left", "right", "up", "down"]:
		Input.action_release("p1_" + a)
	p2.global_position = Vector2(480, -56)
	p2.velocity = Vector2.ZERO
	p1.global_position = GROUND
	p1.velocity = Vector2.ZERO
	p1.attack = null
	p1.attack_id = ""
	p1.state = Fighter.State.IDLE
	p1.facing = 1
	p1.helpless = false
	p1._hitstop = 0
	p1.controls.clear_buffer()
	await _frames(12)


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
