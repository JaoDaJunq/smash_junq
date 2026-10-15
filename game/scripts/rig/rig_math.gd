class_name CutoutRigMath
extends RefCounted
## Matemática do boneco de recorte (cutout). Usada pelo jogo (CutoutRig) e pela
## ferramenta de conferência que desenha poses sem abrir janela (tools/preview_rig.gd).
##
## Formato do rig.json (coordenadas em pixels da folha de partes original):
##   "partes": {
##     "<nome>": {
##       "arquivo": "parte_03.png",   textura recortada (pasta do rig)
##       "origem": [x, y],            canto superior esquerdo do recorte na folha
##       "regiao": [x, y, w, h],      opcional: só um pedaço do recorte (coords da folha)
##       "pivo": [x, y],              junta que liga ao pai (na folha)
##       "ponta": [x, y],             outra ponta do osso (define a direção da parte)
##       "pai": "<nome>" ou null,     null = raiz
##       "encaixe": [x, y],           onde o pivô encaixa no pai (coords da folha, do pai)
##       "repouso": graus,            ângulo do osso no mundo na pose neutra (0 = direita, 90 = baixo)
##       "z": inteiro                 ordem de desenho
##     }
##   }

## Calcula, para cada parte, a transformação que leva um pixel do recorte (ou da
## região) às coordenadas do boneco (antes da escala e do espelhamento).
## offsets: nome -> graus somados à pose neutra (poses e animação).
## variants: nome -> outra imagem para a parte (ex.: rosto com expressão), com
## "origem", "pivo", "ponta" nas coordenadas dela e "escala" relativa. O osso não
## muda; só a imagem é encaixada no mesmo pivô e na mesma direção.
static func part_transforms(rig: Dictionary, offsets: Dictionary, variants := {}) -> Dictionary:
	var parts: Dictionary = rig["partes"]
	var bone_xf := {}
	var out := {}
	for name in order_parents_first(parts):
		var p: Dictionary = parts[name]
		var pivot := _v(p["pivo"])
		var dir_angle := (_v(p["ponta"]) - pivot).angle()
		var world_rest := deg_to_rad(float(p.get("repouso", 0.0)))
		var parent_name = p.get("pai")
		var xf: Transform2D
		if parent_name == null or not parts.has(parent_name):
			xf = Transform2D(world_rest + deg_to_rad(float(offsets.get(name, 0.0))), Vector2.ZERO)
		else:
			var pp: Dictionary = parts[parent_name]
			var p_pivot := _v(pp["pivo"])
			var p_dir := (_v(pp["ponta"]) - p_pivot).angle()
			var p_rest := deg_to_rad(float(pp.get("repouso", 0.0)))
			var attach := (_v(p["encaixe"]) - p_pivot).rotated(-p_dir)
			var local := world_rest - p_rest + deg_to_rad(float(offsets.get(name, 0.0)))
			xf = bone_xf[parent_name] * Transform2D(0.0, attach) * Transform2D(local, Vector2.ZERO)
		bone_xf[name] = xf
		if variants.has(name):
			var v: Dictionary = variants[name]
			var v_pivot := _v(v["pivo"])
			var v_dir := (_v(v["ponta"]) - v_pivot).angle()
			var k := float(v.get("escala", 1.0))
			out[name] = xf * Transform2D(-v_dir, Vector2(k, k), 0.0, Vector2.ZERO) * Transform2D(0.0, _v(v["origem"]) - v_pivot)
			continue
		var top_left := _v(p["origem"])
		if p.has("regiao"):
			top_left = Vector2(p["regiao"][0], p["regiao"][1])
		out[name] = xf * Transform2D(-dir_angle, Vector2.ZERO) * Transform2D(0.0, top_left - pivot)
	return out


## Retângulo da textura a usar (em pixels do recorte), ou vazio para a textura toda.
static func region_in_crop(p: Dictionary) -> Rect2:
	if not p.has("regiao"):
		return Rect2()
	var o := _v(p["origem"])
	return Rect2(Vector2(p["regiao"][0], p["regiao"][1]) - o, Vector2(p["regiao"][2], p["regiao"][3]))


## Nomes das partes com cada pai antes dos filhos.
static func order_parents_first(parts: Dictionary) -> Array:
	var done := {}
	var out := []
	var guard := 0
	while out.size() < parts.size() and guard < 100:
		guard += 1
		for name in parts:
			if done.has(name):
				continue
			var parent = parts[name].get("pai")
			if parent == null or done.has(parent) or not parts.has(parent):
				done[name] = true
				out.append(name)
	return out


## Partes ordenadas para desenhar (z crescente).
static func draw_order(parts: Dictionary) -> Array:
	var names := parts.keys()
	names.sort_custom(func(a, b) -> bool: return int(parts[a].get("z", 0)) < int(parts[b].get("z", 0)))
	return names


