extends Node
## Prints do pacote GOLPE GOSTOSO (COM janela): janela de acerto leve (jab) e
## forte (golpe para frente com dano alto) quadro a quadro, em cada arena, e o
## enquadramento com o zoom mínimo e os lutadores nas pontas da arena.
## Saída: evidence/impacto/<arena>_leve.png, <arena>_forte.png, zoom_<arena>.png
##   godot --path game --resolution 1920x1080 res://tests/impacto_shots.tscn [-- 0 1 2 3]

const MATCH := preload("res://scenes/match.tscn")
const BOX := 170   # meia largura do recorte (px de tela)

var out := ""
var m: Node
var me: Fighter
var foe: Fighter
var cam: Camera2D


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	out = ProjectSettings.globalize_path("res://").path_join("../evidence/impacto")
	DirAccess.make_dir_recursive_absolute(out)
	var only := OS.get_cmdline_user_args()
	for arena in 4:
		if not only.is_empty() and str(arena) not in only:
			continue
		Game.arena_index = arena
		await _start()
		await _zoom_shot(arena)
		await _close_up()
		await _hit_strip("%d_leve" % arena, "jab", 0.0)
		await _hit_strip("%d_forte" % arena, "ftilt", 150.0)
		m.queue_free()
		await _frames(5)
	print("PRINTS IMPACTO: ", out)
	get_tree().quit()


func _start() -> void:
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	m = MATCH.instantiate()
	add_child(m)
	await _frames(200)
	for f in m.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f
		else:
			foe = f
	for c in m.find_children("*", "Camera2D", true, false):
		cam = c
	foe.brain = null
	me.brain = null


## Lutadores longe um do outro: a câmera tem de mostrar os dois e as bordas.
func _zoom_shot(arena: int) -> void:
	# Pontas DENTRO da zona de KO da arena (o Cerrado é menor: em ±1300 os dois
	# morriam e o print mostrava o feixe de KO atravessando a tela).
	var zone: Rect2 = m.ko_zone
	var x := minf(1300.0, -zone.position.x - 120.0)
	await _place(me, Vector2(-x, -300), 1)
	await _place(foe, Vector2(x, -300), -1)
	await _frames(25)
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	img.resize(img.get_width() / 2, img.get_height() / 2)
	img.save_png(out.path_join("zoom_%d.png" % arena))
	print("zoom arena %d: %.2f (mínimo %.2f)" % [arena, cam.zoom.x, cam.min_zoom])


func _close_up() -> void:
	cam.min_zoom = 1.5
	cam.max_zoom = 1.5
	await _place(me, Vector2(-75, -60), 1)
	await _place(foe, Vector2(0, -60), -1)
	await _frames(60)


## Golpe de verdade (animação de quem bate) e recorte a cada quadro, do 2º
## quadro antes do acerto até 16 depois.
func _hit_strip(name: String, move: String, foe_damage: float) -> void:
	await _place(me, Vector2(-75, -60), 1)
	await _place(foe, Vector2(0, -60), -1)
	await _frames(30)
	foe.damage_percent = foe_damage
	var shots: Array[Image] = []
	var notes: Array[String] = []
	var before := foe.damage_percent
	me.start_attack(move)
	var hit_at := -1
	for i in 60:
		await get_tree().physics_frame
		await RenderingServer.frame_post_draw
		if hit_at < 0 and foe.damage_percent > before:
			hit_at = i
		var keep := hit_at < 0 and me.attack_frame >= me.attack.startup - 2 if me.attack != null else false
		if hit_at >= 0 or keep:
			shots.append(_crop())
			notes.append("q%d pausa=%d" % [i, foe._hitstop])
		if hit_at >= 0 and i - hit_at >= 16:
			break
	_save_strip(shots, name)
	print("%s: %d quadros, acerto no quadro %d; %s" % [name, shots.size(), hit_at, ", ".join(notes)])


func _crop() -> Image:
	var img := get_viewport().get_texture().get_image()
	var c := Vector2(-40, -70)
	var p := get_viewport().get_canvas_transform() * c
	var r := Rect2i(int(p.x) - BOX, int(p.y) - BOX, BOX * 2, BOX * 2).intersection(Rect2i(Vector2i.ZERO, img.get_size()))
	var o := Image.create(BOX * 2, BOX * 2, false, Image.FORMAT_RGBA8)
	var cut := img.get_region(r)
	cut.convert(Image.FORMAT_RGBA8)
	o.blit_rect(cut, Rect2i(Vector2i.ZERO, cut.get_size()), Vector2i.ZERO)
	return o


## Folha com 6 quadros por linha.
func _save_strip(shots: Array[Image], name: String) -> void:
	if shots.is_empty():
		return
	var w := shots[0].get_width()
	var cols := 6
	var rows := (shots.size() + cols - 1) / cols
	var sheet := Image.create(w * cols, w * rows, false, Image.FORMAT_RGBA8)
	sheet.fill(Color(0.1, 0.1, 0.1))
	for i in shots.size():
		sheet.blit_rect(shots[i], Rect2i(0, 0, w, w), Vector2i((i % cols) * w, (i / cols) * w))
	sheet.save_png(out.path_join(name + ".png"))


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


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
