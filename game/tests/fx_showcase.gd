extends Node
## Vitrine dos efeitos (pacote de efeitos e arena): dispara cada efeito numa
## partida real e salva screenshots em evidence/etapa-3/. Precisa de renderização;
## para não aparecer na tela, rode com a janela fora da área visível:
##   godot --path game --position -10000,-10000 res://tests/fx_showcase.tscn

const MATCH_SCENE := preload("res://scenes/match.tscn")

var evidence_dir := ""
var m: Node
var p1: Fighter
var p2: Fighter


func _ready() -> void:
	evidence_dir = ProjectSettings.globalize_path("res://").path_join("../evidence/etapa-3")
	DirAccess.make_dir_recursive_absolute(evidence_dir)
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	m = MATCH_SCENE.instantiate()
	add_child(m)
	await _frames(2)
	m.skip_countdown()
	p1 = m.fighters["p1"]
	p2 = m.fighters["p2"]
	for f in [p1, p2]:
		f.set_physics_process(true)
	await _frames(70)

	# Golpe forte: faísca, estouro, arco e rastro
	_place(p1, Vector2(-80, -56), 1)
	_place(p2, Vector2(-10, -56), -1)
	await _frames(6)
	p2.damage_percent = 110.0
	p2.receive_hit(p1, p1.moveset.fair, 1)
	await _frames(3)
	await _shot("fx-01-golpe-forte")
	await _frames(14)
	await _shot("fx-02-rastro")

	# Escudo quebrando
	_place(p1, Vector2(-300, -56), 1)
	_place(p2, Vector2(200, -56), -1)
	await _frames(10)
	p2.shield_hp = 0.5
	p2._enter_shield()
	p2._break_shield()
	await _frames(4)
	await _shot("fx-03-escudo-quebra")
	await _frames(90)

	# KO: feixe saindo da borda
	_place(p2, Vector2(1500, -400), -1)
	await _frames(4)
	await _shot("fx-04-ko")
	# Plataforma de retorno
	await _frames(40)
	await _shot("fx-05-plataforma-retorno")

	# Poeira de pouso
	_place(p1, Vector2(0, -700), 1)
	p1.velocity = Vector2(0, 1500)
	p1.fast_falling = true
	await _frames(2)  # is_on_floor() só se atualiza no próximo movimento
	p1.landed.connect(func(v: float) -> void: print("landed v=", v, " conexoes=", p1.landed.get_connections().size()))
	for i in 120:
		await get_tree().physics_frame
		if p1.is_on_floor():
			break
	await _frames(3)
	await _shot("fx-06-pouso")
	print("Screenshots salvos em ", evidence_dir)
	get_tree().quit()


func _place(f: Fighter, pos: Vector2, face: int) -> void:
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.state = Fighter.State.AIR
	f.facing = face
	f._hitstun = 0.0
	f._hitstop = 0


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _shot(name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(evidence_dir.path_join(name + ".png"))
