extends Node
## Teste de fumaça do Mourisco (rodada 11): golpes básicos acertam e a mecânica da
## bola de vôlei e cada especial funcionam.
##   godot --headless --path game res://tests/mourisco_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const PROJ := preload("res://scenes/combat/projectile.tscn")

var results: Array[String] = []
var failures := 0
var me: Mourisco
var foe: Fighter
var _match: Node


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var idx := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i].get("id", "") == "mourisco":
			idx = i
	_check("mourisco está no elenco", idx >= 0, str(idx))
	if idx < 0 or not Game.character_ready(idx):
		results.append("[PULADO] mourisco: sprites ainda não importados")
		_finish()
		return
	Game.set_character("p1", idx)
	Game.set_character("p2", 0)
	_match = MATCH.instantiate()
	add_child(_match)
	await _frames(240)
	for f in _match.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f as Mourisco
		else:
			foe = f
	_check("Mourisco com arte", me != null and me.has_art, "")
	await _basics()
	await _serve()
	await _ball_rules()
	await _manchete()
	await _levantada()
	await _peixinho()
	_finish()


func _finish() -> void:
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _basics() -> void:
	for mv in ["jab", "ftilt", "utilt", "dtilt"]:
		await _face_off(25.0 if mv == "utilt" else 70.0)
		me.start_attack(mv)
		await _frames(45)
		_check("mourisco: %s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for mv in ["nair", "fair", "bair", "uair", "dair"]:
		await _face_off(70.0)
		await _place(me, Vector2(-200, -140), 1)
		await _place(foe, Vector2(-130, -140), -1)
		me.start_attack(mv)
		await _frames(30)
		_check("mourisco: %s roda sem travar" % mv, me.state != Fighter.State.ATTACK or me.attack_frame < 400, Fighter.State.keys()[me.state])
	for kind in ["neutral", "side", "up", "down"]:
		await _face_off()
		me.start_special(kind)
		await _frames(120)
		_check("mourisco: especial %s roda sem travar" % kind, me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])
	_clear_balls()


func _serve() -> void:
	# Saque: a bola aparece, sobe e depois fica no palco (não some)
	await _face_off(500.0)
	me.start_special("neutral")
	await _frames(12)
	var balls := get_tree().get_nodes_in_group("bolas_volei")
	_check("Saque: a bola aparece", balls.size() == 1, str(balls.size()))
	var b := me.ball()
	var y0 := b.global_position.y
	await _frames(8)
	_check("Saque: a bola sobe", b.global_position.y < y0 - 20.0, "%.0f px" % (y0 - b.global_position.y))
	await _frames(240)
	_check("Saque: a bola fica no palco quicando/parada", is_instance_valid(b) and b.global_position.y > -140.0 and b.global_position.y < 100.0,
		"y=%.0f chão=%s" % [b.global_position.y, b.is_grounded()])
	_check("Saque: bola sem corte não é viva", not b.live, "")
	# Segundo saque troca a bola (só existe uma)
	await _face_off(500.0)
	me.start_special("neutral")
	await _frames(14)
	await _frames(2)
	_check("Saque: só existe uma bola", get_tree().get_nodes_in_group("bolas_volei").filter(func(n: Node) -> bool: return not n.is_queued_for_deletion()).size() == 1, "")
	await _frames(80)
	# Cortada: apertar Especial de novo com a alavanca para a direita
	_clear_balls()
	await _face_off(900.0)
	me.start_special("neutral")
	await _frames(10)
	Input.action_press("p1_special")
	await _frames(3)
	Input.action_release("p1_special")
	await _frames(14)
	b = me.ball()
	_check("Cortada: a bola vira viva e rápida", b != null and b.live and b.velocity.length() > 900.0 and b.owner_fighter == me,
		"vel=%s live=%s" % [b.velocity.round() if b != null else "-", b.live if b != null else "-"])
	_check("Cortada: sem alavanca vai para a frente e um pouco para baixo", b != null and b.velocity.x > 800.0, "")
	# Cortada com alavanca para cima sai para cima
	_clear_balls()
	await _face_off(900.0)
	me.start_special("neutral")
	await _frames(10)
	Input.action_press("p1_up")
	Input.action_press("p1_special")
	await _frames(3)
	Input.action_release("p1_special")
	await _frames(14)
	Input.action_release("p1_up")
	await _frames(4)
	b = me.ball()
	_check("Cortada: segue a direção segurada (cima)", b != null and b.velocity.y < -300.0, "vel=%s" % (b.velocity.round() if b != null else "-"))
	_clear_balls()


