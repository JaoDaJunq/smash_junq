extends SceneTree
## Encaixa uma folha de cabeças com expressões no boneco: acha, para cada cabeça
## recortada, a escala e o deslocamento que melhor cobrem o contorno da cabeça
## atual do rig (comparando só a parte de cima, onde ficam crânio, orelhas e
## topete) e grava as expressões no rig.json. Opcionalmente apaga o que sobra
## fora da cabeça atual numa faixa de baixo (pescoço/ombro que veio junto).
## Roda sem janela:
##   godot --headless --path game --script res://tools/alinhar_cabecas.gd -- \
##     <pasta_recortes> <rig.json> <nomes,separados,por,vírgula> [corte_baixo=0.0] [corte_esq=0.0] [sem_azul]
## <pasta_recortes> vem de tools/cortar_partes.gd (parte_XX.png + partes.json).
## corte_baixo/corte_esq: frações da altura/largura da cabeça atual a partir das
## quais o que estiver fora do contorno atual é apagado (0 = não apaga nada).
## Saída: rosto_XX.png na pasta do rig, "expressoes" no rig.json e
## conferencia_rostos.png (cabeça atual em vermelho por baixo de cada expressão).



func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	var cuts_dir: String = args[0]
	var rig_path: String = args[1]
	var names: PackedStringArray = args[2].split(",")
	var cut_bottom := float(args[3]) if args.size() > 3 else 0.0
	var cut_left := float(args[4]) if args.size() > 4 else 0.0
	var no_blue := args.size() > 5 and args[5] == "sem_azul"
	var rig := CutoutRigMath.load_rig(rig_path)
	var head: Dictionary = rig["partes"]["cabeca"]
	var base: Image = CutoutRigMath.load_part_images({"partes": {"cabeca": head}}, rig_path)["cabeca"]
	var meta: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(cuts_dir.path_join("partes.json")))
	var pieces: Array = meta["partes"]
	pieces.sort_custom(func(a, b) -> bool: return a["arquivo"] < b["arquivo"])
	var rig_dir := ProjectSettings.globalize_path(rig_path.get_base_dir())
	var base_mask := _mask(base)
	var base_dil := _dilate(base_mask, base.get_size(), 6)
	var expressions := {}
	var first := {}
	var check := Image.create(260 * names.size(), 300, false, Image.FORMAT_RGBA8)
	check.fill(Color(0.42, 0.27, 0.55))
	for i in names.size():
		var piece: Dictionary = pieces[i]
		var img := Image.load_from_file(cuts_dir.path_join(piece["arquivo"]))
		img.convert(Image.FORMAT_RGBA8)
		# A primeira expressão encaixa na cabeça atual (escala e posição); as outras,
		# desenhadas na mesma escala, encaixam na primeira só por deslocamento.
		var fit: Dictionary
		if i == 0:
			fit = _fit(base, img)
			first = {"img": img.duplicate(), "s": fit["s"], "t": fit["t"]}
		else:
			var rel := _fit(first["img"], img, true, 0.9)
			fit = {"score": rel["score"], "s": first["s"], "t": Vector2(first["t"]) + Vector2(rel["t"]) * float(first["s"])}
		var s: float = fit["s"]
		var t: Vector2 = fit["t"]
		# Apaga o que sobra fora da cabeça atual na faixa de baixo/esquerda
		if cut_bottom > 0.0 or cut_left > 0.0:
			for y in img.get_height():
				for x in img.get_width():
					var b := Vector2(x, y) * s + t
					var in_zone := (cut_bottom > 0.0 and b.y > base.get_height() * cut_bottom) \
						or (cut_left > 0.0 and b.x < base.get_width() * cut_left)
					if not in_zone:
						continue
					var bi := Vector2i(b)
					var inside := bi.x >= 0 and bi.y >= 0 and bi.x < base.get_width() and bi.y < base.get_height() \
						and base_dil[bi.y * base.get_width() + bi.x]
					if not inside:
						img.set_pixel(x, y, Color(0, 0, 0, 0))
		if no_blue:
			_erase_blue(img)
		var file := "rosto_%02d.png" % i
		img.save_png(rig_dir.path_join(file))
		# Pontos da cabeça atual levados para as coordenadas do recorte novo
		var o := Vector2(head["origem"][0], head["origem"][1])
		var pv: Vector2 = (Vector2(head["pivo"][0], head["pivo"][1]) - o - t) / s
		var pp: Vector2 = (Vector2(head["ponta"][0], head["ponta"][1]) - o - t) / s
		expressions[names[i]] = {
			"arquivo": file, "origem": [0, 0],
			"pivo": [snappedf(pv.x, 0.1), snappedf(pv.y, 0.1)],
			"ponta": [snappedf(pp.x, 0.1), snappedf(pp.y, 0.1)],
			"escala": snappedf(s, 0.0001),
		}
		print("%s: escala %.3f deslocamento %s acerto %.3f" % [names[i], s, t, fit["score"]])
		_draw_check(check, Rect2i(260 * i, 0, 260, 300), base, img, s, t)
	rig["expressoes"] = expressions
	_save_rig(rig_path, rig)
	check.save_png(rig_dir.path_join("../../../../evidence/etapa-3/rig/conferencia_rostos_%s.png" % rig_path.get_base_dir().get_file()))
	print("OK")
	quit()


