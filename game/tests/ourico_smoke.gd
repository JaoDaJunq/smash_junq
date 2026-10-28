extends Node
## Teste do Espeto (ouriço roqueiro): golpes básicos e a mecânica própria:
## espinhos (arrepiado devolve 3% a quem bate corpo a corpo, mas fica mais lento),
## power chord (3 espinhos em leque), stage dive (rola e quica) e microfonia (sobe).
##   godot --headless --path game res://tests/ourico_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const ID := "ourico"

var results: Array[String] = []
var failures := 0
var me: Espeto
var foe: Fighter
var _match: Node


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var idx := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i].get("id", "") == ID:
			idx = i
	_check("%s está no elenco" % ID, idx >= 0, str(idx))
	if idx >= 0 and Game.character_ready(idx):
		await _start(idx)
		await _basics()
		await _espinhos()
		await _power_chord()
		await _stage_dive()
		await _microfonia()
		_match.queue_free()
		await _frames(5)
	else:
		results.append("[PULADO] %s: sprites ainda não importados" % ID)
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _start(idx: int) -> void:
	Game.set_character("p1", idx)
	Game.set_character("p2", 0)
	_match = MATCH.instantiate()
	add_child(_match)
	await _frames(240)
	for f in _match.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f as Espeto
		else:
			foe = f
	foe.brain = null   # o boneco vira "jogador 2" de teclado: não age sozinho
	foe.controls = FighterControls.new("p2")
	_check("Espeto com arte", me != null and me.has_art, "")
	var roster_ok: bool = Roster.slot(Roster.cell_of(idx))["name"] == "Espeto"
	_check("Espeto está na grade de seleção", roster_ok, str(Roster.cell_of(idx)))


func _basics() -> void:
	for mv in ["jab", "ftilt", "utilt", "dtilt"]:
		await _face_off()
		me.start_attack(mv)
		await _frames(50)
		_check("%s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for mv in ["nair", "fair", "bair", "uair", "dair"]:
		await _face_off()
		me.global_position.y -= 70.0
		me.start_attack(mv)
		await _frames(60)
		_check("aéreo %s roda sem travar" % mv, me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])
	await _face_off()
	me.start_attack("jab")
	await _frames(20)
	me.start_attack("jab2")
	await _frames(25)
	me.start_attack("jab3")
	await _frames(40)
	_check("jab 1-2-3 acertam", foe.damage_percent >= 5.0, "%.1f%%" % foe.damage_percent)


func _espinhos() -> void:
	# sem arrepiar: bater nele não machuca quem bate
	await _face_off()
	foe.start_attack("jab")
	await _frames(30)
	_check("Espinhos: desarrepiado, quem bate não toma nada", me.damage_percent > 0.0 and foe.damage_percent == 0.0,
		"eu %.1f%%, ele %.1f%%" % [me.damage_percent, foe.damage_percent])
	# arrepiar: fica mais lento e devolve 3%
	await _face_off()
	var walk0 := me.walk_speed
	me.start_special("down")
	await _frames(14)
	_check("Espinhos: arrepiado fica mais lento", me.is_spiky() and me.walk_speed < walk0 * 0.8, "%.0f -> %.0f" % [walk0, me.walk_speed])
	await _frames(30)
	foe.start_attack("ftilt")
	await _frames(30)
	_check("Espinhos: arrepiado devolve 3% a quem bate", me.damage_percent > 0.0 and is_equal_approx(foe.damage_percent, 3.0),
		"eu %.1f%%, ele %.1f%%" % [me.damage_percent, foe.damage_percent])
	# projétil não machuca quem atira
	await _face_off(300.0)
	me.start_special("down")
	await _frames(20)
	var shot := AttackData.new()
	shot.damage = 2.0
	shot.hitbox_radius = 10.0
	Projectile.spawn(preload("res://scenes/combat/projectile.tscn"), foe, shot, me.global_position + Vector2(120, -10), Vector2(-500, 0), 1.0)
	await _frames(30)
	_check("Espinhos: projétil de fora não leva o retorno", me.damage_percent >= 2.0 and foe.damage_percent == 0.0,
		"eu %.1f%%, ele %.1f%%" % [me.damage_percent, foe.damage_percent])
	# acaba em 1,5 s e a velocidade volta
	await _frames(100)
	_check("Espinhos: depois de 1,5 s abaixa e a velocidade volta", not me.is_spiky() and is_equal_approx(me.walk_speed, walk0), "%.0f" % me.walk_speed)
	await _face_off()
	foe.start_attack("jab")
	await _frames(30)
	_check("Espinhos: passou o tempo, não devolve mais", foe.damage_percent == 0.0, "%.1f%%" % foe.damage_percent)


func _power_chord() -> void:
	await _face_off(200.0)
	me.start_special("neutral")
	var most := 0
	for i in 40:
		await _frames(1)
		most = maxi(most, _projectiles(me).size())
	_check("Power chord: solta 3 espinhos em leque", most == 3, str(most))
	_check("Power chord: o espinho acerta de perto", foe.damage_percent >= 2.5, "%.1f%%" % foe.damage_percent)
	await _frames(40)
	await _face_off(700.0)
	me.start_special("neutral")
	await _frames(60)
	_check("Power chord: alcance curto, não pega longe", foe.damage_percent == 0.0 and _projectiles(me).is_empty(), "%.1f%%" % foe.damage_percent)


func _stage_dive() -> void:
	await _face_off(260.0)
	var x0 := me.global_position.x
	me.start_special("side")
	var landed := 0
	var on_floor_prev := false
	for i in 140:
		await _frames(1)
		var fl := me.is_on_floor()
		if fl and not on_floor_prev and i > 16:
			landed += 1
		on_floor_prev = fl
		if me.state != Fighter.State.ATTACK and i > 20:
			break
	_check("Stage dive: avança rolando e acerta", foe.damage_percent >= 8.0, "%.1f%%, andou %.0f px" % [foe.damage_percent, me.global_position.x - x0])
	_check("Stage dive: quica (2 pousos)", landed >= 2, "%d pousos" % landed)
	await _frames(40)
	_check("Stage dive: termina sem travar", me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])


func _microfonia() -> void:
	await _face_off(600.0)
	foe.global_position = Vector2(3000, -3000)
	await _place(me, Vector2(-200, -200), 1)
	var y0 := me.global_position.y
	me.start_special("up")
	var top := y0
	for i in 40:
		await _frames(1)
		top = minf(top, me.global_position.y)
	_check("Microfonia: joga para o alto", y0 - top > 150.0, "subiu %.0f px" % (y0 - top))
	var was_helpless := false
	for i in 50:
		await _frames(1)
		was_helpless = was_helpless or me.helpless
	_check("Microfonia: depois fica sem golpe até pousar", was_helpless, "helpless=%s" % was_helpless)
	await _frames(60)


func _face_off(gap := 70.0) -> void:
	for n in get_tree().get_nodes_in_group("projectiles"):
		n.queue_free()
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
	f._launch = Vector2.ZERO
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	f.slip_time = 0.0
	f.turn_lock = 0.0
	f.sand_time = 0.0
	f.invincible_time = 0.0
	f._ledge = null
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1


func _projectiles(owner_f: Fighter) -> Array:
	var out := []
	for p in get_tree().get_nodes_in_group("projectiles"):
		if p.owner_fighter == owner_f and not p.is_queued_for_deletion():
			out.append(p)
	return out
