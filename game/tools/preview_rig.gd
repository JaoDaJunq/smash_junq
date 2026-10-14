extends SceneTree
## Desenha poses de um boneco de recorte num PNG usando só o processador (sem
## janela), para conferir montagem e poses. Cada pose vira um quadro lado a lado,
## com uma linha no chão (pés) e o retângulo de colisão do lutador em contorno.
##   godot --headless --path game --script res://tools/preview_rig.gd -- \
##     res://assets/characters/seu_capivas/rig.json <saida.png> [pose1,pose2,...] [altura_px=300]

const BG := Color(0.42, 0.27, 0.55)


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	var rig_path: String = args[0]
	var out_path: String = args[1]
	var rig := CutoutRigMath.load_rig(rig_path)
	var poses: Array = ["neutra"]
	if args.size() > 2 and args[2] != "":
		poses = Array(args[2].split(","))
	var cell_h := int(args[3]) if args.size() > 3 else 300
	var dir := rig_path.get_base_dir()
	var textures := {}
	for name in rig["partes"]:
		var img := Image.load_from_file(ProjectSettings.globalize_path(dir.path_join(rig["partes"][name]["arquivo"])))
		img.convert(Image.FORMAT_RGBA8)
		textures[name] = img
	# Escala do quadro: a altura do lutador no jogo (HEIGHT=110) ocupa ~45% do quadro
	var game_scale: float = float(rig.get("escala", 0.15))
	var zoom := cell_h * 0.45 / 110.0
	var cell_w := int(cell_h * 0.8)
	var sheet := Image.create(cell_w * poses.size(), cell_h, false, Image.FORMAT_RGBA8)
	sheet.fill(BG)
	for i in poses.size():
		var offsets: Dictionary = CutoutRig.pose_offsets(rig, poses[i])
		var xfs := CutoutRigMath.part_transforms(rig, offsets)
		var hip: Vector2 = Vector2(0, float(rig.get("quadril_y", 0.0)))
		var fighter_origin := Vector2(i * cell_w + cell_w * 0.5, cell_h * 0.55)
		var to_canvas := Transform2D(0.0, Vector2(zoom * game_scale, zoom * game_scale), 0.0, fighter_origin + hip * zoom)
		# chão e caixa de colisão (56x110 centrada no lutador)
		var feet_y := int(fighter_origin.y + 55 * zoom)
		sheet.fill_rect(Rect2i(i * cell_w, feet_y, cell_w, 2), Color(1, 1, 1, 0.6))
		_rect_outline(sheet, Rect2i(int(fighter_origin.x - 28 * zoom), int(fighter_origin.y - 55 * zoom), int(56 * zoom), int(110 * zoom)), Color(0.3, 1, 0.5, 0.8))
		for name in CutoutRigMath.draw_order(rig["partes"]):
			_draw_part(sheet, textures[name], CutoutRigMath.region_in_crop(rig["partes"][name]), to_canvas * xfs[name], Rect2i(i * cell_w, 0, cell_w, cell_h))
		sheet.fill_rect(Rect2i(i * cell_w, 0, 2, cell_h), Color(0.1, 0.1, 0.15))
	sheet.save_png(out_path)
	print("OK: ", out_path)
	quit()


func _draw_part(canvas: Image, tex: Image, region: Rect2, xf: Transform2D, clip: Rect2i) -> void:
	var src := Rect2(Vector2.ZERO, tex.get_size()) if region.size == Vector2.ZERO else region
	var corners := [xf * Vector2.ZERO, xf * Vector2(src.size.x, 0), xf * Vector2(0, src.size.y), xf * src.size]
	var lo := Vector2(INF, INF)
	var hi := Vector2(-INF, -INF)
	for c in corners:
		lo = lo.min(c)
		hi = hi.max(c)
	var x0 := maxi(int(lo.x), clip.position.x)
	var y0 := maxi(int(lo.y), clip.position.y)
	var x1 := mini(int(hi.x) + 1, clip.end.x)
	var y1 := mini(int(hi.y) + 1, clip.end.y)
	var inv := xf.affine_inverse()
	for y in range(y0, y1):
		for x in range(x0, x1):
			var s: Vector2 = inv * Vector2(x + 0.5, y + 0.5)
			if s.x < 0 or s.y < 0 or s.x >= src.size.x or s.y >= src.size.y:
				continue
			var c := tex.get_pixel(int(s.x + src.position.x), int(s.y + src.position.y))
			if c.a < 0.05:
				continue
			canvas.set_pixel(x, y, canvas.get_pixel(x, y).blend(c))


func _rect_outline(img: Image, r: Rect2i, c: Color) -> void:
	img.fill_rect(Rect2i(r.position.x, r.position.y, r.size.x, 1), c)
	img.fill_rect(Rect2i(r.position.x, r.end.y, r.size.x, 1), c)
	img.fill_rect(Rect2i(r.position.x, r.position.y, 1, r.size.y), c)
	img.fill_rect(Rect2i(r.end.x, r.position.y, 1, r.size.y), c)
