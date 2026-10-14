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
static func part_transforms(rig: Dictionary, offsets: Dictionary) -> Dictionary:
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


static func load_rig(path: String) -> Dictionary:
	var text := FileAccess.get_file_as_string(path)
	var data: Variant = JSON.parse_string(text)
	return data if typeof(data) == TYPE_DICTIONARY else {}


static func _v(a: Array) -> Vector2:
	return Vector2(float(a[0]), float(a[1]))
