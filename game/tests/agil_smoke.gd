extends Node
## Teste de fumaça do Ágil (T11 e T12): os 9 básicos, projétil, investida,
## teletransporte e contra-ataque. Salva screenshots em evidence/etapa-2/agil-*.png.
##   godot --path game res://tests/agil_smoke.tscn

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
	_check("P1 é o Ágil", p1 is Agil, p1.display_name)
	await _test_basics()
	await _test_projectile()
	await _test_side()
	await _test_up()
	await _test_counter()


# --- 9 básicos: cada um começa e acerta o P2 ---

func _test_basics() -> void:
	var g1 := p1.gravity
	var g2 := p2.gravity
	p1.gravity = 0.0  # flutuam para os aéreos acertarem sempre no mesmo lugar
	p2.gravity = 0.0
	# golpe, alavanca (x, y), no chão?
	var table := [
		["jab", Vector2.ZERO, true], ["ftilt", Vector2(1, 0), true],
		["utilt", Vector2(0, -1), true], ["dtilt", Vector2(0, 1), true],
		["nair", Vector2.ZERO, false], ["fair", Vector2(1, 0), false],
		["bair", Vector2(-1, 0), false], ["uair", Vector2(0, -1), false],
		["dair", Vector2(0, 1), false],
	]
	for row in table:
		var move_id: String = row[0]
		var stick: Vector2 = row[1]
		var grounded: bool = row[2]
		var data: AttackData = p1.moveset.move(move_id)
		var y := -56.0 if grounded else -150.0
		await _place(p1, Vector2(-100, y), 1)
		var target := Vector2(-100 + data.hitbox_offset.x, y + data.hitbox_offset.y)
		if grounded:
			target.y = minf(target.y, -56.0)
		await _place(p2, target, -1)
		p2.damage_percent = 0.0
		await _hold_stick(stick)
		await _tap("p1_attack")
		_release_stick(stick)
		var started := false
		var hit := false
		for i in 40:
			if p1.attack_id == move_id:
				started = true
			if p2.damage_percent > 0.0:
				hit = true
				break
			await get_tree().physics_frame
		_check("Básico %s começa e acerta" % move_id, started and hit and is_equal_approx(p2.damage_percent, data.damage),
			"começou=%s dano=%.1f/%.1f startup=%d" % [started, p2.damage_percent, data.damage, data.startup])
		await _frames(30)
	p1.gravity = g1
	p2.gravity = g2


# --- Especial neutro: projétil ---

func _test_projectile() -> void:
	await _place(p1, Vector2(-400, -56), 1)
	await _place(p2, Vector2(300, -56), -1)
	p2.damage_percent = 0.0
	await _tap("p1_special")
	var proj: Projectile = null
	var first_x := 0.0
	var last_x := 0.0
	var shot := false
	for i in 90:
		await get_tree().physics_frame
		if proj == null:
			for c in get_children()[0].get_children():
				if c is Projectile:
					proj = c
					first_x = c.global_position.x
		elif is_instance_valid(proj) and not proj.is_queued_for_deletion():
			last_x = proj.global_position.x
			if not shot and last_x > first_x + 200.0:
				shot = true
				await _shot("agil-projetil")
		if p2.damage_percent > 0.0:
			break
	_check("Projétil nasce e anda para frente", shot and last_x - first_x > 200.0, "%.0f px" % (last_x - first_x))
	_check("Projétil acerta o P2 e some", is_equal_approx(p2.damage_percent, p1.moveset.special_neutral.damage), "dano=%.1f" % p2.damage_percent)
	await _frames(2)
	_check("Projétil é removido depois do acerto", proj == null or not is_instance_valid(proj) or proj.is_queued_for_deletion(), "")
	# Sem alvo no caminho: some pelo tempo de vida e não atinge o dono
	await _place(p2, Vector2(300, -400), -1)
	await _place(p1, Vector2(-400, -56), 1)
	var p1_before := p1.damage_percent
	await _tap("p1_special")
	await _frames(100)
	var alive := false
	for c in get_children()[0].get_children():
		if c is Projectile:
			alive = true
	_check("Projétil some pelo tempo de vida e não acerta o dono", not alive and p1.damage_percent == p1_before, "")


