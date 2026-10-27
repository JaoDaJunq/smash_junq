extends Node
## Conferência de TODOS os efeitos de golpe dentro do jogo (COM janela).
## Para cada cena: monta a situação, tira um recorte a cada 3 quadros
## (evidence/efeitos/<n>_<nome>.png) e anota no console quais efeitos nasceram,
## onde (em relação aos pés do lutador) e quanto tempo ficaram.
##   godot --path game --resolution 1920x1080 res://tests/fx_shots.tscn [-- <nome> ...]

const MATCH := preload("res://scenes/match.tscn")
const BOX := 300
const SCENES := [
	# [nome, personagem, efeito esperado]
	["juba_investida", 0, "fx_poeira_folhas"],
	["juba_contra", 0, "fx_ginga"],
	["capivas_bufada", 1, "fx_bufada"],
	["capivas_tchibum", 1, "fx_tchibum"],
	["capivas_boia", 1, "fx_boia"],
	["maracaja_garra", 2, "fx_garra"],
	["maracaja_sono", 2, "fx_sono"],
	["maracaja_reboco", 2, "fx_reboco"],
	["canga_plumas", 3, "fx_plumas"],
	["canga_paradinha", 3, "fx_confete"],
	["canga_estandarte", 3, "estandarte"],
	["mari_magnesio", 4, "fx_magnesio"],
	["mari_arco", 4, "arco"],
	["mari_cama", 4, "cama_elastica"],
	["mari_nota10", 4, "fx_confete"],
	["sucuri_hipnose", 5, "fx_hipnose"],
	["sucuri_aperto", 5, "fx_aperto"],
	["peba_toca", 6, "fx_terra"],
	["peba_montinho", 6, "fx_montinho"],
	["peba_lufada", 6, "fx_lufada"],
	["peba_casco", 6, "fx_faisca"],
	# rodada 12: os 4 novos ("code:" = desenho por código enquanto a folha não chega)
	["tucao_pipoca", 7, "fx_pipoca_estouro"],
	["tucao_peixinho", 7, "fx_grama_peixinho"],
	["tucao_entalado", 7, "fx_bico_entalado"],
	["tucao_trave", 7, "code:estrelas"],
	["tucao_tranco", 7, "code:tranco"],
	["onca_parado", 8, "code:parado_ai"],
	["onca_carimbo", 8, "code:carimbo"],
	["onca_algema", 8, "fx_algema"],
	["onca_faixa", 8, "faixa_interditada"],
	["cutia_cova", 9, "fx_cova"],
	["cutia_estouro", 9, "fx_estouro_castanha"],
	["cutia_carrinho", 9, "code:poeira"],
	["cutia_saquinho", 9, "code:rasgo"],
	["calango_areia", 10, "code:areia_olho"],
	["calango_sol", 10, "fx_sol"],
	["calango_corrida", 10, "code:poeira"],
	["calango_rabo", 10, "rabo_solto"],
]

var me: Fighter
var foe: Fighter
var m: Node
var out := ""
var seen := {}   # textura -> [quadro, posição relativa aos pés]


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	out = ProjectSettings.globalize_path("res://").path_join("../evidence/efeitos")
	DirAccess.make_dir_recursive_absolute(out)
	var only := OS.get_cmdline_user_args()
	var n := 0
	var report: Array[String] = []
	for s in SCENES:
		n += 1
		if not only.is_empty() and s[0] not in only:
			continue
		await _start(int(s[1]))
		seen.clear()
		var shots: Array[Image] = []
		await call("_" + s[0], shots)
		var got: Array = seen.keys()
		var ok := false
		var info := ""
		for k in got:
			if String(k).contains(s[2]):
				ok = true
				info = str(seen[k])
		report.append("%s %-18s esperado=%-16s visto=%s %s" % ["[OK]   " if ok else "[FALTA]", s[0], s[2], ",".join(got), info])
		_save_strip(shots, "%02d_%s" % [n, s[0]])
		m.queue_free()
		await _frames(5)
	print("\n".join(report))
	get_tree().quit()


func _start(idx: int) -> void:
	Game.set_character("p1", idx)
	Game.set_character("p2", 1)
	m = MATCH.instantiate()
	add_child(m)
	await _frames(240)
	for f in m.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f
		else:
			foe = f
	for cam in m.find_children("*", "Camera2D", true, false):
		cam.min_zoom = 1.5
		cam.max_zoom = 1.5
	foe.brain = null
	await _place(me, Vector2(-200, -60), 1)
	await _place(foe, Vector2(400, -60), -1)
	await _frames(20)


