extends Node
## Teste de fumaça do pacote GOLPE GOSTOSO (sensação de impacto):
## pausa de impacto, alvo que treme na pausa, tremor de câmera em todo acerto,
## faísca e quadro de preparo dos golpes.
##   godot --headless --path game res://tests/impacto_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")

var results: Array[String] = []
var failures := 0
var m: Node
var me: Fighter
var foe: Fighter
var cam: Camera2D


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	m = MATCH.instantiate()
	add_child(m)
	await _frames(240)
	for f in m.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f
		else:
			foe = f
	foe.brain = null
	for c in m.find_children("*", "Camera2D", true, false):
		cam = c
	await _run()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	await _test_hitstop()
	await _test_target_shake()


# --- 1. Pausa de impacto ---

func _test_hitstop() -> void:
	await _face_off(0.0)
	var jab := me.moveset.jab
	foe.receive_hit(me, jab, 1)
	var want := Combat.hitstop_frames(jab.damage, foe._launch.length())
	_check("Pausa de impacto: alvo e quem bateu congelam o mesmo tanto",
		foe._hitstop == want and me._hitstop == want, "alvo=%d quem bateu=%d esperado=%d" % [foe._hitstop, me._hitstop, want])
	_check("Pausa de impacto: 8% dá 9 quadros (era 5)", Combat.hitstop_frames(8.0) == 9, str(Combat.hitstop_frames(8.0)))
	# golpe que pode matar: lançamento alto
	await _face_off(300.0)
	var strong := me.moveset.ftilt
	foe.receive_hit(me, strong, 1)
	var speed := foe._launch.length()
	var base := mini(5 + int(strong.damage * 0.55), 18)
	_check("Pausa de impacto: golpe que pode matar ganha +4 a +6 quadros",
		speed >= Combat.KILL_LAUNCH and foe._hitstop - base >= 4 and foe._hitstop - base <= 6,
		"lançamento %.0f, pausa %d (sem bônus %d)" % [speed, foe._hitstop, base])


# --- 2. Alvo treme na pausa ---

func _test_target_shake() -> void:
	await _face_off(0.0)
	var vis_foe := _visual(foe)
	var vis_me := _visual(me)
	var base_foe := vis_foe.get_node("Quadro").position as Vector2
	foe.receive_hit(me, me.moveset.ftilt, 1)
	var offs: Array[Vector2] = []
	var me_moved := false
	while foe._hitstop > 0:
		await get_tree().process_frame
		await get_tree().physics_frame
		var q: Sprite2D = vis_foe.get_node("Quadro")
		offs.append(q.position - _base_pos(vis_foe))
		if not (vis_me.get_node("Quadro").position - _base_pos(vis_me)).is_zero_approx():
			me_moved = true
	var first := offs[0] if not offs.is_empty() else Vector2.ZERO
	var alternates := offs.size() >= 3 and signf(offs[0].x) != signf(offs[1].x) and offs[0].x != 0.0
	var last := offs[offs.size() - 1] if not offs.is_empty() else Vector2.ONE
	_check("Alvo treme na pausa: começa com 3-4 px do mundo", absf(first.x) * vis_foe.pixel_scale >= 3.0 and absf(first.x) * vis_foe.pixel_scale <= 4.0 and is_zero_approx(first.y),
		"desenho %s px nativos (base %s)" % [str(offs), str(base_foe)])
	_check("Alvo treme na pausa: alterna de lado a cada quadro, no chão de lado", alternates, str(offs))
	_check("Alvo treme na pausa: termina parado", last.is_zero_approx(), str(last))
	_check("Quem bateu não treme", not me_moved, "")
	# no ar treme de cima para baixo
	await _place(me, Vector2(-70, -400), 1)
	await _place(foe, Vector2(0, -400), -1)
	foe.receive_hit(me, me.moveset.fair, 1)
	await get_tree().process_frame
	await get_tree().physics_frame
	var off_air: Vector2 = vis_foe.get_node("Quadro").position - _base_pos(vis_foe)
	_check("Alvo treme na pausa: no ar treme na vertical", is_zero_approx(off_air.x) and absf(off_air.y) > 0.0, str(off_air))


func _visual(f: Fighter) -> PixelSprite:
	for c in f.get_children():
		if c is PixelSprite:
			return c
	return null


func _base_pos(v: PixelSprite) -> Vector2:
	return Vector2(-v.center_x, -(PixelSprite.BASELINE + 1))


# --- utilidades ---

func _face_off(foe_damage: float) -> void:
	await _place(me, Vector2(-70, -60), 1)
	await _place(foe, Vector2(0, -60), -1)
	await _frames(20)
	foe.damage_percent = foe_damage


func _place(f: Fighter, pos: Vector2, face := 1) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstun = 0.0
	f._hitstop = 0
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	await _frames(2)


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
