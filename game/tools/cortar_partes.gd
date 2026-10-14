extends SceneTree
## Recorta automaticamente as partes de uma folha "desmontada" (PNG com fundo
## transparente): cada pedaço separado vira um PNG próprio, e um partes.json guarda
## posição, tamanho e o eixo principal de cada parte (pontas usadas como juntas).
## Também salva folha_indices.png com as partes enfileiradas na ordem dos índices.
## Roda sem janela:
##   godot --headless --path game --script res://tools/cortar_partes.gd -- \
##     <entrada.png> <pasta_saida> [area_minima_px=2500]

const ALPHA_MIN := 0.5


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	var img := Image.load_from_file(args[0])
	img.convert(Image.FORMAT_RGBA8)
	var out_dir: String = args[1]
	var min_area := int(args[2]) if args.size() > 2 else 2500
	DirAccess.make_dir_recursive_absolute(out_dir)
	var w := img.get_width()
	var h := img.get_height()
	var data := img.get_data()
	var labels := PackedInt32Array()
	labels.resize(w * h)
	var parts: Array[Dictionary] = []
	var next_label := 0
	for start in w * h:
		if labels[start] != 0 or data[start * 4 + 3] < int(ALPHA_MIN * 255):
			continue
		next_label += 1
		var stack := PackedInt32Array([start])
		labels[start] = next_label
		var count := 0
		var x0 := w
		var y0 := h
		var x1 := 0
		var y1 := 0
		var sx := 0.0
		var sy := 0.0
		var sxx := 0.0
		var syy := 0.0
		var sxy := 0.0
		while not stack.is_empty():
			var i := stack[stack.size() - 1]
			stack.remove_at(stack.size() - 1)
			var x := i % w
			var y := i / w
			count += 1
			x0 = mini(x0, x)
			y0 = mini(y0, y)
			x1 = maxi(x1, x)
			y1 = maxi(y1, y)
			sx += x
			sy += y
			sxx += x * x
			syy += y * y
			sxy += x * y
			for n in [i - 1, i + 1, i - w, i + w]:
				if n < 0 or n >= w * h or labels[n] != 0:
					continue
				if (n == i - 1 and x == 0) or (n == i + 1 and x == w - 1):
					continue
				if data[n * 4 + 3] >= int(ALPHA_MIN * 255):
					labels[n] = next_label
					stack.append(n)
		if count < min_area:
			continue
		var cx := sx / count
		var cy := sy / count
		# Eixo principal (PCA) e as duas pontas da parte ao longo dele
		var vxx := sxx / count - cx * cx
		var vyy := syy / count - cy * cy
		var vxy := sxy / count - cx * cy
		var angle := 0.5 * atan2(2.0 * vxy, vxx - vyy)
		var axis := Vector2(cos(angle), sin(angle))
		parts.append({"label": next_label, "area": count, "rect": [x0, y0, x1 - x0 + 1, y1 - y0 + 1],
			"centro": [snappedf(cx, 0.1), snappedf(cy, 0.1)], "eixo": [snappedf(axis.x, 0.001), snappedf(axis.y, 0.001)]})
	# Pontas ao longo do eixo (projeção extrema dos pixels da parte)
	for p in parts:
		var r: Array = p["rect"]
		var c := Vector2(p["centro"][0], p["centro"][1])
		var axis := Vector2(p["eixo"][0], p["eixo"][1])
		var lo := INF
		var hi := -INF
		var plo := c
		var phi := c
		for y in range(r[1], r[1] + r[3]):
			for x in range(r[0], r[0] + r[2]):
				if labels[y * w + x] != p["label"]:
					continue
				var t := (Vector2(x, y) - c).dot(axis)
				if t < lo:
					lo = t
					plo = Vector2(x, y)
				if t > hi:
					hi = t
					phi = Vector2(x, y)
		p["ponta_a"] = [plo.x, plo.y]
		p["ponta_b"] = [phi.x, phi.y]
	# Ordem: de cima para baixo, depois da esquerda para a direita (linhas de ~1/6 da altura)
	parts.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		var ra: int = int(a["rect"][1] + a["rect"][3] / 2) / (h / 6)
		var rb: int = int(b["rect"][1] + b["rect"][3] / 2) / (h / 6)
		if ra != rb:
			return ra < rb
		return a["rect"][0] < b["rect"][0])
	var pad := 4
	var sheet_parts: Array[Image] = []
	for idx in parts.size():
		var p: Dictionary = parts[idx]
		var r: Array = p["rect"]
		var crop := Image.create(r[2] + pad * 2, r[3] + pad * 2, false, Image.FORMAT_RGBA8)
		for y in range(r[1], r[1] + r[3]):
			for x in range(r[0], r[0] + r[2]):
				if labels[y * w + x] == p["label"]:
					crop.set_pixel(x - r[0] + pad, y - r[1] + pad, img.get_pixel(x, y))
		var name := "parte_%02d.png" % idx
		crop.save_png(out_dir.path_join(name))
		p["arquivo"] = name
		p["origem_no_recorte"] = [r[0] - pad, r[1] - pad]  # some isto às coordenadas da folha
		p.erase("label")
		sheet_parts.append(crop)
	var f := FileAccess.open(out_dir.path_join("partes.json"), FileAccess.WRITE)
	f.store_string(JSON.stringify({"fonte": args[0].get_file(), "tamanho": [w, h], "partes": parts}, "  "))
	f.close()
	_save_index_sheet(sheet_parts, out_dir.path_join("folha_indices.png"))
	print("OK: %d partes recortadas em %s" % [parts.size(), out_dir])
	quit()


## Enfileira as partes reduzidas, na ordem dos índices, separadas por barras.
func _save_index_sheet(imgs: Array[Image], path: String) -> void:
	var cell := 180
	var sheet := Image.create(cell * imgs.size(), cell + 20, false, Image.FORMAT_RGBA8)
	sheet.fill(Color(0.85, 0.85, 0.88))
	for i in imgs.size():
		var im := imgs[i].duplicate() as Image
		var s := minf(float(cell - 10) / im.get_width(), float(cell - 10) / im.get_height())
		im.resize(maxi(1, int(im.get_width() * s)), maxi(1, int(im.get_height() * s)), Image.INTERPOLATE_BILINEAR)
		sheet.blend_rect(im, Rect2i(Vector2i.ZERO, im.get_size()), Vector2i(i * cell + 5, 15))
		sheet.fill_rect(Rect2i(i * cell, 0, 2, cell + 20), Color(0.2, 0.2, 0.3))
		# marcador do índice: i+1 quadradinhos no topo da célula
		for k in i + 1:
			sheet.fill_rect(Rect2i(i * cell + 6 + k * 9, 3, 7, 7), Color(0.8, 0.1, 0.2))
	sheet.save_png(path)