## Roda n quadros tirando recorte a cada 3 e anotando os efeitos que nascem.
func _watch(shots: Array[Image], n: int) -> void:
	for i in n:
		await get_tree().physics_frame
		for node in get_tree().get_nodes_in_group("match_cleanup"):
			var tex: Texture2D = null
			if node is CodeFx:
				var ck := "code:" + String(node.kind)
				if not seen.has(ck):
					seen[ck] = [i, ((node as Node2D).global_position - (me.global_position + Vector2(0, Fighter.HEIGHT * 0.5))).round()]
				continue
			if node is PixelFx:
				tex = node.texture
			elif node is Projectile:
				tex = node.sprite
			if tex == null:
				continue
			var key := tex.resource_path.get_file().get_basename()
			if not seen.has(key):
				var rel: Vector2 = (node as Node2D).global_position - (me.global_position + Vector2(0, Fighter.HEIGHT * 0.5))
				seen[key] = [i, rel.round()]
		for node in m.find_children("*", "", true, false):
			var nm := String(node.get_script().resource_path.get_file()) if node.get_script() != null else ""
			for want in ["estandarte", "cama_elastica", "faixa_interditada", "castanha_enterrada", "rabo_solto"]:
				if nm.begins_with(want) and not seen.has(want):
					seen[want] = [i, ((node as Node2D).global_position - (me.global_position + Vector2(0, Fighter.HEIGHT * 0.5))).round()]
		if i % 3 == 0:
			await RenderingServer.frame_post_draw
			shots.append(_crop())


func _crop() -> Image:
	var img := get_viewport().get_texture().get_image()
	var c := (me.global_position + foe.global_position) * 0.5 if me.global_position.distance_to(foe.global_position) < 350 else me.global_position
	var p := get_viewport().get_canvas_transform() * (c + Vector2(0, -40))
	var r := Rect2i(int(p.x) - BOX, int(p.y) - BOX, BOX * 2, BOX * 2).intersection(Rect2i(Vector2i.ZERO, img.get_size()))
	var out_img := Image.create(BOX * 2, BOX * 2, false, Image.FORMAT_RGBA8)
	var cut := img.get_region(r)
	cut.convert(Image.FORMAT_RGBA8)
	out_img.blit_rect(cut, Rect2i(Vector2i.ZERO, cut.get_size()), Vector2i.ZERO)
	return out_img


func _save_strip(shots: Array[Image], name: String) -> void:
	if shots.is_empty():
		return
	var w := shots[0].get_width()
	var strip := Image.create(w * shots.size(), w, false, Image.FORMAT_RGBA8)
	for i in shots.size():
		strip.blit_rect(shots[i], Rect2i(0, 0, w, w), Vector2i(i * w, 0))
	strip.save_png(out.path_join(name + ".png"))


func _place(f: Fighter, pos: Vector2, face := 1) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstun = 0.0
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	await _frames(2)


func _near(gap := 70.0) -> void:
	await _place(foe, me.global_position + Vector2(gap, 0), -1)
	await _frames(10)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


# --- Cenas ---

func _juba_investida(s: Array[Image]) -> void:
	me.start_special("side")
	await _watch(s, 40)

func _juba_contra(s: Array[Image]) -> void:
	await _near(80)
	me.start_special("down")
	await _frames(4)
	foe.start_attack("jab")
	await _watch(s, 45)

func _capivas_bufada(s: Array[Image]) -> void:
	Input.action_press("p1_special")
	me.start_special("neutral")
	await _watch(s, 60)
	Input.action_release("p1_special")
	await _watch(s, 20)

func _capivas_tchibum(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 45)

func _capivas_boia(s: Array[Image]) -> void:
	me.global_position = Vector2(-200, -400)
	me.start_respawn_hold(3.0)
	await _watch(s, 45)

func _maracaja_garra(s: Array[Image]) -> void:
	await _near(160)
	me.start_special("side")
	await _watch(s, 60)

func _maracaja_sono(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 60)

func _maracaja_reboco(s: Array[Image]) -> void:
	# parede de teste alta (como no maracaja_smoke), à esquerda dele
	var wall := StaticBody2D.new()
	wall.collision_layer = 1
	var ws := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(60, 600)
	ws.shape = rect
	wall.add_child(ws)
	m.add_child(wall)
	wall.global_position = Vector2(-500, -400)
	await _place(me, Vector2(-400, -500), -1)
	Input.action_press("p1_left")
	await _watch(s, 40)
	Input.action_release("p1_left")


func _canga_plumas(s: Array[Image]) -> void:
	await _watch(s, 60)

func _canga_paradinha(s: Array[Image]) -> void:
	await _near(90)
	me.start_special("down")
	await _watch(s, 70)

func _canga_estandarte(s: Array[Image]) -> void:
	me.start_special("side")
	await _watch(s, 50)

func _mari_magnesio(s: Array[Image]) -> void:
	await _near(90)
	me.start_special("down")
	await _watch(s, 50)

func _mari_arco(s: Array[Image]) -> void:
	me.start_special("side")
	await _watch(s, 60)

func _mari_cama(s: Array[Image]) -> void:
	me.start_special("up")
	await _watch(s, 60)

