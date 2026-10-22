extends Node
## Cópia de trio_shots.gd para a revisão de Canga/Marianinha/Capivas (depois das correções).
## Prints (COM janela) dos casos suspeitos da revisão r11 do trio (Marianinha,
## Dona Canga, Seu Capivas) em cada arena. Câmera parada no ponto de interesse.
## Salva evidence/revisao-r11/<arena>_<caso>.png (tela inteira 1920x1080).
##   godot --path game --resolution 1920x1080 res://tests/revisao_trio_shots.tscn [-- <arena 0-3> ...] [caso ...]

const MATCH := preload("res://scenes/match.tscn")

var me: Fighter
var foe: Fighter
var cam: Camera2D
var _match: Node
var arena := 0
var outdir := ""
var only_cases: Array = []


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	Game.ko_target = 99
	Music.muted = true
	outdir = ProjectSettings.globalize_path("res://").path_join("../evidence/revisao-canga")
	DirAccess.make_dir_recursive_absolute(outdir)
	var only_arenas: Array = []
	for a in OS.get_cmdline_user_args():
		if a.is_valid_int():
			only_arenas.append(int(a))
		else:
			only_cases.append(a)
	for a in Game.ARENAS.size():
		if not only_arenas.is_empty() and a not in only_arenas:
			continue
		arena = a
		if _want("cama"):
			await _start(4, 0)
			await _cama_shots()
			await _stop()
		if _want("estandarte"):
			await _start(3, 0)
			await _flag_shots()
			await _stop()
		if _want("tchibum"):
			await _start(1, 0)
			await _capivas_shots()
			await _stop()
		if _want("roda"):
			await _start(3, 0)
			await _roda_shot()
			await _stop()
		if _want("arco"):
			await _start(4, 0)
			await _arco_shot()
			await _stop()
		if _want("fita"):
			await _start(4, 0)
			await _fita_shot()
			await _stop()
		if _want("extra"):
			await _start(3, 0)
			await _canga_extra()
			await _stop()
		if _want("golpes"):
			await _start(3, 0)
			await _canga_golpes()
			await _stop()
			await _start(4, 1)
			await _mari_golpes()
			await _stop()
			await _start(1, 0)
			await _capivas_golpes()
			await _stop()
	get_tree().quit()


func _want(c: String) -> bool:
	return only_cases.is_empty() or c in only_cases


func _start(p1: int, p2: int) -> void:
	Game.arena_index = arena
	Game.set_character("p1", p1)
	Game.set_character("p2", p2)
	_match = MATCH.instantiate()
	add_child(_match)
	await _frames(240)
	for f in _match.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f
		else:
			foe = f
	for c in _match.find_children("*", "Camera2D", true, false):
		cam = c
	cam.set_process(false)
	cam.set_physics_process(false)


func _stop() -> void:
	for a in ["left", "right", "special"]:
		Input.action_release("p1_" + a)
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		n.queue_free()
	_match.queue_free()
	await _frames(5)


func _look(at: Vector2, zoom := 1.3) -> void:
	cam.global_position = at
	cam.zoom = Vector2(zoom, zoom)
	cam.offset = Vector2.ZERO


func _shot(name: String) -> void:
	await RenderingServer.frame_post_draw
	var key := String(Game.ARENAS[arena]["scene"]).get_file().get_basename()
	var p := outdir.path_join("%s_%s.png" % [key, name])
	get_viewport().get_texture().get_image().save_png(p)
	print("print: ", p)


func _place(f: Fighter, pos: Vector2, face := 1, settle := 20) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstop = 0
	f._hitstun = 0.0
	f.fast_falling = false
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	f.jumps_left = f.air_jumps
	f.invincible_time = 0.0
	await _frames(settle)


func _hide_foe(near: Vector2) -> void:
	await _place(foe, Vector2(near.x, -1100), 1, 1)
	foe.set_physics_process(false)
	foe.visible = false


