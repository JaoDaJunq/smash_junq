extends Node
## Diagnóstico (revisão r11) da Marianinha, Dona Canga e Seu Capivas nas 4 arenas.
## Não é teste de passar/falhar: mede e imprime números de cada situação
## (objeto em cima de chão? efeito no lugar certo? recuperação volta?) e grava
## evidence/revisao-r11/trio_diag.json. Linhas com "[ALERTA]" são suspeitas.
##   godot --headless --path game res://tests/trio_diag.tscn [-- <arena 0-3> ...]

const MATCH := preload("res://scenes/match.tscn")
const MARI := 4
const CANGA := 3
const CAPIVAS := 1
const JUBA := 0
const PEBA := 6

var out: Array = []
var me: Fighter
var foe: Fighter
var _match: Node
var arena := 0
var alerts := 0


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	Game.ko_target = 99
	Music.muted = true
	var only := OS.get_cmdline_user_args()
	for a in Game.ARENAS.size():
		if not only.is_empty() and str(a) not in only:
			continue
		arena = a
		await _start(MARI, JUBA)
		await _mari()
		await _stop()
		await _start(CANGA, JUBA)
		await _canga()
		await _stop()
		await _start(CAPIVAS, JUBA)
		await _capivas()
		await _stop()
		await _start(MARI, CAPIVAS)
		await _cama_vs_grab()
		await _stop()
		await _start(MARI, PEBA)
		await _cama_vs_peba()
		await _stop()
		await _start(CANGA, JUBA)
		await _roda_vs_ledge()
		await _stop()
		for idx in [MARI, CANGA, CAPIVAS, JUBA]:
			await _start(idx, JUBA)
			await _recovery(idx)
			await _stop()
	var path := ProjectSettings.globalize_path("res://").path_join("../evidence/revisao-r11")
	DirAccess.make_dir_recursive_absolute(path)
	var fa := FileAccess.open(path.path_join("trio_diag.json"), FileAccess.WRITE)
	fa.store_string(JSON.stringify(out, "  "))
	fa.close()
	print("ALERTAS: %d" % alerts)
	get_tree().quit(0)


# --- montagem ---

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
	for f in [me, foe]:
		f.invincible_time = 0.0


func _stop() -> void:
	for a in ["left", "right", "up", "down", "jump", "special", "attack", "shield", "grab"]:
		Input.action_release("p1_" + a)
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		n.queue_free()
	_match.queue_free()
	await _frames(5)


func _note(scn: String, data: Dictionary, alert := false) -> void:
	data["arena"] = Game.ARENAS[arena]["name"]
	data["cena"] = scn
	data["quem"] = me.display_name
	data["alerta"] = alert
	out.append(data)
	if alert:
		alerts += 1
	print(("[ALERTA] " if alert else "[ok] ") + "%s | %s | %s | %s" % [data["arena"], me.display_name, scn, JSON.stringify(data)])


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
	f.slip_time = 0.0
	f.jumps_left = f.air_jumps
	f.invincible_time = 0.0
	await _frames(settle)


func _park_foe() -> void:
	await _place(foe, Vector2(-1300, -1100), 1, 1)
	foe.set_physics_process(false)


func _wake_foe() -> void:
	foe.set_physics_process(true)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


# --- geometria da arena ---

## Bordas do palco principal (as duas quinas mais largas na altura do chão principal).
func _edges() -> Array:
	var xs: Array = []
	for l in get_tree().get_nodes_in_group("ledges"):
		var p: Vector2 = l.global_position
		if absf(p.y) < 2.0:
			xs.append(p)
	xs.sort_custom(func(a, b): return a.x < b.x)
	return xs


## Ledges de verdade (todas).
func _ledges() -> Array:
	var r: Array = []
	for l in get_tree().get_nodes_in_group("ledges"):
		r.append({"pos": l.global_position, "side": int(l.get_meta("side", 1))})
	return r


