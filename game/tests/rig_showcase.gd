extends Node
## Conferência visual dos bonecos (abre janela): aproxima a câmera de cada
## personagem, força cada pose e salva screenshots em evidence/etapa-3/rig/.
## Também fotografa uma partida no zoom normal.
##   godot --path game res://tests/rig_showcase.tscn
##   (em movimento: -- --zoom 5 --ao-vivo)

const MAIN := preload("res://scenes/main.tscn")
const POSES := ["neutra", "parado", "pulo", "queda", "dor", "defesa", "borda", "agarrar", "agachar",
	"golpe:frente:golpe", "golpe:cima:golpe", "golpe:baixo:golpe", "golpe:tras:golpe", "golpe:giro:golpe",
	"golpe:special_neutral:golpe", "golpe:special_side:golpe", "golpe:special_down:golpe"]

var dir := ""


func _ready() -> void:
	dir = ProjectSettings.globalize_path("res://").path_join("../evidence/etapa-3/rig")
	DirAccess.make_dir_recursive_absolute(dir)
	var main := MAIN.instantiate()
	add_child(main)
	var cam: Camera2D = main.get_node("Camera")
	var p1: Fighter = main.get_node("P1")
	var p2: Fighter = main.get_node("P2")
	_poses()  # lê zoom e lado antes de começar
	await _frames(40)
	# Partida no zoom normal
	await _shot("00-luta-normal")
	cam.set_process(false)
	if "--ao-vivo" in OS.get_cmdline_user_args():
		await _live(p1, p2, cam, "juba")
		await _live(p2, p1, cam, "capivas")
		print("Screenshots em ", dir)
		get_tree().quit()
		return
	for f in [p1, p2]:
		var other: Fighter = p2 if f == p1 else p1
		other.visible = false
		f.set_physics_process(false)
		f.global_position = Vector2(0, -55)
		f.facing = 1
		cam.global_position = Vector2(0, -60)
		cam.zoom = Vector2(_zoom, _zoom)
		f.facing = _facing
		cam.global_position = Vector2(0, -75)
		var rig := f.get_node_or_null("Rig") as CutoutRig
		if rig == null:
			other.visible = true
			f.set_physics_process(true)
			continue  # personagem em pixel art: use --ao-vivo
		var tag := "juba" if f == p1 else "capivas"
		var poses: Array = _poses()
		for i in poses.size():
			rig.debug_pose = poses[i]
			await _frames(25)
			await _shot("%s%s-%02d-%s" % [tag, "-esq" if _facing < 0 else "", i, poses[i].replace(":", "_")])
		rig.debug_pose = ""
		other.visible = true
		f.set_physics_process(true)
	print("Screenshots em ", dir)
	get_tree().quit()


func _frames(n: int) -> void:
	for i in n:
		await get_tree().process_frame


func _shot(name: String) -> void:
	await RenderingServer.frame_post_draw
	get_viewport().get_texture().get_image().save_png(dir.path_join(name + ".png"))


## Argumentos opcionais: -- --zoom 6 --facing -1 --poses neutra,parado
var _zoom := 3.2
var _facing := 1


func _poses() -> Array:
	var args := OS.get_cmdline_user_args()
	var out: Array = POSES
	for i in args.size() - 1:
		match args[i]:
			"--zoom": _zoom = float(args[i + 1])
			"--facing": _facing = int(args[i + 1])
			"--poses": out = Array(args[i + 1].split(","))
	return out


## Prints em movimento de verdade (física ligada), com a câmera seguindo de perto:
## parado, andando, correndo, virando, golpeando, apanhando, pulando e pousando.
func _live(f: Fighter, other: Fighter, cam: Camera2D, tag: String) -> void:
	var pid := f.player_id
	cam.zoom = Vector2(_zoom, _zoom)
	var follow := func() -> void: cam.global_position = f.global_position + Vector2(0, -15)
	f.global_position = Vector2(-200, -56)
	f.velocity = Vector2.ZERO
	f.facing = 1
	other.global_position = Vector2(480, -56)
	await _live_frames(40, follow)
	await _shot("vivo-%s-01-parado" % tag)
	Input.action_press(pid + "_right", 0.6)
	await _live_frames(12, follow)
	await _shot("vivo-%s-02-andando" % tag)
	await _live_frames(7, follow)
	await _shot("vivo-%s-03-andando" % tag)
	Input.action_release(pid + "_right")
	await _live_frames(20, follow)
	Input.action_press(pid + "_right", 1.0)
	await _live_frames(14, follow)
	await _shot("vivo-%s-04-correndo" % tag)
	await _live_frames(5, follow)
	await _shot("vivo-%s-05-correndo" % tag)
	Input.action_release(pid + "_right")
	await _live_frames(25, follow)
	Input.action_press(pid + "_left", 0.6)
	await _live_frames(2, follow)
	await _shot("vivo-%s-06-virando" % tag)
	Input.action_release(pid + "_left")
	await _live_frames(25, follow)
	f.facing = 1
	f.start_attack("ftilt")
	await _live_frames(maxi(1, f.attack.startup - 2), follow)
	await _shot("vivo-%s-07-golpe-preparo" % tag)
	await _live_frames(3, follow)
	await _shot("vivo-%s-08-golpe-impacto" % tag)
	await _live_frames(6, follow)
	await _shot("vivo-%s-09-golpe-volta" % tag)
	await _live_frames(30, follow)
	# Leva um golpe: o outro chega perto e acerta
	other.global_position = f.global_position + Vector2(70, 0)
	other.velocity = Vector2.ZERO
	other.facing = -1
	f.facing = 1
	await _live_frames(4, follow)
	other.start_attack("ftilt")
	await _live_frames(other.attack.startup + 3, follow)
	await _shot("vivo-%s-10-apanhando" % tag)
	await _live_frames(60, follow)
	other.global_position = Vector2(480, -56)
	f.global_position = Vector2(-150, -56)
	f.velocity = Vector2.ZERO
	await _live_frames(30, follow)
	Input.action_press(pid + "_jump")
	await _live_frames(5, follow)
	await _shot("vivo-%s-11-pulando" % tag)
	Input.action_release(pid + "_jump")
	var guard := 0
	while not f.is_on_floor() and guard < 200:
		await _live_frames(1, follow)
		guard += 1
	await _live_frames(2, follow)
	await _shot("vivo-%s-12-pouso" % tag)
	await _live_frames(30, follow)


func _live_frames(n: int, follow: Callable) -> void:
	for i in n:
		await get_tree().physics_frame
		follow.call()
	await get_tree().process_frame
