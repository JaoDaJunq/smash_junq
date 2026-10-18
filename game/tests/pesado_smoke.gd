extends Node
## Teste de fumaça do Pesado (T13): 9 golpes básicos, 4 especiais (pancada
## carregável, agarrão no chão e no ar, pulo alto, pisão no chão e no ar) e peso.
## P2 = Pesado (p2_*), P1 = Ágil (alvo). Salva screenshots em evidence/etapa-2/.
##   godot --path game res://tests/pesado_smoke.tscn

const MAIN := preload("res://scenes/main.tscn")
const AIR_Y := -800.0

var results: Array[String] = []
var failures := 0
var p1: Fighter
var p2: Pesado
var evidence_dir := ""

## Prende P1 a uma posição relativa a P2 (golpes no ar), até P1 ser atingido.
var pinning := false
var pin_offset := Vector2.ZERO


func _ready() -> void:
	process_physics_priority = 100  # depois dos lutadores, para o alvo acompanhar P2
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


func _physics_process(_delta: float) -> void:
	if not pinning:
		return
	if p1.state == Fighter.State.HITSTUN or p1.state == Fighter.State.HELD:
		pinning = false  # acertado ou agarrado: solta
		return
	p1.global_position = p2.global_position + pin_offset
	p1.velocity = Vector2.ZERO


func _run() -> void:
	await _frames(40)
	_check("P2 é um Pesado de peso 125 e P1 um Ágil mais leve", p2 is Pesado and p2.weight == 125.0 and p1.weight < p2.weight,
		"%.0f x %.0f" % [p2.weight, p1.weight])

	# --- 9 golpes básicos: (golpe, teclas de P2, no ar, posição de P1 relativa a P2)
	# P2 olha para a esquerda; "right" no ar (sem virar) vira o golpe de trás.
	await _basic("jab", [], false, Vector2(-75, 0))
	await _jab_chain()
	await _basic("ftilt", ["left"], false, Vector2(-85, 0))
	await _basic("utilt", ["up"], false, Vector2(-10, 0))
	await _basic("dtilt", ["down"], false, Vector2(-75, 0))
	await _basic("nair", [], true, Vector2(-40, 0))
	await _basic("fair", ["left"], true, Vector2(-85, 0))
	await _basic("bair", ["right"], true, Vector2(85, 0))
	await _basic("uair", ["up"], true, Vector2(-5, -75))
	await _basic("dair", ["down"], true, Vector2(-5, 75))

	var slow_ok := p2.moveset.ftilt.startup >= 10 and p2.moveset.fair.startup >= 12 and p2.moveset.ftilt.damage >= 12.0
	_check("Pesado é lento e forte (ftilt/fair)", slow_ok, "ftilt %d quadros / %.0f%%" % [p2.moveset.ftilt.startup, p2.moveset.ftilt.damage])

	await _special_neutral()
	await _special_side(false)
	await _special_side(true)
	await _special_up()
	await _special_down(false)
	await _special_down(true)
	await _weight()


# --- Básicos ---

func _basic(move_id: String, keys: Array, air: bool, rel: Vector2) -> void:
	await _setup(air, rel)
	var data := p2.moveset.move(move_id)
	for k in keys:
		Input.action_press("p2_" + k)
	await _tap("p2_attack")
	var started := false
	var hit_frame := -1
	for i in 90:
		if p2.attack_id == move_id:
			started = true
		if p1.damage_percent > 0.0 and hit_frame < 0:
			hit_frame = p2.attack_frame
		if hit_frame >= 0:
			break
		await get_tree().physics_frame
	for k in keys:
		Input.action_release("p2_" + k)
	_check("%s: começa" % move_id, started, "")
	_check("%s: acerta P1" % move_id, hit_frame >= 0 and is_equal_approx(p1.damage_percent, data.damage),
		"%.1f%% (esperado %.1f) no quadro %d" % [p1.damage_percent, data.damage, hit_frame])
	await _frames(60)
	await _settle()


## Sequência do ataque básico: apertar Ataque 3 vezes faz jab -> jab2 -> jab3,
## e o terceiro lança mais forte. Uma pausa longa recomeça do jab.
func _jab_chain() -> void:
	await _setup(false, Vector2(-75, 0))
	var seen: Array[String] = []
	for i in 3:
		await _tap("p2_attack")
		for f in 30:
			if p2.attack_id != "" and (seen.is_empty() or seen[-1] != p2.attack_id):
				seen.append(p2.attack_id)
			if seen.size() > i:
				break
			await get_tree().physics_frame
		await _frames(4)
	await _frames(40)
	_check("Ataque básico: 3 toques fazem jab, jab2 e jab3", seen == ["jab", "jab2", "jab3"], str(seen))
	_check("Ataque básico: o terceiro golpe lança (finalização)", p1.state == Fighter.State.HITSTUN or absf(p1.velocity.x) > 0.0 or p1.damage_percent > p2.moveset.jab.damage * 3.0,
		"dano %.1f%%" % p1.damage_percent)
	await _frames(60)
	await _settle()
	await _setup(false, Vector2(-75, 0))
	await _tap("p2_attack")
	await _frames(2)
	_check("Ataque básico: depois de uma pausa recomeça do jab", p2.attack_id == "jab", p2.attack_id)
	await _frames(60)
	await _settle()