func _main_edge(side: int) -> Vector2:
	var best := Vector2(NAN, NAN)
	for l in get_tree().get_nodes_in_group("ledges"):
		var p: Vector2 = l.global_position
		if absf(p.y) < 2.0 and int(l.get_meta("side", 1)) == side:
			if is_nan(best.x) or p.x * side > best.x * side:
				best = p
	if is_nan(best.x):
		best = Vector2(-640.0 if side < 0 else 640.0, 0)
	return best


func _platforms() -> Array:
	var r: Array = []
	for n in _match.find_children("*", "CollisionObject2D", true, false):
		if n is Fighter:
			continue
		if (n as CollisionObject2D).collision_layer & Fighter.LAYER_PLATFORM:
			r.append(n)
	return r


func _clear() -> void:
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		n.queue_free()
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


# --- casos ---

func _cama_shots() -> void:
	var e := _main_edge(1)
	await _hide_foe(e)
	await _clear()
	await _place(me, Vector2(e.x - 12.0, -60), -1, 30)
	me.start_special("up")
	await _frames(70)
	await _place(me, Vector2(e.x - 200.0, -60), -1, 10)
	_look(Vector2(e.x, -60), 2.0)
	await _frames(3)
	await _shot("cama_beirada")
	var plats := _platforms()
	if not plats.is_empty():
		var pl: Node2D = plats[0]
		await _clear()
		await _place(me, pl.global_position + Vector2(0, -70), 1, 25)
		me.start_special("up")
		await _frames(14)
		_look(pl.global_position + Vector2(0, 40), 1.4)
		await _shot("cama_plataforma_caindo")
		await _frames(50)
		await _shot("cama_plataforma_depois")


func _flag_shots() -> void:
	var e := _main_edge(1)
	await _hide_foe(e)
	await _clear()
	await _place(me, Vector2(e.x - 90.0, -60), 1, 30)
	me.start_special("side")
	await _frames(45)
	await _place(me, Vector2(e.x - 260.0, -60), -1, 10)
	_look(Vector2(e.x, -80), 2.0)
	await _frames(3)
	await _shot("estandarte_beirada")
	for o in get_tree().get_nodes_in_group("estandartes"):
		print("estandarte_beirada: ", o.global_position, " apoiado=", o.is_grounded(), " canga=", me.global_position)
	var plats := _platforms()
	if not plats.is_empty():
		var pl: Node2D = plats[plats.size() - 1]
		await _clear()
		await _place(me, pl.global_position + Vector2(-60, -70), 1, 25)
		me.start_special("side")
		await _frames(45)
		_look(pl.global_position + Vector2(40, 80), 1.4)
		await _shot("estandarte_plataforma")
	# laje (Caatinga) / parede: procura degrau no chão principal
	if arena == 2:
		await _clear()
		await _place(me, Vector2(-256.0 + 60.0, -60), -1, 30)
		me.start_special("side")
		await _frames(45)
		await _place(me, Vector2(-256.0 + 160.0, -60), -1, 5)
		_look(Vector2(-300, -80), 2.0)
		await _frames(3)
		await _shot("estandarte_laje")
	# barra da nota em cima da cabeça x setinha P1
	await _clear()
	await _place(me, Vector2(0, -60), 1, 25)
	(me as DonaCanga).note = 50.0
	_look(me.global_position + Vector2(0, -60), 2.5)
	await _frames(4)
	await _shot("nota_x_tag_p1")


func _capivas_shots() -> void:
	await _hide_foe(Vector2.ZERO)
	await _clear()
	await _place(me, Vector2(0, -470), 1, 1)
	me.start_special("down")
	_look(Vector2(0, -230), 1.2)
	await _frames(24)
	await _shot("tchibum_mergulho")
	await _frames(6)
	await _shot("tchibum_mergulho_b")
	# carregada: bufada
	await _clear()
	await _place(me, Vector2(0, -60), 1, 25)
	Input.action_press("p1_special")
	me.start_special("neutral")
	_look(me.global_position + Vector2(40, -40), 2.2)
	await _frames(40)
	await _shot("carregada_meio")
	Input.action_release("p1_special")
	await _frames(30)
	# plataforma de volta (descanso + boia)
	_match.respawn_fighter("p1")
	await _frames(20)
	_look(me.global_position + Vector2(0, 20), 2.2)
	await _frames(3)
	await _shot("boia_volta")


