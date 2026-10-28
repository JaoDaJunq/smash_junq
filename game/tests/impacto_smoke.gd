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
	await _test_camera()
	await _test_spark()
	await _test_windup()


# --- 5. Desenho do preparo e do impacto ---

## Em todo golpe do Juba com preparo, o 1º quadro do golpe mostra o 1º desenho
## do preparo e os quadros ativos mostram o desenho de impacto.
func _test_windup() -> void:
	await _place(me, Vector2(-300, -60), 1)
	await _frames(20)
	var vis := _visual(me)
	var total := 0
	var shows_first := 0
	var shows_impact := 0
	var missing: Array[String] = []
	var missing_hit: Array[String] = []
	for move_id in PixelSprite.ATTACK_ANIM:
		var data: AttackData = me.moveset.move(move_id)
		var a: String = PixelSprite.ATTACK_ANIM[move_id]
		if data == null or not vis.has_anim(a) or int(vis._impact[a]) <= 0:
			continue
		total += 1
		me.attack = data
		me.attack_id = move_id
		me.attack_frame = 1
		var first: Array = vis._attack()
		me.attack_frame = data.startup + 1
		var hit: Array = vis._attack()
		if first[1] == 0:
			shows_first += 1
		else:
			missing.append("%s(1º=%d)" % [move_id, first[1]])
		if data.active <= 0:
			shows_impact += 1   # projétil (sem quadros ativos no corpo)
		elif hit[1] == int(vis._impact[a]):
			shows_impact += 1
		else:
			missing_hit.append("%s(%s q%d, impacto %d)" % [move_id, hit[0], hit[1], int(vis._impact[a])])
	me.attack = null
	me.attack_id = ""
	_check("Preparo: 1º quadro do golpe mostra o 1º desenho em todos os golpes do Juba",
		shows_first == total, "%d de %d %s" % [shows_first, total, str(missing)])
	_check("Impacto: quadro ativo mostra o desenho de impacto", shows_impact == total, "%d de %d %s" % [shows_impact, total, str(missing_hit)])


# --- 4. Faísca ---

func _test_spark() -> void:
	await _face_off(60.0)
	var fx: Node = m.get_node("Fx")
	for c in fx.get_children():
		if c is HitSpark:
			c.free()
	foe.receive_hit(me, me.moveset.ftilt, 1)   # me à esquerda, foe à direita
	var speed := foe._launch.length()
	var spark: HitSpark = null
	var slash: Sprite2D = null
	for c in fx.get_children():
		if c is HitSpark:
			spark = c
		elif c is Sprite2D and (c as Sprite2D).texture == preload("res://assets/fx/slash_02.png"):
			slash = c
	_check("Faísca: nasce uma HitSpark no acerto", spark != null, "")
	if spark == null:
		return
	var dx := spark.global_position.x - foe.global_position.x
	_check("Faísca: puxada ~20 px para o lado de quem bateu (não tapa o rosto)", dx <= -20.0 and dx >= -40.0, "%.0f px do centro do alvo" % dx)
	_check("Faísca: nasce grande (>= 0.9) e encolhe", spark.scale.x >= 0.89, "escala inicial %.2f" % spark.scale.x)
	_check("Faísca: núcleo em mistura normal com contorno #2A0F12", spark.material == null and HitSpark.OUTLINE == Color("2A0F12"), "")
	var halo_add := false
	for c in spark.get_children():
		if c is Sprite2D and c.material is CanvasItemMaterial and c.material.blend_mode == CanvasItemMaterial.BLEND_MODE_ADD and c.show_behind_parent:
			halo_add = true
	_check("Faísca: brilho aditivo atrás", halo_add, "")
	await _frames(6)
	_check("Faísca: encolheu", is_instance_valid(spark) and spark.scale.x < 0.8, "escala %.2f" % (spark.scale.x if is_instance_valid(spark) else -1.0))
	_check("Faísca: golpe médio (lançamento %.0f) tem corte em mistura normal" % speed,
		speed < fx.medium_launch or (slash != null and slash.material == null), "corte=%s" % [slash != null])


# --- 3. Câmera ---

func _test_camera() -> void:
	Settings.screen_shake = true
	await _face_off(0.0)
	await _frames(40)   # câmera assenta e o tremor anterior some
	var pos0 := cam.global_position
	var zoom0 := cam.zoom
	foe.receive_hit(me, me.moveset.jab, 1)
	var moved_in_stop := false
	var shaking := 0
	var biggest := 0.0
	var whole := true
	var trail: Array[int] = []
	for i in 40:
		await get_tree().process_frame
		await get_tree().physics_frame
		if foe._hitstop > 0 and (cam.global_position != pos0 or cam.zoom != zoom0):
			moved_in_stop = true
		var px := cam.offset * cam.zoom   # pixels na tela
		if i < 14:
			trail.append(int(round(px.length())))
		if px.length() > 0.0:
			shaking += 1
			biggest = maxf(biggest, px.length())
		if not (px - px.round()).is_zero_approx():
			whole = false
	_check("Câmera: golpe leve (jab %.0f%%) também treme" % me.moveset.jab.damage, shaking >= 4 and biggest >= 2.0,
		"%d quadros tremendo, maior %.1f px na tela, px por quadro %s" % [shaking, biggest, str(trail)])
	_check("Câmera: tremor em pixel inteiro na tela", whole, "")
	_check("Câmera: não anda nem muda zoom durante a pausa de impacto", not moved_in_stop, "")
	# tremor desligado: nem tremor nem clarão
	Settings.screen_shake = false
	await _face_off(0.0)
	await _frames(40)
	var fx := m.get_node_or_null("Fx")
	foe.receive_hit(me, me.moveset.ftilt, 1)
	fx._screen_flash(0.3)
	await _frames(2)
	_check("Tremor desligado: câmera parada e sem clarão de tela",
		cam.offset.is_zero_approx() and fx._flash.color.a == 0.0, "offset %s, clarão %.2f" % [cam.offset, fx._flash.color.a])
	Settings.screen_shake = true
	# zoom mínimo 0.6: os dois longe ainda cabem na tela
	_check("Câmera: zoom mínimo 0.6", is_equal_approx(cam.min_zoom, 0.6), str(cam.min_zoom))
	await _place(me, Vector2(-1000, -60), 1)
	await _place(foe, Vector2(1000, -60), -1)
	await _frames(45)
	var view := Rect2(cam.get_screen_center_position() - get_viewport().get_visible_rect().size / cam.zoom * 0.5,
		get_viewport().get_visible_rect().size / cam.zoom)
	_check("Câmera: lutadores a 2000 px um do outro cabem na tela",
		view.grow(-40).has_point(me.global_position) and view.grow(-40).has_point(foe.global_position),
		"vista %s, zoom %.2f" % [view, cam.zoom.x])


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
	_check("Alvo treme na pausa: começa com 6-8 px do mundo (revisão: 3-4 quase não aparecia)", absf(first.x) * vis_foe.pixel_scale >= 6.0 and absf(first.x) * vis_foe.pixel_scale <= 8.0 and is_zero_approx(first.y),
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