func _main_edge(side: int) -> Vector2:
	# quina do chão principal do lado pedido (y = 0); se não houver quina, procura a beirada com raio
	var best := Vector2(NAN, NAN)
	for l in _ledges():
		var p: Vector2 = l["pos"]
		if absf(p.y) < 2.0 and int(l["side"]) == side:
			if is_nan(best.x) or p.x * side > best.x * side:
				best = p
	if is_nan(best.x):
		var x := 0.0
		while _ground_y(Vector2(x + side * 8.0, -20), 1) < 5.0 and absf(x) < 1500.0:
			x += side * 8.0
		best = Vector2(x, 0)
	return best


func _platforms() -> Array:
	var r: Array = []
	for n in _match.find_children("*", "CollisionObject2D", true, false):
		var b := n as CollisionObject2D
		if b is Fighter:
			continue
		if b.collision_layer & Fighter.LAYER_PLATFORM:
			r.append({"node": b, "pos": b.global_position, "moving": b is AnimatableBody2D})
	return r


## y do primeiro chão (mask) abaixo de p (até 2000 px); INF se não houver.
func _ground_y(p: Vector2, mask := 3) -> float:
	var q := PhysicsRayQueryParameters2D.create(p, p + Vector2(0, 2000), mask)
	var hit := get_viewport().world_2d.direct_space_state.intersect_ray(q)
	return INF if hit.is_empty() else hit.position.y


## Há chão (estágio ou plataforma) encostado em p (até 10 px abaixo)?
func _supported(p: Vector2) -> bool:
	var q := PhysicsRayQueryParameters2D.create(p + Vector2(0, -6), p + Vector2(0, 10), 3)
	return not get_viewport().world_2d.direct_space_state.intersect_ray(q).is_empty()


## p está dentro de rocha (estágio)?
func _inside_rock(p: Vector2) -> bool:
	var q := PhysicsPointQueryParameters2D.new()
	q.position = p
	q.collision_mask = Fighter.LAYER_STAGE
	return not get_viewport().world_2d.direct_space_state.intersect_point(q).is_empty()


func _v(p: Vector2) -> Array:
	return [snappedf(p.x, 1), snappedf(p.y, 1)]


# --- Marianinha ---

func _cama() -> CamaElastica:
	for c in get_tree().get_nodes_in_group("camas_elasticas"):
		if is_instance_valid(c) and not c.is_queued_for_deletion():
			return c
	return null


func _clear_objs() -> void:
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		n.queue_free()
	await _frames(2)