# --- Especial lateral: investida ---

func _test_side() -> void:
	await _place(p1, Vector2(-450, -56), 1)
	await _place(p2, Vector2(500, -400), -1)  # fora do caminho
	var x0 := p1.global_position.x
	Input.action_press("p1_right")
	await _tap("p1_special")
	var shot := false
	for i in 40:
		await get_tree().physics_frame
		if not shot and p1.global_position.x - x0 > 150.0:
			shot = true
			await _shot("agil-investida")
	Input.action_release("p1_right")
	var moved := p1.global_position.x - x0
	_check("Investida lateral move o Ágil para frente (>= 200 px)", moved >= 200.0, "%.0f px" % moved)
	# Acerta no caminho
	await _place(p1, Vector2(-450, -56), 1)
	await _place(p2, Vector2(-150, -56), -1)
	p2.damage_percent = 0.0
	Input.action_press("p1_right")
	await _tap("p1_special")
	Input.action_release("p1_right")
	var hit := false
	for i in 40:
		await get_tree().physics_frame
		if p2.damage_percent > 0.0:
			hit = true
			break
	_check("Investida lateral acerta quem está no caminho", hit and is_equal_approx(p2.damage_percent, p1.moveset.special_side.damage), "dano=%.1f" % p2.damage_percent)
	# Também funciona para trás (vira para o lado da alavanca)
	await _place(p1, Vector2(450, -56), 1)
	await _place(p2, Vector2(500, -400), -1)
	x0 = p1.global_position.x
	Input.action_press("p1_left")
	await _tap("p1_special")
	await _frames(35)
	Input.action_release("p1_left")
	_check("Investida lateral para a esquerda", x0 - p1.global_position.x >= 200.0 and p1.facing == -1, "%.0f px" % (x0 - p1.global_position.x))


# --- Especial para cima: teletransporte ---

func _test_up() -> void:
	# Diagonal para cima e para a direita
	await _place(p1, Vector2(-100, -56), 1)
	await _place(p2, Vector2(500, -400), -1)
	var start := p1.global_position
	Input.action_press("p1_up")
	Input.action_press("p1_right")
	await _tap("p1_special")
	Input.action_release("p1_up")
	Input.action_release("p1_right")
	var shot := false
	for i in 14:
		await get_tree().physics_frame
		if not shot and p1.attack_frame >= p1.moveset.special_up.startup + 1:
			shot = true
			await _shot("agil-teleporte")
	var moved := p1.global_position - start
	_check("Teletransporte vai na direção da alavanca (cima-direita)", moved.x > 100.0 and moved.y < -100.0 and absf(moved.length() - 260.0) < 30.0, "%s" % moved)
	var waited := 0
	while p1.state == Fighter.State.ATTACK and waited < 80:
		await get_tree().physics_frame
		waited += 1
	var jumps_before := p1.jumps_left
	await _tap("p1_jump")
	_check("Depois do teletransporte fica sem pulo no ar", not p1.is_on_floor() and p1.helpless and p1.jumps_left == jumps_before and p1.velocity.y > 0.0,
		"helpless=%s estado=%s" % [p1.helpless, Fighter.State.keys()[p1.state]])
	var landed := false
	for i in 120:
		await get_tree().physics_frame
		if p1.is_on_floor() and p1.state != Fighter.State.ATTACK:
			landed = true
			break
	_check("Ao pousar volta ao normal", landed and not p1.helpless, "")
	# Diagonal para a esquerda e reto para cima
	await _place(p1, Vector2(100, -56), 1)
	start = p1.global_position
	Input.action_press("p1_up")
	Input.action_press("p1_left")
	await _tap("p1_special")
	Input.action_release("p1_up")
	Input.action_release("p1_left")
	await _frames(12)
	moved = p1.global_position - start
	_check("Teletransporte cima-esquerda", moved.x < -100.0 and moved.y < -100.0 and p1.facing == -1, "%s facing=%d" % [moved, p1.facing])
	await _place(p1, Vector2(-100, -56), 1)
	start = p1.global_position
	Input.action_press("p1_up")
	await _tap("p1_special")
	Input.action_release("p1_up")
	await _frames(12)
	moved = p1.global_position - start
	_check("Teletransporte reto para cima", absf(moved.x) < 5.0 and moved.y < -200.0, "%s" % moved)
	# Estouro na chegada acerta quem está lá
	await _place(p1, Vector2(-100, -56), 1)
	await _place(p2, Vector2(-100, -300), -1)
	p2.gravity = 0.0
	p2.damage_percent = 0.0
	Input.action_press("p1_up")
	await _tap("p1_special")
	Input.action_release("p1_up")
	await _frames(14)
	_check("Estouro na chegada do teletransporte acerta", p2.damage_percent > 0.0, "dano=%.1f" % p2.damage_percent)
	p2.gravity = 2600.0