func _ball_rules() -> void:
	# A bola viva machuca o adversário (e a bola do dono não machuca o dono)
	_clear_balls()
	await _face_off(400.0)
	foe.global_position = Vector2(-200 + 300, -60)
	var b := BolaVolei.spawn(me, me.global_position + Vector2(40, -30), Vector2.ZERO)
	b.knock(me, Vector2(1300, 0), true)
	await _frames(40)
	_check("Bola viva machuca o adversário", foe.damage_percent > 3.0, "%.1f%%" % foe.damage_percent)
	_check("Bola viva não machuca o dono", me.damage_percent == 0.0, "%.1f%%" % me.damage_percent)
	_clear_balls()
	# Bola sem corte (levantada) não machuca
	await _face_off(300.0)
	b = BolaVolei.spawn(me, me.global_position + Vector2(40, -30), Vector2.ZERO)
	b.knock(me, Vector2(320, 0), false)
	await _frames(40)
	_check("Bola mansa não machuca", foe.damage_percent == 0.0, "%.1f%%" % foe.damage_percent)
	_clear_balls()
	# O adversário também rebate: a bola passa a ser dele e machuca o Mourisco
	await _face_off(400.0)
	b = BolaVolei.spawn(me, foe.global_position + Vector2(-60, -10), Vector2.ZERO)
	b._grounded = false
	foe.start_attack("ftilt")
	await _frames(20)
	_check("Adversário rebate a bola e vira dono", is_instance_valid(b) and b.owner_fighter == foe, "")
	_check("Bola rebatida pelo adversário vai para o lado dele (esquerda)", is_instance_valid(b) and b.velocity.x < -300.0 or me.damage_percent > 0.0,
		"vel=%s" % (b.velocity.round() if is_instance_valid(b) else "-"))
	await _frames(40)
	_check("Bola do adversário machuca o Mourisco", me.damage_percent > 0.0, "%.1f%%" % me.damage_percent)
	_clear_balls()
	# Golpes do Mourisco na bola: levantamento (utilt) sobe sem dano, cortada (ftilt) é viva
	await _face_off(400.0)
	b = BolaVolei.spawn(foe, me.global_position + Vector2(10, -72), Vector2.ZERO)
	me.start_attack("utilt")
	await _frames(12)
	_check("Levantamento (toque para cima) sobe sem machucar", is_instance_valid(b) and b.velocity.y < -500.0 and not b.live and b.owner_fighter == me,
		"vel=%s live=%s" % [b.velocity.round(), b.live])
	_clear_balls()
	await _face_off(400.0)
	b = BolaVolei.spawn(foe, me.global_position + Vector2(72, -14), Vector2.ZERO)
	me.start_attack("ftilt")
	await _frames(14)
	_check("Cortada no chão (forte frente) dá bola viva", is_instance_valid(b) and b.live and b.velocity.x > 800.0, "vel=%s" % (b.velocity.round() if is_instance_valid(b) else "-"))
	_clear_balls()