## Busca escala e deslocamento (recorte novo -> recorte atual) que maximizam a
## sobreposição das máscaras na parte de cima da cabeça atual: primeiro numa
## grade grossa, depois refinando numa grade fina.
func _fit(base: Image, img: Image, same_scale := false, top := 0.55) -> Dictionary:
	var s0 := 1.0 if same_scale else sqrt(float(_count(_mask(base))) / maxf(1.0, _count(_mask(img))))
	var best := {"score": -1.0, "s": s0, "t": Vector2.ZERO}
	var passes := [
		{"grid": 48, "scales": 1 if same_scale else 21, "spread": 0.3, "range": 10},
		{"grid": 128, "scales": 1 if same_scale else 9, "spread": 0.04, "range": 4},
	]
	for pass_i in passes.size():
		var cfg: Dictionary = passes[pass_i]
		var k := float(cfg["grid"]) / maxf(base.get_width(), base.get_height())
		var bw := int(base.get_width() * k) + 1
		var bh := int(base.get_height() * k) + 1
		var rows := int(bh * top)
		var bm := _mask_small(base, k, bw, bh)
		var center: Dictionary = best.duplicate()
		for j in int(cfg["scales"]):
			var s: float = float(center["s"]) if int(cfg["scales"]) == 1 else float(center["s"]) * (1.0 + lerpf(-cfg["spread"], cfg["spread"], j / (cfg["scales"] - 1.0)))
			var iw := int(img.get_width() * k * s) + 1
			var ih := int(img.get_height() * k * s) + 1
			var im := _mask_small(img, k * s, iw, ih)
			var c0: Vector2
			if pass_i == 0:
				c0 = _centroid(bm, bw, rows) - _centroid(im, iw, int(rows * float(ih) / bh))
			else:
				c0 = Vector2(center["t"]) * k
			for dy in range(-cfg["range"], cfg["range"] + 1):
				for dx in range(-cfg["range"], cfg["range"] + 1):
					var off := Vector2i(int(round(c0.x)) + dx, int(round(c0.y)) + dy)
					var score := _iou_top(bm, bw, rows, im, iw, ih, off)
					if score > best["score"]:
						best = {"score": score, "s": s, "t": Vector2(off) / k}
	return best


func _iou_top(bm: PackedByteArray, bw: int, rows: int, im: PackedByteArray, iw: int, ih: int, off: Vector2i) -> float:
	var inter := 0
	var uni := 0
	for y in rows:
		var sy := y - off.y
		var row_ok := sy >= 0 and sy < ih
		for x in bw:
			var a := bm[y * bw + x] != 0
			var sx := x - off.x
			var b := row_ok and sx >= 0 and sx < iw and im[sy * iw + sx] != 0
			if a and b:
				inter += 1
			if a or b:
				uni += 1
	return float(inter) / maxf(1.0, uni)


func _centroid(m: PackedByteArray, w: int, rows: int) -> Vector2:
	var sum := Vector2.ZERO
	var n := 0
	for y in mini(rows, m.size() / w):
		for x in w:
			if m[y * w + x] != 0:
				sum += Vector2(x, y)
				n += 1
	return sum / maxf(1.0, n)


func _mask_small(img: Image, k: float, w: int, h: int) -> PackedByteArray:
	var out := PackedByteArray()
	out.resize(w * h)
	for y in h:
		for x in w:
			var sx := int((x + 0.5) / k)
			var sy := int((y + 0.5) / k)
			if sx < img.get_width() and sy < img.get_height() and img.get_pixel(sx, sy).a > 0.5:
				out[y * w + x] = 1
	return out