# --- Especial para baixo: contra-ataque ---

func _test_counter() -> void:
	var data: AttackData = p1.moveset.special_down
	# P2 ataca dentro da janela
	await _face_off()
	Input.action_press("p1_down")
	await _tap("p1_special")
	Input.action_release("p1_down")
	_check("Contra-ataque começa", p1.attack_id == "special_down", p1.attack_id)
	await _frames(2)
	p2.start_attack("jab")
	var shot := false
	var hit_frame := 0
	for i in 30:
		await get_tree().physics_frame
		if p2.damage_percent > 0.0:
			hit_frame = p1.attack_frame
			await _shot("agil-contra-ataque")
			shot = true
			break
	await _frames(3)
	_check("Contra-ataque: P1 não sofre dano nem atordoamento", p1.damage_percent == 0.0 and p1.state != Fighter.State.HITSTUN,
		"dano=%.1f estado=%s" % [p1.damage_percent, Fighter.State.keys()[p1.state]])
	_check("Contra-ataque: P2 apanha e é lançado", shot and p2.damage_percent >= Agil.COUNTER_MIN_DAMAGE and p2.state == Fighter.State.HITSTUN and p2.velocity.x > 0.0 and p2.velocity.y < 0.0,
		"dano=%.1f estado=%s vel=%s quadro=%d" % [p2.damage_percent, Fighter.State.keys()[p2.state], p2.velocity, hit_frame])
	await _frames(40)
	# Fora da janela (depois do estouro) o golpe entra normalmente
	await _face_off()
	Input.action_press("p1_down")
	await _tap("p1_special")
	Input.action_release("p1_down")
	await _frames(data.startup + data.active + 1)  # janela já passou (o estouro acerta o P2)
	p2.start_attack("jab")
	await _frames(10)
	_check("Fora da janela o P1 apanha normalmente (sem golpe de volta)", p1.damage_percent > 0.0 and is_equal_approx(p2.damage_percent, data.damage),
		"P1=%.1f P2=%.1f (quadro %d)" % [p1.damage_percent, p2.damage_percent, p1.attack_frame])
	# Sem ninguém batendo, o estouro acerta quem está perto
	await _face_off()
	Input.action_press("p1_down")
	await _tap("p1_special")
	Input.action_release("p1_down")
	await _frames(data.startup + data.active + 2)
	_check("Sem acerto o contra-ataque termina com um estouro fraco", is_equal_approx(p2.damage_percent, data.damage), "dano=%.1f" % p2.damage_percent)


## Lado a lado no centro, danos zerados.
func _face_off() -> void:
	await _place(p1, Vector2(-70, -56), 1)
	await _place(p2, Vector2(0, -56), -1)
	p1.damage_percent = 0.0
	p2.damage_percent = 0.0
	await _frames(20)


func _hold_stick(stick: Vector2) -> void:
	if stick.x > 0.0:
		Input.action_press("p1_right")
	elif stick.x < 0.0:
		Input.action_press("p1_left")
	if stick.y < 0.0:
		Input.action_press("p1_up")
	elif stick.y > 0.0:
		Input.action_press("p1_down")


func _release_stick(stick: Vector2) -> void:
	for a in ["p1_right", "p1_left", "p1_up", "p1_down"]:
		Input.action_release(a)


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
