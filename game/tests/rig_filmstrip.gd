extends Node
## Tira de filme das animações (sem janela): roda a luta de verdade, guarda o
## boneco quadro a quadro e desenha as poses lado a lado num PNG, com a linha do
## chão. Também confere que os pés encostam no chão sempre que o lutador está no chão.
##   godot --headless --path game res://tests/rig_filmstrip.tscn
## Saída: evidence/etapa-3/anim/<personagem>.png  (ampliar: -- --zoom 2.5)

const MAIN := preload("res://scenes/main.tscn")
var CELL := Vector2i(150, 190)
var ZOOM := 1.25
const BG := Color(0.42, 0.27, 0.55)

var results: Array[String] = []
var failures := 0
var out_dir := ""


func _ready() -> void:
	var args := OS.get_cmdline_user_args()
	var zi := args.find("--zoom")
	if zi >= 0:
		ZOOM = float(args[zi + 1])
		CELL = Vector2i(int(120 * ZOOM), int(152 * ZOOM))
	out_dir = ProjectSettings.globalize_path("res://").path_join("../evidence/etapa-3/anim")
	DirAccess.make_dir_recursive_absolute(out_dir)
	var main := MAIN.instantiate()
	add_child(main)
	var p1: Fighter = main.get_node("P1")
	var p2: Fighter = main.get_node("P2")
	await _frames(40)
	await _film(p1, p2, "p1", "juba")
	await _film(p2, p1, "p2", "seu_capivas")
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _film(f: Fighter, other: Fighter, pid: String, file: String) -> void:
	var rig := f.get_node("Rig") as CutoutRig
	if rig == null:
		_check("%s tem boneco" % f.display_name, false, "script do boneco não carregou")
		return
	var rows := {}
	var worst := {"gap": 0.0, "where": ""}
	other.global_position = Vector2(480, -56)
	other.velocity = Vector2.ZERO
	# Parado
	await _reset(f)
	rows["parado"] = await _record(f, rig, 48, 6, worst, "parado")
	# Andar (inclinação parcial)
	await _reset(f)
	Input.action_press(pid + "_right", 0.6)
	await _frames(6)
	rows["andar"] = await _record(f, rig, 40, 4, worst, "andar")
	Input.action_release(pid + "_right")
	# Correr
	await _reset(f)
	Input.action_press(pid + "_right", 1.0)
	await _frames(8)
	rows["correr"] = await _record(f, rig, 30, 3, worst, "correr")
	Input.action_release(pid + "_right")
	# Pulo, pulo duplo e pouso
	await _reset(f)
	_double_jump(pid)  # roda em paralelo com a gravação
	rows["pulo"] = await _record(f, rig, 80, 6, worst, "pulo")
	# Golpes no chão
	for move in ["ftilt", "utilt", "dtilt", "special_neutral"]:
		await _reset(f)
		if f.start_attack(move):
			var total: int = f.attack.startup + f.attack.active + f.attack.recovery
			rows[move] = await _record(f, rig, total + 4, maxi(1, int(ceil(total / 10.0))), worst, move)
	_check("%s: pés no chão em todos os quadros no chão" % f.display_name, worst["gap"] < 1.5,
		"maior diferença %.2f px (%s)" % [worst["gap"], worst["where"]])
	_render(rig, rows, out_dir.path_join(file + ".png"))


func _double_jump(pid: String) -> void:
	Input.action_press(pid + "_jump")
	await _frames(4)
	Input.action_release(pid + "_jump")
	await _frames(20)
	Input.action_press(pid + "_jump")
	await _frames(3)
	Input.action_release(pid + "_jump")


func _reset(f: Fighter) -> void:
	for a in ["_left", "_right", "_jump"]:
		Input.action_release(f.player_id + a)
	f.global_position = Vector2(-350, -56)
	f.velocity = Vector2.ZERO
	f.facing = 1
	await _frames(25)


## Guarda o boneco a cada `step` quadros e mede a distância pé-chão.
func _record(f: Fighter, rig: CutoutRig, frames: int, step: int, worst: Dictionary, tag: String) -> Array:
	var shots := []
	for i in frames:
		await get_tree().physics_frame
		await get_tree().process_frame
		if f.is_on_floor() and rig._ground_w > 0.99:
			var gap := absf(rig.lowest_contact_y() - CutoutRig.FLOOR_Y)
			if gap > worst["gap"]:
				worst["gap"] = gap
				worst["where"] = "%s, quadro %d, %s" % [tag, i, Fighter.State.keys()[f.state]]
		if i % step == 0:
			var parts := {}
			for name in rig._sprites:
				parts[name] = (rig._sprites[name] as Sprite2D).transform
			shots.append({"rig": rig.transform, "parts": parts, "floor": -f.global_position.y})
	return shots


func _render(rig: CutoutRig, rows: Dictionary, path: String) -> void:
	var images := CutoutRigMath.load_part_images(rig.rig, rig.rig_path)
	var cols := 0
	for r in rows.values():
		cols = maxi(cols, r.size())
	var sheet := Image.create(CELL.x * cols, CELL.y * rows.size(), false, Image.FORMAT_RGBA8)
	sheet.fill(BG)
	var order := CutoutRigMath.draw_order(rig.rig["partes"])
	var y := 0
	for key in rows:
		var x := 0
		for shot in rows[key]:
			var clip := Rect2i(x * CELL.x, y * CELL.y, CELL.x, CELL.y)
			var origin := Vector2(clip.position.x + CELL.x * 0.5, clip.position.y + CELL.y * 0.45)
			var floor_y := int(origin.y + float(shot["floor"]) * ZOOM)
			if floor_y < clip.end.y:
				sheet.fill_rect(Rect2i(clip.position.x, floor_y, CELL.x, clip.end.y - floor_y), Color(0.25, 0.16, 0.33))
				sheet.fill_rect(Rect2i(clip.position.x, floor_y, CELL.x, 1), Color(1, 1, 1, 0.8))
			var to_canvas := Transform2D(0.0, Vector2(ZOOM, ZOOM), 0.0, origin) * (shot["rig"] as Transform2D)
			for name in order:
				CutoutRigMath.draw_part(sheet, images[name], CutoutRigMath.region_in_crop(rig.rig["partes"][name]),
					to_canvas * (shot["parts"][name] as Transform2D), clip)
			sheet.fill_rect(Rect2i(clip.position.x, clip.position.y, 1, CELL.y), Color(0.1, 0.1, 0.15))
			x += 1
		sheet.fill_rect(Rect2i(0, y * CELL.y, sheet.get_width(), 1), Color(0.1, 0.1, 0.15))
		y += 1
	sheet.save_png(path)
	results.append("[--] tira salva: %s (%s)" % [path.get_file(), ", ".join(rows.keys())])


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