## Tira as bolinhas de junta que a IA desenhou nas pontas ("apagar": [[x, y, raio], ...]
## em coords da folha): repinta cada círculo com a cor da própria peça, de fora
## para dentro, em vez de deixar um buraco transparente (o buraco aparecia nas
## juntas quando a peça vizinha não cobria). O contorno escuro em volta não entra
## na média, para a mancha não escurecer.
static func erase_circles(img: Image, p: Dictionary) -> Image:
	var out := img.duplicate() as Image
	out.convert(Image.FORMAT_RGBA8)
	var w := out.get_width()
	var h := out.get_height()
	var o := _v(p["origem"])
	var fill := PackedByteArray()
	fill.resize(w * h)
	var todo: Array[Vector2i] = []
	for c in p.get("apagar", []):
		var center := Vector2(c[0], c[1]) - o
		var r := float(c[2]) + 3.0
		for y in range(maxi(0, int(center.y - r)), mini(h, int(center.y + r) + 1)):
			for x in range(maxi(0, int(center.x - r)), mini(w, int(center.x + r) + 1)):
				if Vector2(x, y).distance_to(center) <= r and out.get_pixel(x, y).a > 0.05 and fill[y * w + x] == 0:
					fill[y * w + x] = 1
					todo.append(Vector2i(x, y))
	# Camadas de fora para dentro: cada pixel recebe a média dos vizinhos já conhecidos.
	var guard := 0
	while not todo.is_empty() and guard < 200:
		guard += 1
		var done: Array[Vector2i] = []
		var colors: Array[Color] = []
		var rest: Array[Vector2i] = []
		for q in todo:
			var sum := Color(0, 0, 0, 0)
			var n := 0
			var dark_sum := Color(0, 0, 0, 0)
			var dark_n := 0
			for dy in range(-2, 3):
				for dx in range(-2, 3):
					var nx := q.x + dx
					var ny := q.y + dy
					if nx < 0 or ny < 0 or nx >= w or ny >= h or fill[ny * w + nx] == 1:
						continue
					var c := out.get_pixel(nx, ny)
					if c.a < 0.5:
						continue
					if c.get_luminance() < 0.22:
						dark_sum += c
						dark_n += 1
					else:
						sum += c
						n += 1
			if n > 0:
				done.append(q)
				colors.append(sum / n)
			elif dark_n > 0 and guard > 40:
				done.append(q)
				colors.append(dark_sum / dark_n)
			else:
				rest.append(q)
		if done.is_empty():
			break
		for i in done.size():
			var c := colors[i]
			c.a = 1.0
			out.set_pixel(done[i].x, done[i].y, c)
			fill[done[i].y * w + done[i].x] = 0
		todo = rest
	for q in todo:
		out.set_pixel(q.x, q.y, Color(0, 0, 0, 0))
	return out


## Contorno convexo dos pixels visíveis da imagem (em pixels da imagem). Usado
## para achar o ponto mais baixo do pé em qualquer ângulo e plantá-lo no chão.
static func opaque_hull(img: Image, step := 2) -> PackedVector2Array:
	var pts: Array[Vector2] = []
	var w := img.get_width()
	var h := img.get_height()
	for x in range(0, w, step):
		var top := -1
		var bottom := -1
		for y in h:
			if img.get_pixel(x, y).a > 0.5:
				if top < 0:
					top = y
				bottom = y
		if top >= 0:
			pts.append(Vector2(x, top))
			pts.append(Vector2(x, bottom + 1))
	for y in range(0, h, step):
		var left := -1
		var right := -1
		for x in w:
			if img.get_pixel(x, y).a > 0.5:
				if left < 0:
					left = x
				right = x
		if left >= 0:
			pts.append(Vector2(left, y))
			pts.append(Vector2(right + 1, y))
	return convex_hull(pts)


## Fecho convexo (cadeia monótona de Andrew).
static func convex_hull(points: Array[Vector2]) -> PackedVector2Array:
	var pts := points.duplicate()
	pts.sort_custom(func(a: Vector2, b: Vector2) -> bool: return a.x < b.x or (a.x == b.x and a.y < b.y))
	if pts.size() < 3:
		return PackedVector2Array(pts)
	var lower: Array[Vector2] = []
	for p in pts:
		while lower.size() >= 2 and (lower[-1] - lower[-2]).cross(p - lower[-2]) <= 0.0:
			lower.pop_back()
		lower.append(p)
	var upper: Array[Vector2] = []
	for i in range(pts.size() - 1, -1, -1):
		var p: Vector2 = pts[i]
		while upper.size() >= 2 and (upper[-1] - upper[-2]).cross(p - upper[-2]) <= 0.0:
			upper.pop_back()
		upper.append(p)
	lower.pop_back()
	upper.pop_back()
	return PackedVector2Array(lower + upper)


## Desenha uma parte (imagem já sem as bolinhas) numa imagem, sem GPU. Usado
## pelas ferramentas de conferência que rodam sem janela.
static func draw_part(canvas: Image, tex: Image, region: Rect2, xf: Transform2D, clip: Rect2i) -> void:
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


## Imagens das partes prontas para desenhar sem GPU (com as bolinhas apagadas).
## Os rostos com expressão entram como "rosto:<nome>".
static func load_part_images(rig: Dictionary, rig_path: String) -> Dictionary:
	var dir := rig_path.get_base_dir()
	var out := {}
	for name in rig["partes"]:
		var p: Dictionary = rig["partes"][name]
		var img := Image.load_from_file(ProjectSettings.globalize_path(dir.path_join(p["arquivo"])))
		img.convert(Image.FORMAT_RGBA8)
		out[name] = erase_circles(img, p) if p.has("apagar") else img
	for face in rig.get("expressoes", {}):
		var fimg := Image.load_from_file(ProjectSettings.globalize_path(dir.path_join(rig["expressoes"][face]["arquivo"])))
		fimg.convert(Image.FORMAT_RGBA8)
		out["rosto:" + face] = fimg
	return out


static func load_rig(path: String) -> Dictionary:
	var text := FileAccess.get_file_as_string(path)
	var data: Variant = JSON.parse_string(text)
	return data if typeof(data) == TYPE_DICTIONARY else {}


static func _v(a: Array) -> Vector2:
	return Vector2(float(a[0]), float(a[1]))