func _mari_nota10(s: Array[Image]) -> void:
	await _near(60)
	for mv in ["jab", "ftilt", "dtilt"]:   # 3 golpes diferentes: nota 7 -> 10
		await _place(me, Vector2(-200, -60), 1)
		await _near(60)
		me.start_attack(mv)
		await _frames(30)
	await _place(me, Vector2(-200, -60), 1)
	await _near(60)
	me.start_attack("jab")   # o golpe com nota 10 solta o confete
	await _watch(s, 40)

func _sucuri_hipnose(s: Array[Image]) -> void:
	await _near(150)
	me.start_special("neutral")
	await _watch(s, 50)

func _sucuri_aperto(s: Array[Image]) -> void:
	await _near(50)
	me.start_special("down")
	await _watch(s, 70)

func _peba_toca(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 60)

func _peba_montinho(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 60)

func _peba_lufada(s: Array[Image]) -> void:
	me.start_special("up")
	await _watch(s, 40)

func _peba_casco(s: Array[Image]) -> void:
	await _near(70)
	me.facing = -1   # de costas para o adversário
	foe.start_attack("ftilt")
	await _watch(s, 40)


# --- Rodada 12: os 4 novos (Tucão 7, Onça 8, Cutia 9, Calango 10) ---

func _big_hit() -> AttackData:
	var big := AttackData.new()
	big.damage = 14.0
	big.angle = 40.0
	big.base_knockback = 400.0
	big.knockback_growth = 8.0
	return big

func _test_wall(at: Vector2) -> StaticBody2D:
	var wall := StaticBody2D.new()
	wall.collision_layer = 1
	var ws := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(60, 600)
	ws.shape = rect
	wall.add_child(ws)
	m.add_child(wall)
	wall.global_position = at
	return wall

func _tucao_pipoca(s: Array[Image]) -> void:
	await _near(240)
	me.start_special("neutral")
	await _watch(s, 50)

func _tucao_peixinho(s: Array[Image]) -> void:
	me.start_special("side")
	await _watch(s, 36)

func _tucao_entalado(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 70)

func _tucao_trave(s: Array[Image]) -> void:
	_test_wall(me.global_position + Vector2(180, -240))
	await _frames(2)
	me.start_special("side")
	await _watch(s, 45)

func _tucao_tranco(s: Array[Image]) -> void:
	await _near(80)
	me.start_attack("ftilt")
	await _frames(1)
	foe.start_attack("jab")
	await _watch(s, 30)

func _onca_parado(s: Array[Image]) -> void:
	await _near(150)
	me.start_special("neutral")
	await _watch(s, 40)

func _onca_carimbo(s: Array[Image]) -> void:
	await _near(80)
	me.start_attack("ftilt")
	await _watch(s, 36)

func _onca_algema(s: Array[Image]) -> void:
	await _near(80)
	(me as DonaOnca).set_ficha(foe, 3)
	me.start_attack("ftilt")
	await _watch(s, 40)

func _onca_faixa(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 30)
	await _place(foe, me.global_position + Vector2(260, 0), -1)
	await _watch(s, 30)

func _cutia_cova(s: Array[Image]) -> void:
	me.start_special("down")
	await _watch(s, 45)

func _cutia_estouro(s: Array[Image]) -> void:
	me.start_special("down")
	await _frames(60)
	var c := get_tree().get_nodes_in_group("castanhas_enterradas")
	if not c.is_empty():
		await _place(foe, Vector2((c[0] as Node2D).global_position.x, me.global_position.y), -1)
	await _watch(s, 40)

func _cutia_carrinho(s: Array[Image]) -> void:
	var feet := me.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
	for dx in [100.0, 200.0]:
		CastanhaEnterrada.bury(me, CastanhaEnterrada.free_spot(me, feet + Vector2(dx, 0)), (me as CutiaLigeira)._trap_data())
	await _frames(2)
	me.start_special("side")
	await _watch(s, 45)

func _cutia_saquinho(s: Array[Image]) -> void:
	await _near(250)
	me.start_special("neutral")
	await _watch(s, 50)

func _calango_areia(s: Array[Image]) -> void:
	await _near(110)
	me.start_special("neutral")
	await _watch(s, 45)

func _calango_sol(s: Array[Image]) -> void:
	Input.action_press("p1_special")
	me.start_special("down")
	await _watch(s, 75)
	Input.action_release("p1_special")
	await _watch(s, 10)

func _calango_corrida(s: Array[Image]) -> void:
	Input.action_press("p1_special")
	me.start_special("side")
	await _watch(s, 40)
	Input.action_release("p1_special")

func _calango_rabo(s: Array[Image]) -> void:
	await _near(80)
	me.damage_percent = 150.0
	me.receive_hit(foe, _big_hit(), -1)
	await _watch(s, 45)