# --- Especiais ---

func _special_neutral() -> void:
	var quick := await _neutral_run(0)
	var charged := await _neutral_run(45)
	var maxed := await _neutral_run(100)
	var over := await _neutral_run(220)
	_check("Pancada carregada: mais dano que o toque", charged.damage > quick.damage * 1.3, "%.1f -> %.1f" % [quick.damage, charged.damage])
	_check("Pancada carregada: lança mais forte que o toque", charged.speed > quick.speed * 1.2, "%.0f -> %.0f px/s" % [quick.speed, charged.speed])
	_check("Pancada tem teto de carga", absf(over.damage - maxed.damage) < 0.01 and absf(over.speed - maxed.speed) < 1.0 and maxed.damage >= charged.damage,
		"100 quadros %.1f dano %.0f px/s / 220 quadros %.1f dano %.0f px/s" % [maxed.damage, maxed.speed, over.damage, over.speed])
	_check("Pancada rápida usa o dano base", is_equal_approx(quick.damage, p2.moveset.special_neutral.damage), "%.1f" % quick.damage)
	# Screenshot da carga
	await _setup(false, Vector2(-120, 0))
	Input.action_press("p2_special")
	await _frames(14 + 40)
	await _shot("pesado-01-carga")
	Input.action_release("p2_special")
	await _frames(80)


## hold = quadros com Especial apertado. Retorna dano e velocidade do lançamento.
func _neutral_run(hold: int) -> Dictionary:
	await _setup(false, Vector2(-105, 0))
	Input.action_press("p2_special")
	var speed := 0.0
	for i in 40 + maxi(hold, 2) + 20:
		await get_tree().physics_frame
		if i == maxi(hold, 2):
			Input.action_release("p2_special")
		if p1.damage_percent > 0.0:
			speed = p1.velocity.length()
			break
	Input.action_release("p2_special")
	var out := {"damage": p1.damage_percent, "speed": speed}
	await _frames(70)
	await _settle()
	return out


func _special_side(air: bool) -> void:
	var tag := "agarrão no ar" if air else "agarrão no chão"
	await _setup(air, Vector2(-80, 0))
	Input.action_press("p2_left")
	await _tap("p2_special")
	var held := false
	var follows := false
	var shot_done := false
	var thrown_frame := -1
	for i in 120:
		await get_tree().physics_frame
		if p1.state == Fighter.State.HELD and not held:
			held = true
		if held and p1.state == Fighter.State.HELD:
			var rel := p1.global_position - p2.global_position
			# no ar há um quadro de atraso (o Pesado cai depois de puxar o alvo)
			var tol := 30.0 if air else 2.0
			follows = absf(rel.x + Fighter.HOLD_OFFSET.x) < tol and absf(rel.y) < tol
			if not shot_done and not air:
				shot_done = true
				await _shot("pesado-02-agarrao")
		if p1.state == Fighter.State.HITSTUN:
			thrown_frame = i
			break
	Input.action_release("p2_left")
	_check("%s: P1 fica segurado (HELD)" % tag, held, "")
	_check("%s: P1 acompanha o Pesado enquanto preso" % tag, follows, "")
	_check("%s: arremessa (HITSTUN) com dano e para frente" % tag,
		thrown_frame >= 0 and p1.damage_percent > 0.0 and p1.velocity.x < 0.0,
		"dano %.1f vx %.0f" % [p1.damage_percent, p1.velocity.x])
	await _frames(60)
	await _settle()