func _mari() -> void:
	await _park_foe()
	var m := me as Marianinha
	# 1) cama na beirada de cada lado
	for side in [-1, 1]:
		await _clear_objs()
		var e := _main_edge(side)
		await _place(m, Vector2(e.x - side * 12.0, e.y - 60), -side, 30)
		m.start_special("up")
		await _frames(20)
		var c := _cama()
		var ok := c != null
		var l := c != null and _supported(c.global_position + Vector2(-CamaElastica.WIDTH * 0.5 + 4, 0))
		var r := c != null and _supported(c.global_position + Vector2(CamaElastica.WIDTH * 0.5 - 4, 0))
		_note("cama na beirada lado %d" % side, {"cama": _v(c.global_position) if ok else null, "pe_esq_no_chao": l, "pe_dir_no_chao": r},
			not ok or not (l and r))
		await _frames(60)
	# 2) cama em cima de cada plataforma
	for p in _platforms():
		await _clear_objs()
		var top: Vector2 = (p["node"] as Node2D).global_position
		await _place(m, top + Vector2(0, -70), 1, 25)
		var stood := m.is_on_floor()
		var y_before := m.global_position.y
		m.start_special("up")
		await _frames(45)
		var c := _cama()
		var top2: Vector2 = (p["node"] as Node2D).global_position
		var d := {"plataforma": _v(top2), "movel": p["moving"], "ela_em_pe": stood, "y_pes": snappedf(y_before + 55, 1),
			"cama": _v(c.global_position) if c != null else null}
		_note("cama em cima de plataforma", d, c == null or absf(c.global_position.y - top2.y) > 12.0)
		await _frames(40)
	# 3) queda rápida em cima da cama: quica?
	await _clear_objs()
	await _place(m, Vector2(-120, -60), 1, 30)
	m.start_special("up")
	await _frames(70)
	var c3 := _cama()
	if c3 != null:
		await _place(m, c3.global_position + Vector2(0, -400), 1, 1)
		m.fast_falling = true
		var min_y := 99999.0
		var bounced := false
		for i in 70:
			await _frames(1)
			if c3._squash > 0.0:
				bounced = true
			if bounced:
				min_y = minf(min_y, m.global_position.y)
		var rise := c3.global_position.y - 55.0 - min_y
		_note("queda rápida na cama", {"quicou": bounced, "subiu_px": snappedf(rise, 1)}, bounced and rise < 150.0)
		# sem queda rápida, para comparar
		await _place(m, c3.global_position + Vector2(0, -400), 1, 1)
		min_y = 99999.0
		bounced = false
		for i in 90:
			await _frames(1)
			if c3._squash > 0.0:
				bounced = true
			if bounced:
				min_y = minf(min_y, m.global_position.y)
		_note("queda normal na cama", {"quicou": bounced, "subiu_px": snappedf(c3.global_position.y - 55.0 - min_y, 1)})
	# 4) arco no chão em direção à borda e (Caatinga) em direção à laje
	for side in [-1, 1]:
		await _clear_objs()
		var e := _main_edge(side)
		await _place(m, Vector2(e.x - side * 200.0, -60), side, 30)
		m.start_special("side")
		var p_hoop: Projectile = null
		var max_out := 0.0
		var in_rock := 0
		var ys: Array = []
		for i in 80:
			await _frames(1)
			if p_hoop == null:
				for n in get_tree().get_nodes_in_group("match_cleanup"):
					if n is Projectile:
						p_hoop = n
			if p_hoop != null and is_instance_valid(p_hoop):
				var hp := p_hoop.global_position
				if (hp.x - e.x) * side > max_out:
					max_out = (hp.x - e.x) * side
				if _inside_rock(hp):
					in_rock += 1
				if i % 8 == 0:
					ys.append(snappedf(hp.y, 1))
		_note("arco no chão para a borda lado %d" % side, {"saiu_do_palco_px": snappedf(max_out, 1), "quadros_dentro_da_rocha": in_rock, "y": ys},
			in_rock > 0)
	# 5) magnésio encostado na borda: quanto o adversário escorrega
	await _clear_objs()
	_wake_foe()
	var e5 := _main_edge(1)
	await _place(foe, Vector2(e5.x - 220.0, -60), -1, 25)
	await _place(m, Vector2(e5.x - 280.0, -60), 1, 25)
	var x0 := foe.global_position.x
	m.start_special("down")
	var fell := false
	for i in 120:
		await _frames(1)
		if foe.global_position.y > 60.0:
			fell = true
	_note("magnésio: adversário escorrega", {"escorregou_px": snappedf(foe.global_position.x - x0, 1), "caiu_do_palco": fell,
		"dano": snappedf(foe.damage_percent, 0.1)}, fell)
	# 6) fita perto da laje (Caatinga) / dano total segurando
	await _clear_objs()
	await _place(foe, Vector2(-100.0 + 200.0, -60), -1, 20)
	await _place(m, Vector2(-100.0, -60), 1, 20)
	foe.damage_percent = 0.0
	Input.action_press("p1_special")
	m.start_special("neutral")
	await _frames(100)
	Input.action_release("p1_special")
	await _frames(40)
	_note("fita segurada inteira", {"dano_total": snappedf(foe.damage_percent, 0.1), "nota": m.score})
	# 7) nota 10 + fita: o bônus é gasto sem bônus?
	await _clear_objs()
	await _place(foe, Vector2(100.0, -60), -1, 20)
	await _place(m, Vector2(-100.0, -60), 1, 20)
	m.score = 9
	m._last_scored = "jab"
	m._perfect_ready = false
	foe.damage_percent = 0.0
	Input.action_press("p1_special")
	m.start_special("neutral")
	var used_at := -1.0
	for i in 60:
		await _frames(1)
		if m.score == Marianinha.NOTE_MIN and used_at < 0.0 and foe.damage_percent > 0.0:
			used_at = foe.damage_percent
	Input.action_release("p1_special")
	await _frames(30)
	_note("nota 9 + fita: o 10 é consumido pela própria fita", {"dano_quando_gastou": used_at, "pronto_depois": m._perfect_ready, "nota_final": m.score},
		used_at > 0.0 and not m._perfect_ready)
	# 8) nota 10 + arco: o arco ganha +50% e não gasta (dá para repetir)
	await _clear_objs()
	await _place(foe, Vector2(250.0, -60), -1, 20)
	await _place(m, Vector2(-100.0, -60), 1, 20)
	m._perfect_ready = true
	m.score = 10
	var dmg: Array = []
	for k in 3:
		foe.damage_percent = 0.0
		await _place(foe, Vector2(250.0, -60), -1, 15)
		await _place(m, Vector2(-100.0, -60), 1, 15)
		m.start_special("side")
		await _frames(50)
		dmg.append(snappedf(foe.damage_percent, 0.1))
	_note("nota 10 + arco repetido", {"dano_cada_arco": dmg, "ainda_pronto": m._perfect_ready, "base": m.moveset.special_side.damage},
		m._perfect_ready and dmg.size() == 3 and float(dmg[2]) > m.moveset.special_side.damage * 1.2)
	foe.set_physics_process(true)


