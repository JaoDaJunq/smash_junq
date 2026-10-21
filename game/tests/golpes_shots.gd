extends Node
## Prints de TODOS os movimentos de um personagem dentro do jogo (COM janela).
## Para cada movimento, tira um recorte em volta do lutador a cada 3 quadros e
## monta uma tira em evidence/golpes/<id>/<movimento>.png (tamanho real, 2x).
##   godot --path game --resolution 1920x1080 res://tests/golpes_shots.tscn -- <indice_personagem> [movimento ...]

const MATCH := preload("res://scenes/match.tscn")
const BOX := 320
const EVERY := 2
const MOVES := [
	"parado", "andar", "correr", "pulo", "jab", "ftilt", "utilt", "dtilt",
	"nair", "fair", "bair", "uair", "dair",
	"special_neutral", "special_side", "special_up", "special_down",
	"escudo", "dor", "agarrar",
]

var me: Fighter
var foe: Fighter
var out := ""


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var args := OS.get_cmdline_user_args()
	var idx := int(args[0]) if not args.is_empty() else 0
	var only: Array = args.slice(1)
	Game.set_character("p1", idx)
	Game.set_character("p2", 1)
	var m := MATCH.instantiate()
	add_child(m)
	await _frames(240)
	for f in m.find_children("*", "Fighter", true, false):
		if f.player_id == "p1":
			me = f
		else:
			foe = f
	for cam in m.find_children("*", "Camera2D", true, false):
		cam.min_zoom = 1.6
		cam.max_zoom = 1.6
	out = ProjectSettings.globalize_path("res://").path_join("../evidence/golpes/%s" % Game.CHARACTERS[idx].get("id", str(idx)))
	DirAccess.make_dir_recursive_absolute(out)
	for mv in MOVES:
		if not only.is_empty() and mv not in only:
			continue
		await _shoot(mv)
	get_tree().quit()


func _shoot(mv: String) -> void:
	await _reset()
	var air := mv in ["nair", "fair", "bair", "uair", "dair", "pulo"] or mv == "special_up"
	if air:
		me.global_position = Vector2(-200, -330)
		me.state = Fighter.State.AIR
	var shots: Array[Image] = []
	var n := 60
	match mv:
		"parado": n = 60
		"andar", "correr":
			Input.action_press("p1_right")
			if mv == "correr":
				me.state = Fighter.State.RUN
		"pulo":
			me.global_position = Vector2(-200, -60)
			await _frames(10)
			me.velocity.y = -me.jump_velocity
			me.state = Fighter.State.AIR
		"escudo":
			Input.action_press("p1_shield")
		"dor":
			var hit := AttackData.new()
			hit.damage = 1.0
			hit.angle = 45.0
			hit.base_knockback = 500.0
			me.receive_hit(foe, hit, -1)
		"agarrar":
			foe.global_position = me.global_position + Vector2(70, 0)
			Input.action_press("p1_grab")
		_:
			if mv == "special_down":
				foe.global_position = me.global_position + Vector2(55, 0)
				await _frames(3)
			if mv.begins_with("special_"):
				me.start_special(mv.substr(8))
			else:
				me.start_attack(mv)
	for i in n:
		await get_tree().physics_frame
		if i % EVERY == 0:
			await RenderingServer.frame_post_draw
			shots.append(_crop())
	for a in ["p1_right", "p1_shield", "p1_grab"]:
		Input.action_release(a)
	var w := shots[0].get_width()
	var strip := Image.create(w * shots.size(), shots[0].get_height(), false, Image.FORMAT_RGBA8)
	for i in shots.size():
		strip.blit_rect(shots[i], Rect2i(0, 0, w, shots[i].get_height()), Vector2i(i * w, 0))
	strip.save_png(out.path_join(mv + ".png"))


func _crop() -> Image:
	var img := get_viewport().get_texture().get_image()
	var p := get_viewport().get_canvas_transform() * (me.global_position + Vector2(0, -50))
	var r := Rect2i(int(p.x) - BOX, int(p.y) - BOX, BOX * 2, BOX * 2)
	r = r.intersection(Rect2i(Vector2i.ZERO, img.get_size()))
	var c := img.get_region(r)
	if c.get_size() != Vector2i(BOX * 2, BOX * 2):
		var pad := Image.create(BOX * 2, BOX * 2, false, Image.FORMAT_RGBA8)
		pad.blit_rect(c, Rect2i(Vector2i.ZERO, c.get_size()), Vector2i.ZERO)
		c = pad
	c.convert(Image.FORMAT_RGBA8)
	return c


func _reset() -> void:
	for f in [me, foe]:
		f.release_hold()
		f.release_held()
		f.attack = null
		f.attack_id = ""
		f.helpless = false
		f._hitstun = 0.0
		f.velocity = Vector2.ZERO
		f.state = Fighter.State.AIR
		f.visible = true
		f.damage_percent = 0.0
	me.global_position = Vector2(-200, -60)
	me.facing = 1
	foe.global_position = Vector2(400, -60)
	await _frames(25)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
