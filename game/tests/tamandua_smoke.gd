extends Node
## Teste de fumaça do Bandeira (tamanduá, rodada 11): golpes básicos acertam e a
## mecânica de cada especial funciona (nuvem, língua, escalada, abraço).
##   godot --headless --path game res://tests/tamandua_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const PROJ := preload("res://scenes/combat/projectile.tscn")

var results: Array[String] = []
var failures := 0
var me: Bandeira
var foe: Fighter
var _match: Node


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var idx := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i].get("id", "") == "tamandua":
			idx = i
	_check("tamandua está no elenco", idx >= 0, str(idx))
	if idx < 0 or not Game.character_ready(idx):
		results.append("[PULADO] tamandua: sprites ainda não importados")
		_finish()
		return
	Game.set_character("p1", idx)
	Game.set_character("p2", 0)
	_match = MATCH.instantiate()
	add_child(_match)
	await _frames(240)
	for f in _match.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f as Bandeira
		else:
			foe = f
	_check("Bandeira com arte", me != null and me.has_art, "")
	await _basics()
	await _nuvem()
	await _lingua()
	await _escalada()
	await _abraco()
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
		_check("tamandua: %s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for mv in ["nair", "fair", "bair", "uair", "dair"]:
		await _face_off(70.0)
		await _place(me, Vector2(-200, -140), 1)
		await _place(foe, Vector2(-130, -140), -1)
		me.start_attack(mv)
		await _frames(30)
		_check("tamandua: %s roda sem travar" % mv, me.state != Fighter.State.ATTACK or me.attack_frame < 400, Fighter.State.keys()[me.state])
	for kind in ["neutral", "side", "up", "down"]:
		await _face_off()
		me.start_special(kind)
		await _frames(150)
		_check("tamandua: especial %s roda sem travar" % kind, me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])
	_clear()


func _nuvem() -> void:
	_clear()
	await _face_off(500.0)
	me.start_special("neutral")
	await _frames(20)
	var c := me.nuvem()
	_check("Nuvem: aparece à frente dele", c != null and c.global_position.x > me.global_position.x + 40.0, str(c.global_position if c != null else "-"))
	# Quem está dentro toma 1% a cada meio segundo (~2 s => 3 a 4%)
	await _place(foe, c.global_position + Vector2(0, 0), -1)
	foe.damage_percent = 0.0
	me.damage_percent = 0.0
	await _frames(120)
	_check("Nuvem: 1% a cada 0,5 s", foe.damage_percent >= 3.0 and foe.damage_percent <= 5.0, "%.1f%% em 2 s" % foe.damage_percent)
	_check("Nuvem: não machuca o dono", me.damage_percent == 0.0, "%.1f%%" % me.damage_percent)
	# Escudo: dentro da nuvem o boneco não consegue segurar
	(foe.brain as DummyBrain).behavior = DummyBrain.Behavior.SHIELD
	await _frames(10)
	var shielded := 0
	for i in 20:
		await _frames(1)
		if foe.state == Fighter.State.SHIELD:
			shielded += 1
	_check("Nuvem: tosse impede o escudo", shielded == 0, "%d de 20 quadros com escudo" % shielded)
	await _frames(60)
	_check("Nuvem some em 3 s", me.nuvem() == null, "")
	# Fora da nuvem o mesmo boneco consegue segurar o escudo (controle)
	await _place(foe, Vector2(-100, -60), -1)
	await _frames(20)
	_check("Fora da nuvem o escudo funciona", foe.state == Fighter.State.SHIELD, Fighter.State.keys()[foe.state])
	(foe.brain as DummyBrain).behavior = DummyBrain.Behavior.STAND
	# Só uma nuvem por Bandeira
	await _face_off(500.0)
	me.start_special("neutral")
	await _frames(70)
	me.start_special("neutral")
	await _frames(25)
	_check("Nuvem: só uma por vez", get_tree().get_nodes_in_group("nuvens_veneno").filter(func(n: Node) -> bool: return not n.is_queued_for_deletion()).size() == 1, "")
	_clear()
	await _frames(5)