# --- Dona Canga ---

func _flag() -> Estandarte:
	for c in get_tree().get_nodes_in_group("estandartes"):
		if is_instance_valid(c) and not c.is_queued_for_deletion() and c._fall < 0.0:
			return c
	return null


func _canga() -> void:
	await _park_foe()
	var c := me as DonaCanga
	# 1) estandarte de frente para a beirada (perto e um pouco longe)
	for side in [-1, 1]:
		for gap in [20.0, 90.0]:
			await _clear_objs()
			var e := _main_edge(side)
			await _place(c, Vector2(e.x - side * gap, -60), side, 30)
			c.start_special("side")
			await _frames(40)
			var f := _flag()
			var ok := f != null
			var sup := ok and _supported(f.global_position)
			var rock := ok and _inside_rock(f.global_position + Vector2(0, -20))
			_note("estandarte a %d px da beirada lado %d" % [gap, side], {"bandeira": _v(f.global_position) if ok else null,
				"apoiada": sup, "dentro_da_rocha": rock, "canga_x": snappedf(c.global_position.x, 1)}, not ok or not sup or rock)
	# 2) em cima de cada plataforma
	for p in _platforms():
		await _clear_objs()
		var top: Vector2 = (p["node"] as Node2D).global_position
		await _place(c, top + Vector2(-60, -70), 1, 25)
		var stood := c.is_on_floor()
		c.start_special("side")
		await _frames(40)
		var f := _flag()
		var top2: Vector2 = (p["node"] as Node2D).global_position
		var d := {"plataforma": _v(top2), "movel": p["moving"], "ela_em_pe": stood, "bandeira": _v(f.global_position) if f else null,
			"apoiada": f != null and _supported(f.global_position), "canga_coberta": f != null and f.covers(c.global_position)}
		_note("estandarte em cima de plataforma", d, f == null or not d["apoiada"] or not d["canga_coberta"] or absf(f.global_position.y - top2.y) > 12.0)
	# 3) estandarte de frente para a laje / parede (procura degraus de rocha no palco)
	for side in [-1, 1]:
		var x := 0.0
		var wall := NAN
		while absf(x) < 900.0:
			if _ground_y(Vector2(x, -400), 1) < -20.0:
				wall = x
				break
			x += side * 8.0
		if is_nan(wall):
			continue
		for gap in [60.0, 120.0]:
			await _clear_objs()
			await _place(c, Vector2(wall - side * gap, -60), side, 30)
			c.start_special("side")
			await _frames(40)
			var f := _flag()
			_note("estandarte de frente para a laje (%d px)" % gap, {"parede_x": wall, "bandeira": _v(f.global_position) if f else null,
				"dentro_da_rocha": f != null and _inside_rock(f.global_position + Vector2(0, -20)), "apoiada": f != null and _supported(f.global_position)},
				f != null and _inside_rock(f.global_position + Vector2(0, -20)))
	# 4) voo planado (cima): altura ganha
	await _clear_objs()
	await _place(c, Vector2(0, -60), 1, 25)
	var y0 := c.global_position.y
	c.start_special("up")
	var top_y := y0
	for i in 60:
		await _frames(1)
		top_y = minf(top_y, c.global_position.y)
	_note("voo (cima): altura", {"subiu_px": snappedf(y0 - top_y, 1)})
	# 5) roda de baiana segurada no boneco: dano e nota
	_wake_foe()
	await _clear_objs()
	await _place(foe, Vector2(60, -60), -1, 20)
	await _place(c, Vector2(-60, -60), 1, 20)
	foe.damage_percent = 0.0
	c.note = 0.0
	c._beat_clock = DonaCanga.BEAT - float(c.moveset.special_neutral.startup + 1) / 60.0
	Input.action_press("p1_special")
	c.start_special("neutral")
	await _frames(120)
	Input.action_release("p1_special")
	await _frames(40)
	_note("roda de baiana segurada (na batida)", {"dano_total": snappedf(foe.damage_percent, 0.1), "nota": c.note, "apoteose": c.apoteose > 0.0})
	# 6) estandarte + 4 jabs = apoteose? quanto tempo
	await _clear_objs()
	await _place(foe, Vector2(70, -60), -1, 20)
	await _place(c, Vector2(-60, -60), 1, 20)
	c.note = 0.0
	c.apoteose = 0.0
	c.facing = -1
	c.start_special("side")
	await _frames(40)
	c.facing = 1
	var t := 0
	while c.apoteose <= 0.0 and t < 12:
		await _place(foe, Vector2(c.global_position.x + 70, -60), -1, 10)
		c.start_attack("ftilt")
		await _frames(40)
		t += 1
	_note("estandarte: golpes até a Apoteose", {"golpes": t, "apoteose": c.apoteose > 0.0})