func _roda_shot() -> void:
	var e := _main_edge(1)
	var lg = null
	for l in get_tree().get_nodes_in_group("ledges"):
		if (l as Node2D).global_position.distance_to(e) < 2.0:
			lg = l
	if lg == null:
		return
	await _clear()
	await _place(foe, Vector2(e.x + 40, 40), -1, 1)
	foe._grab_ledge(lg, int(lg.get_meta("side", 1)))
	await _place(me, Vector2(e.x - 90, -60), 1, 15)
	Input.action_press("p1_special")
	me.start_special("neutral")
	_look(Vector2(e.x - 20, -20), 2.0)
	await _frames(22)
	await _shot("roda_x_pendurado_puxando")
	await _frames(23)
	await _shot("roda_x_pendurado")
	Input.action_release("p1_special")
	await _frames(30)


func _arco_shot() -> void:
	var e := _main_edge(1)
	await _hide_foe(e)
	await _clear()
	await _place(me, Vector2(e.x - 200.0, -60), 1, 30)
	me.start_special("side")
	_look(Vector2(e.x + 60, -40), 1.6)
	await _frames(32)
	await _shot("arco_fora_do_palco")
	if arena == 2:
		await _clear()
		await _place(me, Vector2(-30.0, -60), -1, 30)
		me.start_special("side")
		_look(Vector2(-250, -60), 1.6)
		await _frames(26)
		await _shot("arco_na_laje")


func _canga_extra() -> void:
	var c := me as DonaCanga
	await _hide_foe(Vector2.ZERO)
	await _clear()
	# pulso de plumas da batida (no chão)
	await _place(c, Vector2(0, -60), 1, 25)
	c._beat_clock = DonaCanga.BEAT - 0.02
	_look(c.global_position + Vector2(0, -10), 2.5)
	for k in 4:
		await _frames(3)
		await _shot("plumas_batida_%d" % k)
	# o mesmo pulso com a Canga escondida (para ver onde ele fica em relação ao chão)
	c.modulate.a = 0.0   # some só o desenho (a batida só pulsa com ela visível)
	c._beat_clock = DonaCanga.BEAT - 0.02
	for k in 3:
		await _frames(3)
		await _shot("plumas_batida_sem_canga_%d" % k)
	c.modulate.a = 1.0


## Fita: até onde o desenho vai x até onde ela acerta.
func _fita_shot() -> void:
	for gap in [250.0, 350.0, 450.0]:
		await _clear()
		await _place(foe, Vector2(-300.0 + gap, -60), -1, 15)
		await _place(me, Vector2(-300.0, -60), 1, 15)
		foe.damage_percent = 0.0
		Input.action_press("p1_special")
		me.start_special("neutral")
		_look(Vector2(-300.0 + 260.0, -60), 1.6)
		await _frames(30)
		await _shot("fita_alvo_a_%d" % int(gap))
		await _frames(40)
		Input.action_release("p1_special")
		await _frames(30)
		print("fita: alvo a %d px -> dano %.1f%%" % [int(gap), foe.damage_percent])


# --- casos novos (revisão Canga/Marianinha/Capivas) ---