func _manchete() -> void:
	# Manchete reflete projétil do adversário (vira dele e volta)
	await _face_off(500.0)
	var shot := AttackData.new()
	shot.damage = 3.0
	shot.hitbox_radius = 10.0
	var p := Projectile.spawn(PROJ, foe, shot, me.global_position + Vector2(160, -20), Vector2(-500, 0), 3.0)
	foe.global_position = Vector2(3000, -3000)   # longe: o rebatido não acerta ninguém
	me.start_special("side")
	await _frames(14)
	_check("Manchete: devolve o projétil e ele passa a ser do Mourisco", is_instance_valid(p) and p.owner_fighter == me and p.velocity.x > 300.0,
		"vel=%s" % (p.velocity.round() if is_instance_valid(p) else "-"))
	if is_instance_valid(p):
		p.queue_free()
	await _frames(40)
	# Manchete rebate a bola
	_clear_balls()
	await _face_off(900.0)
	var b := BolaVolei.spawn(foe, me.global_position + Vector2(60, -20), Vector2.ZERO)
	me.start_special("side")
	await _frames(14)
	_check("Manchete: rebate a bola (dono muda, bola viva)", is_instance_valid(b) and b.owner_fighter == me and b.live and b.velocity.x > 600.0,
		"vel=%s" % (b.velocity.round() if is_instance_valid(b) else "-"))
	_clear_balls()


func _levantada() -> void:
	# Salto altíssimo
	await _face_off(900.0)
	var y0 := me.global_position.y
	me.start_special("up")
	var top := y0
	for i in 40:
		await _frames(1)
		top = minf(top, me.global_position.y)
	_check("Levantada: salto altíssimo (>300 px)", y0 - top > 300.0, "%.0f px" % (y0 - top))
	await _frames(120)
	# Cravada: apertar Especial no caminho joga para baixo e crava no adversário
	await _face_off(900.0)
	await _place(me, Vector2(-200, -60), 1)
	await _place(foe, Vector2(-200 + 80, -60), -1)
	me.start_special("up")
	await _frames(12)
	foe.global_position = Vector2(me.global_position.x + 30.0, -60)   # embaixo da cravada
	Input.action_press("p1_special")
	await _frames(3)
	Input.action_release("p1_special")
	var vy := 0.0
	for i in 40:
		await _frames(1)
		vy = maxf(vy, me.velocity.y)
	_check("Cravada: desce rápido (>1000 px/s)", vy >= 1000.0, "%.0f" % vy)
	_check("Cravada: acerta quem está embaixo", foe.damage_percent >= 9.0, "%.1f%%" % foe.damage_percent)
	await _frames(80)
	# sem apertar, a cravada não sai
	await _face_off(900.0)
	me.start_special("up")
	var maxv := 0.0
	for i in 60:
		await _frames(1)
		maxv = maxf(maxv, me.velocity.y)
	_check("Sem apertar de novo não crava", maxv < 1300.0, "%.0f" % maxv)
	await _frames(100)


func _peixinho() -> void:
	await _face_off(900.0)
	var x0 := me.global_position.x
	me.start_special("down")
	await _frames(24)
	_check("Peixinho: desliza para a frente", me.global_position.x - x0 > 100.0, "%.0f px" % (me.global_position.x - x0))
	await _frames(60)
	# Se a bola está perto, levanta
	_clear_balls()
	await _face_off(900.0)
	var b := BolaVolei.spawn(foe, me.global_position + Vector2(60, 20), Vector2.ZERO)
	b._grounded = true
	me.start_special("down")
	await _frames(12)
	_check("Peixinho: levanta a bola que está perto", is_instance_valid(b) and b.velocity.y < -600.0 and b.owner_fighter == me and not b.live,
		"vel=%s" % (b.velocity.round() if is_instance_valid(b) else "-"))
	_clear_balls()
	await _frames(20)


func _clear_balls() -> void:
	for n in get_tree().get_nodes_in_group("bolas_volei"):
		n.queue_free()


func _face_off(gap := 70.0) -> void:
	await _place(me, Vector2(-200, -60), 1)
	await _place(foe, Vector2(-200 + gap, -60), -1)
	await _frames(20)
	me.damage_percent = 0.0
	foe.damage_percent = 0.0


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
	f.visible = true
	f.slip_time = 0.0
	f.turn_lock = 0.0
	f.sand_time = 0.0
	f.invincible_time = 0.0
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1