# --- Seu Capivas ---

func _count_fx(tex_name: String) -> Array:
	var r: Array = []
	for n in _match.get_children(true) + get_tree().get_nodes_in_group("match_cleanup"):
		if n is PixelFx and (n as PixelFx).texture != null and (n as PixelFx).texture.resource_path.ends_with(tex_name) and not r.has(n):
			r.append(n)
	return r


func _capivas() -> void:
	await _park_foe()
	var p := me as Pesado
	# 1) pisão no ar (mergulho) de bem alto: quantos tchibuns e onde
	for h in [-450.0, -250.0]:
		await _clear_objs()
		await _place(p, Vector2(0, h), 1, 1)
		p.start_special("down")
		var seen := {}
		var ys: Array = []
		for i in 90:
			await _frames(1)
			for fx in _count_fx("fx_tchibum.png"):
				if not seen.has(fx):
					seen[fx] = true
					ys.append(snappedf((fx as Node2D).global_position.y, 1))
		var ground := 0.0 - 56.0
		var floating := ys.filter(func(y): return absf(y - ground) > 20.0)
		_note("pisão no ar (de y=%d)" % h, {"tchibuns": ys.size(), "y_dos_tchibuns": ys.slice(0, 12), "fora_do_chao": floating.size(), "esperado_y": ground},
			ys.size() > 2 or floating.size() > 0)
	# 2) pisão no chão
	await _clear_objs()
	await _place(p, Vector2(0, -60), 1, 25)
	p.start_special("down")
	var n2 := 0
	var seen2 := {}
	for i in 60:
		await _frames(1)
		for fx in _count_fx("fx_tchibum.png"):
			if not seen2.has(fx):
				seen2[fx] = true
				n2 += 1
	_note("pisão no chão", {"tchibuns": n2}, n2 != 1)
	# 3) pancada carregada: quantas bufadas segurando a carga inteira
	await _clear_objs()
	await _place(p, Vector2(0, -60), 1, 25)
	Input.action_press("p1_special")
	p.start_special("neutral")
	var seen3 := {}
	var frames_at: Array = []
	for i in 75:
		await _frames(1)
		for fx in _count_fx("fx_bufada.png"):
			if not seen3.has(fx):
				seen3[fx] = true
				frames_at.append(i)
	Input.action_release("p1_special")
	await _frames(40)
	_note("pancada carregada: bufadas", {"bufadas": seen3.size(), "quadros": frames_at}, seen3.size() < 3)
	# 4) pisão no ar fora do palco: tem como salvar?
	await _clear_objs()
	var e := _main_edge(1)
	await _place(p, Vector2(e.x + 60.0, -200), 1, 1)
	p.start_special("down")
	var grabbed := false
	for i in 80:
		await _frames(1)
		if p.state == Fighter.State.LEDGE:
			grabbed = true
	_note("pisão no ar logo depois da beirada", {"agarrou_a_quina": grabbed, "y_final": snappedf(p.global_position.y, 1), "estado": Fighter.State.keys()[p.state]},
		not grabbed)
	# 5) agarrão (lado) de frente para a beirada: sai do palco?
	_wake_foe()
	await _clear_objs()
	await _place(foe, Vector2(e.x - 20.0, -60), -1, 20)
	await _place(p, Vector2(e.x - 90.0, -60), 1, 20)
	p.start_special("side")
	await _frames(60)
	_note("agarrão (lado) perto da beirada", {"capivas_x": snappedf(p.global_position.x, 1), "borda_x": e.x, "no_chao": p.is_on_floor(),
		"dano_alvo": snappedf(foe.damage_percent, 0.1)})


