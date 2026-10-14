extends Node
## Conferência visual dos bonecos (abre janela): aproxima a câmera de cada
## personagem, força cada pose e salva screenshots em evidence/etapa-3/rig/.
## Também fotografa uma partida no zoom normal.
##   godot --path game res://tests/rig_showcase.tscn

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
		var rig := f.get_node("Rig") as CutoutRig
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