func _canga_golpes() -> void:
	var c := me as DonaCanga
	# paradinha: confete do tamanho da área
	await _clear()
	await _place(foe, Vector2(90, -60), -1, 10)
	await _place(c, Vector2(0, -60), 1, 25)
	c.start_special("down")
	_look(Vector2(0, -60), 1.6)
	await _frames(c.moveset.special_down.startup + 4)
	await _shot("paradinha")
	await _frames(40)
	# esplendor: plumas ao subir
	await _hide_foe(Vector2.ZERO)
	await _clear()
	await _place(c, Vector2(0, -60), 1, 25)
	c.start_special("up")
	_look(Vector2(0, -160), 1.5)
	await _frames(c.moveset.special_up.startup + 5)
	await _shot("esplendor")
	await _frames(60)
	# estandarte no ar: cai até o chão
	await _clear()
	await _place(c, Vector2(-100, -380), 1, 1)
	c.state = Fighter.State.AIR
	c.start_special("side")
	_look(Vector2(0, -150), 1.3)
	await _frames(c.moveset.special_side.startup + 10)
	await _shot("estandarte_no_ar_caindo")
	await _frames(50)
	await _shot("estandarte_no_ar_depois")
	# vitória-régia (Pantanal): bandeira acompanha a folha
	var plats := _platforms()
	for pl in plats:
		if pl is AnimatableBody2D:
			await _clear()
			await _place(c, (pl as Node2D).global_position + Vector2(-40, -70), 1, 25)
			c.start_special("side")
			await _frames(30)
			await _place(c, Vector2(0, -60), 1, 5)
			await _frames(120)
			_look((pl as Node2D).global_position + Vector2(0, -40), 1.6)
			await _frames(2)
			await _shot("estandarte_vitoria_regia_2s")
			break
	# estandarte na batida + tontura
	await _clear()
	await _place(c, Vector2(0, -60), 1, 25)
	Input.action_press("p1_special")
	c.start_special("neutral")
	await _frames(DonaCanga.SPIN_MAX + c.moveset.special_neutral.startup + 6)
	Input.action_release("p1_special")
	_look(c.global_position + Vector2(0, -30), 2.2)
	await _frames(2)
	await _shot("roda_tonta")
	await _frames(60)


func _mari_golpes() -> void:
	var m := me as Marianinha
	# magnésio
	await _clear()
	await _place(foe, Vector2(70, -60), -1, 10)
	await _place(m, Vector2(0, -60), 1, 25)
	m.start_special("down")
	_look(Vector2(30, -60), 2.0)
	await _frames(m.moveset.special_down.startup + 4)
	await _shot("magnesio")
	await _frames(40)
	# cama: adversário pisa e é lançado
	await _clear()
	await _place(m, Vector2(-200, -60), 1, 25)
	m.start_special("up")
	await _frames(70)
	var camas := get_tree().get_nodes_in_group("camas_elasticas")
	if not camas.is_empty():
		var cm := camas[0] as Node2D
		await _place(foe, cm.global_position + Vector2(0, -260), 1, 1)
		_look(cm.global_position + Vector2(0, -60), 1.8)
		await _frames(12)
		await _shot("cama_adversario_quica")
	await _frames(30)
	# arco no chão (rola encostado?)
	await _hide_foe(Vector2.ZERO)
	await _clear()
	await _place(m, Vector2(-200, -60), 1, 25)
	m.start_special("side")
	_look(Vector2(-60, -50), 2.0)
	await _frames(m.moveset.special_side.startup + 8)
	await _shot("arco_rolando")
	await _frames(80)
	# nota 10 + plaquinha
	m.score = 9
	m._score_pop = 1.0
	_look(m.global_position + Vector2(0, -80), 2.5)
	await _frames(2)
	await _shot("plaquinha")


func _capivas_golpes() -> void:
	await _hide_foe(Vector2.ZERO)
	await _clear()
	await _place(me, Vector2(0, -60), 1, 25)
	me.start_special("down")
	_look(Vector2(0, -60), 1.8)
	await _frames(me.moveset.special_down.startup + 3)
	await _shot("pisao_chao")
	await _frames(50)
	await _clear()
	await _place(me, Vector2(0, -470), 1, 1)
	me.start_special("down")
	_look(Vector2(0, -150), 1.3)
	for i in 90:
		await _frames(1)
		if me.is_on_floor():
			break
	await _frames(4)
	await _shot("pisao_ar_pouso")
	await _frames(40)
	await _clear()
	await _place(me, Vector2(0, -60), 1, 25)
	me.start_special("up")
	_look(Vector2(0, -100), 1.5)
	await _frames(Pesado.UP_WINDUP + 3)
	await _shot("pulo_alto_gotas")
	await _frames(80)