# --- Interações ---

## Capivas agarra (especial lado no ar) a Marianinha em cima da cama elástica.
func _cama_vs_grab() -> void:
	var m := me as Marianinha
	var p := foe as Pesado
	await _clear_objs()
	await _place(m, Vector2(-150, -60), 1, 25)
	m.start_special("up")
	await _frames(80)
	var c := _cama()
	if c == null:
		_note("cama x agarrão do Capivas", {"erro": "sem cama"}, true)
		return
	await _place(p, c.global_position + Vector2(-40, -260), 1, 1)
	await _place(m, c.global_position + Vector2(25, -260), -1, 1)
	m.set_physics_process(false)
	p.start_special("side")
	await _frames(12)
	m.set_physics_process(true)
	var held_frames := 0
	for i in 600:
		await _frames(1)
		if m.state == Fighter.State.HELD:
			held_frames += 1
	_note("cama x agarrão do Capivas no ar", {"quadros_presa": held_frames, "estado_mari": Fighter.State.keys()[m.state],
		"estado_capivas": Fighter.State.keys()[p.state], "capivas_holding": p.holding != null, "attack_id_capivas": p.attack_id},
		held_frames > 90)
	p.release_hold()


## Seu Peba cava (especial baixo) e passa por cima da cama elástica.
func _cama_vs_peba() -> void:
	var m := me as Marianinha
	var peba := foe
	await _clear_objs()
	await _place(m, Vector2(-200, -60), 1, 25)
	m.start_special("up")
	await _frames(80)
	var c := _cama()
	if c == null:
		return
	await _place(m, Vector2(-500, -60), 1, 5)
	var worst := {}
	for dx in [-160.0, -120.0, -80.0]:
		c._age = 0.0
		await _place(peba, Vector2(c.global_position.x + dx, -60), 1, 25)
		c._age = 0.0
		c._cool.clear()
		peba.start_special("down")
		await _frames(70)
		worst = {"dx": dx, "visivel": peba.visible, "estado": Fighter.State.keys()[peba.state], "attack_id": peba.attack_id,
			"pos": _v(peba.global_position)}
		await _frames(60)
		worst["visivel_2s_depois"] = peba.visible
		if not peba.visible:
			break
	_note("cama x Toca do Peba", worst, not bool(worst.get("visivel_2s_depois", true)))