func _mask(img: Image) -> PackedByteArray:
	var out := PackedByteArray()
	out.resize(img.get_width() * img.get_height())
	for y in img.get_height():
		for x in img.get_width():
			out[y * img.get_width() + x] = 1 if img.get_pixel(x, y).a > 0.5 else 0
	return out


func _dilate(m: PackedByteArray, size: Vector2i, r: int) -> PackedByteArray:
	var out := m.duplicate()
	for y in size.y:
		for x in size.x:
			if m[y * size.x + x] == 0:
				continue
			for dy in range(-r, r + 1, 2):
				for dx in range(-r, r + 1, 2):
					var nx := x + dx
					var ny := y + dy
					if nx >= 0 and ny >= 0 and nx < size.x and ny < size.y:
						out[ny * size.x + nx] = 1
	return out


func _count(m: PackedByteArray) -> int:
	var n := 0
	for v in m:
		n += v
	return n


## Quadro de conferência: contorno atual em vermelho e a expressão nova por cima.
func _draw_check(canvas: Image, cell: Rect2i, base: Image, img: Image, s: float, t: Vector2) -> void:
	var zoom := minf(cell.size.x / float(base.get_width()), cell.size.y / float(base.get_height())) * 0.8
	var origin := Vector2(cell.position) + Vector2(cell.size) * 0.1
	var red := Image.create(base.get_width(), base.get_height(), false, Image.FORMAT_RGBA8)
	for y in base.get_height():
		for x in base.get_width():
			if base.get_pixel(x, y).a > 0.5:
				red.set_pixel(x, y, Color(1, 0.1, 0.1, 1))
	CutoutRigMath.draw_part(canvas, red, Rect2(), Transform2D(0, Vector2(zoom, zoom), 0, origin), cell)
	var tinted := img.duplicate() as Image
	for y in tinted.get_height():
		for x in tinted.get_width():
			var c := tinted.get_pixel(x, y)
			if c.a > 0.0:
				c.a *= 0.85
				tinted.set_pixel(x, y, c)
	CutoutRigMath.draw_part(canvas, tinted, Rect2(), Transform2D(0, Vector2(zoom * s, zoom * s), 0, origin + t * zoom), cell)


## Grava o rig.json mantendo uma parte/pose por linha (legível no Git).
func _save_rig(path: String, rig: Dictionary) -> void:
	var lines := ["{"]
	var keys := rig.keys()
	for ki in keys.size():
		var k: String = keys[ki]
		var v = rig[k]
		var comma := "," if ki < keys.size() - 1 else ""
		if typeof(v) == TYPE_DICTIONARY and k != "secundarios":
			lines.append('  "%s": {' % k)
			var sub: Array = v.keys()
			for si in sub.size():
				lines.append('    "%s": %s%s' % [sub[si], JSON.stringify(v[sub[si]], "", false), "," if si < sub.size() - 1 else ""])
			lines.append("  }" + comma)
		else:
			lines.append('  "%s": %s%s' % [k, JSON.stringify(v, "", false), comma])
	lines.append("}")
	var f := FileAccess.open(path, FileAccess.WRITE)
	f.store_string("\n".join(lines) + "\n")


## Apaga pixels azulados (pedaço de toalha que veio junto) e o contorno escuro
## colado neles.
func _erase_blue(img: Image) -> void:
	var w := img.get_width()
	var h := img.get_height()
	var blue := PackedByteArray()
	blue.resize(w * h)
	for y in h:
		for x in w:
			var c := img.get_pixel(x, y)
			if c.a > 0.1 and c.b > c.r + 0.12 and c.b > c.g:
				blue[y * w + x] = 1
	var r := 7
	for y in h:
		for x in w:
			var c := img.get_pixel(x, y)
			if c.a <= 0.0:
				continue
			if blue[y * w + x] == 1:
				img.set_pixel(x, y, Color(0, 0, 0, 0))
				continue
			if c.get_luminance() > 0.3:
				continue
			var near := false
			for dy in range(-r, r + 1):
				for dx in range(-r, r + 1):
					var nx := x + dx
					var ny := y + dy
					if nx >= 0 and ny >= 0 and nx < w and ny < h and blue[ny * w + nx] == 1:
						near = true
						break
				if near:
					break
			if near:
				img.set_pixel(x, y, Color(0, 0, 0, 0))