func _lingua() -> void:
	# Engole projétil e cura 2%
	await _face_off(900.0)
	me.damage_percent = 10.0
	var shot := AttackData.new()
	shot.damage = 3.0
	shot.hitbox_radius = 10.0
	var p := Projectile.spawn(PROJ, foe, shot, me.global_position + Vector2(250, -14), Vector2(-500, 0), 3.0)
	me.start_special("side")
	await _frames(40)
	_check("Língua: engole o projétil", not is_instance_valid(p) or p.is_queued_for_deletion(), "")
	_check("Língua: projétil engolido cura 2%", is_equal_approx(me.damage_percent, 8.0) and me.eaten == 1, "%.1f%% comeu=%d" % [me.damage_percent, me.eaten])
	_check("Língua: o projétil não machucou", me.damage_percent <= 10.0, "")
	await _frames(40)
	# Puxa um pouco o adversário
	await _face_off(140.0)
	var x0 := foe.global_position.x
	me.start_special("side")
	await _frames(45)
	_check("Língua: acerta o adversário à frente", foe.damage_percent >= 3.0, "%.1f%%" % foe.damage_percent)
	_check("Língua: puxa o adversário para perto", foe.global_position.x < x0 - 5.0, "%.0f px" % (x0 - foe.global_position.x))


func _escalada() -> void:
	await _face_off(900.0)
	var y0 := me.global_position.y
	me.start_special("up")
	var top := y0
	for i in 70:
		await _frames(1)
		top = minf(top, me.global_position.y)
	_check("Escalada: sobe pelo menos 230 px", y0 - top >= 230.0, "%.0f px" % (y0 - top))
	_check("Escalada: alcance de borda maior depois", me.ledge_reach.x >= 130.0, str(me.ledge_reach))
	await _frames(200)
	_check("Escalada: alcance volta ao normal", me.ledge_reach.x < 100.0, str(me.ledge_reach))
	# Agarra a borda de mais longe: embaixo e ao lado da quina
	var ledge: Node2D = null
	for l in get_tree().get_nodes_in_group("ledges"):
		if int(l.get_meta("side", 1)) == -1 and l.global_position.x > 0.0:
			ledge = l   # borda direita do palco: o lutador fica à direita dela
	if ledge == null:
		for l in get_tree().get_nodes_in_group("ledges"):
			ledge = l
	var side: int = int(ledge.get_meta("side", 1))
	await _place(foe, Vector2(0, -600), 1)
	await _place(me, ledge.global_position + Vector2(side * 90.0, 190.0), -side)
	me.state = Fighter.State.AIR
	me.start_special("up")
	var grabbed := false
	for i in 80:
		await _frames(1)
		if me.state == Fighter.State.LEDGE:
			grabbed = true
			break
	_check("Escalada: agarra a borda mais longe", grabbed, Fighter.State.keys()[me.state])
	await _frames(10)


func _abraco() -> void:
	await _face_off(60.0)
	me.start_special("down")
	var held := false
	for i in 50:
		await _frames(1)
		if foe.state == Fighter.State.HELD:
			held = true
			break
	_check("Abraço: segura quem está à frente", held, Fighter.State.keys()[foe.state])
	_check("Abraço: segurar não machuca na hora", foe.damage_percent == 0.0, "%.1f%%" % foe.damage_percent)
	var x0 := foe.global_position.x
	await _frames(90)
	_check("Abraço: aperta e joga (muito dano)", foe.damage_percent >= 14.0, "%.1f%%" % foe.damage_percent)
	_check("Abraço: o adversário é lançado", absf(foe.global_position.x - x0) > 20.0 or foe.state == Fighter.State.HITSTUN, "%.0f px" % (foe.global_position.x - x0))
	await _frames(60)
	# Errou: sem ninguém à frente, só fica vulnerável
	await _face_off(500.0)
	me.start_special("down")
	await _frames(100)
	_check("Abraço no vazio termina sem prender", me.state != Fighter.State.ATTACK and me.holding == null and foe.damage_percent == 0.0, Fighter.State.keys()[me.state])
	# Quem está no escudo também é agarrado
	await _face_off(60.0)
	(foe.brain as DummyBrain).behavior = DummyBrain.Behavior.SHIELD
	await _frames(15)
	me.start_special("down")
	var held2 := false
	for i in 50:
		await _frames(1)
		if foe.state == Fighter.State.HELD:
			held2 = true
			break
	_check("Abraço: passa pelo escudo", held2, Fighter.State.keys()[foe.state])
	(foe.brain as DummyBrain).behavior = DummyBrain.Behavior.STAND
	await _frames(100)


func _clear() -> void:
	for n in get_tree().get_nodes_in_group("nuvens_veneno"):
		n.queue_free()
	for n in get_tree().get_nodes_in_group("projectiles"):
		n.queue_free()


func _face_off(gap := 70.0) -> void:
	_clear()
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