## Roda de baiana perto de quem está pendurado na quina.
func _roda_vs_ledge() -> void:
	var c := me as DonaCanga
	var e := _main_edge(1)
	await _clear_objs()
	await _place(foe, Vector2(e.x + 40, 40), -1, 1)
	foe.velocity.y = 10
	var lg = null
	for l in get_tree().get_nodes_in_group("ledges"):
		if (l as Node2D).global_position.distance_to(e) < 2.0:
			lg = l
	if lg == null:
		return
	foe._grab_ledge(lg, int(lg.get_meta("side", 1)))
	await _place(c, Vector2(e.x - 90, -60), 1, 15)
	var x0 := foe.global_position.x
	Input.action_press("p1_special")
	c.start_special("neutral")
	var inside := 0
	for i in 60:
		await _frames(1)
		if _inside_rock(foe.global_position + Vector2(0, -10)):
			inside += 1
	Input.action_release("p1_special")
	await _frames(20)
	_note("roda de baiana x adversário pendurado na quina", {"x_antes": snappedf(x0, 1), "x_depois": snappedf(foe.global_position.x, 1),
		"estado": Fighter.State.keys()[foe.state], "quadros_dentro_da_rocha": inside, "dano": snappedf(foe.damage_percent, 0.1)}, inside > 0)


# --- Recuperação ---

## Do lado de fora do palco, gasta os pulos e o especial para cima segurando
## para o palco. Conta se volta (quina ou chão) ou cai.
func _recovery(idx: int) -> void:
	await _park_foe()
	var res := {}
	for side in [-1, 1]:
		var e := _main_edge(side)
		for d in [[250.0, 150.0], [400.0, 150.0], [300.0, 350.0]]:
			await _clear_objs()
			await _place(me, Vector2(e.x + side * d[0], e.y + d[1]), -side, 1)
			me.velocity = Vector2(side * 200.0, 0)
			var toward := "p1_left" if side > 0 else "p1_right"
			Input.action_press(toward)
			var used_up := false
			var ok := false
			var trace: Array = []
			for i in 240:
				await _frames(1)
				if i % 8 == 0:
					trace.append([snappedf(me.global_position.x, 1), snappedf(me.global_position.y, 1), Fighter.State.keys()[me.state].left(3)])
				if me.state == Fighter.State.LEDGE or (me.is_on_floor() and me.state != Fighter.State.RESPAWN and absf(me.global_position.y - e.y) < 200.0):
					ok = true
					break
				if me.global_position.y > 900.0 or me.state == Fighter.State.RESPAWN:
					break
				if me.state == Fighter.State.AIR and not me.helpless and me.velocity.y > 50.0:
					if me.jumps_left > 0:
						me.jumps_left -= 1
						me._jump(me.double_jump_velocity)
					elif not used_up:
						used_up = true
						me.facing = -side
						me.start_special("up")
			Input.action_release(toward)
			res["lado %d, %d px fora, %d abaixo" % [side, d[0], d[1]]] = ok
			if not ok and side == 1:
				res["trilha lado 1 %d/%d" % [d[0], d[1]]] = trace
	var fails := res.values().filter(func(v): return typeof(v) == TYPE_BOOL and not v).size()
	_note("recuperação (pulos + especial cima)", {"resultado": res, "falhas": fails}, false)
	_wake_foe()