func _special_up() -> void:
	await _setup(true, Vector2(-30, -20), 0.0, -56.0)  # P2 no chão, P1 acompanha
	var y0 := p2.global_position.y
	var top := y0
	var hit_y := 0.0
	var hit_vy := 0.0
	var hit_frame := -1
	var p1_stunned := false
	Input.action_press("p2_up")
	await _tap("p2_special")
	Input.action_release("p2_up")
	for i in 120:
		await get_tree().physics_frame
		top = minf(top, p2.global_position.y)
		if p1.damage_percent > 0.0 and hit_frame < 0:
			hit_frame = p2.attack_frame
			hit_y = p2.global_position.y
			hit_vy = p2.velocity.y
			p1_stunned = p1.state == Fighter.State.HITSTUN
			await _shot("pesado-03-pulo-alto")
		if p2.state != Fighter.State.ATTACK and i > 10:
			break
	_check("Especial para cima: sobe muito", y0 - top > 250.0, "%.0f px" % (y0 - top))
	_check("Especial para cima: acerta no topo", hit_frame > p2.moveset.special_up.startup and y0 - hit_y > 230.0 and absf(hit_vy) < 500.0,
		"quadro %d, %.0f px acima, vy %.0f" % [hit_frame, y0 - hit_y, hit_vy])
	_check("Especial para cima: P1 atingido e lançado", p1.damage_percent > 0.0 and p1_stunned, "dano %.1f" % p1.damage_percent)
	var airborne := not p2.is_on_floor()
	var jumps_before := p2.jumps_left
	await _tap("p2_jump")
	_check("Especial para cima: Pesado fica sem pulo (helpless)",
		airborne and p2.helpless and p2.jumps_left == jumps_before and p2.velocity.y > -100.0,
		"helpless=%s estado=%s" % [p2.helpless, Fighter.State.keys()[p2.state]])
	var landed := false
	for i in 150:
		await get_tree().physics_frame
		if p2.is_on_floor() and p2.state != Fighter.State.ATTACK:
			landed = true
			break
	_check("Especial para cima: ao pousar volta ao normal", landed and not p2.helpless, "")
	await _frames(30)
	await _settle()


func _special_down(air: bool) -> void:
	var tag := "pisão no ar" if air else "pisão no chão"
	if air:
		await _setup(false, Vector2(-70, 0))
		await _place(p2, Vector2(0, -500), -1)
	else:
		await _setup(false, Vector2(70, 0))  # P1 atrás, para testar o lado
	var max_vy := 0.0
	Input.action_press("p2_down")
	await _tap("p2_special")
	Input.action_release("p2_down")
	var hit := false
	var lift := 0.0
	for i in 150:
		await get_tree().physics_frame
		max_vy = maxf(max_vy, p2.velocity.y)
		if p1.damage_percent > 0.0:
			hit = true
			lift = -p1.velocity.y
			break
	_check("%s: P1 próximo é lançado" % tag, hit and p1.state == Fighter.State.HITSTUN and lift > 200.0,
		"dano %.1f, subida %.0f px/s" % [p1.damage_percent, lift])
	var dir_ok := (p1.velocity.x > 0.0) if not air else (p1.velocity.x < 0.0)
	_check("%s: lança para longe do Pesado" % tag, dir_ok, "vx %.0f" % p1.velocity.x)
	if air:
		_check("pisão no ar: despenca rápido", max_vy > 1500.0, "%.0f px/s" % max_vy)
		_check("pisão no ar: só acerta ao pousar", p2.global_position.y > -80.0, "y %.0f" % p2.global_position.y)
		await _shot("pesado-04-pisao")
	await _frames(70)
	await _settle()


func _weight() -> void:
	# Mesmo golpe, mesmo %: o mais pesado voa menos
	var data := p1.moveset.ftilt
	p1.damage_percent = 60.0
	p2.damage_percent = 60.0
	p1.receive_hit(p2, data, 1)
	p2.receive_hit(p1, data, 1)
	var light := p1.velocity.length()
	var heavy := p2.velocity.length()
	_check("Peso: Pesado (125) é lançado menos que Ágil (%.0f)" % p1.weight, heavy < light * 0.9, "%.0f x %.0f px/s" % [heavy, light])
	await _frames(40)
	await _settle()


# --- Ajuda ---

## Zera os dois, P2 em (0, y) e P1 em relação a ele. air: os dois no ar, P1 preso a P2.
func _setup(air: bool, rel: Vector2, p2_dmg := 0.0, p2_y := AIR_Y) -> void:
	pinning = false
	Input.action_release("p2_left")
	Input.action_release("p2_right")
	Input.action_release("p2_special")
	if air:
		await _place(p2, Vector2(0, p2_y), -1)
		pin_offset = rel
		pinning = true
		await _place(p1, p2.global_position + rel, 1)
	else:
		await _place(p2, Vector2(0, -56), -1)
		await _place(p1, Vector2(rel.x, -56), 1)
	p1.damage_percent = 0.0
	p2.damage_percent = p2_dmg


## Espera a luta acalmar (ninguém atordoado/atacando).
func _settle() -> void:
	for i in 240:
		if p1.state in [Fighter.State.IDLE, Fighter.State.WALK] and p2.state in [Fighter.State.IDLE, Fighter.State.WALK]:
			return
		await get_tree().physics_frame


func _place(f: Fighter, pos: Vector2, face: int) -> void:
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstop = 0
	f._hitstun = 0.0
	f.held_by = null
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
	if DisplayServer.get_name() == "headless":
		return  # sem renderização não há screenshot
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	img.save_png(evidence_dir.path_join(name + ".png"))
