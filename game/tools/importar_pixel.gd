extends SceneTree
## Importa as folhas de pixel art do ChatGPT para o jogo (sem janela):
## - lê cada folha de art/pixel/<personagem>/ (1536x1024, grade 3x2, quadros de
##   64x64 ampliados 8x, fundo magenta);
## - reduz para o tamanho nativo (1 pixel por bloco de 8x8), troca o magenta por
##   transparente, descarta células vazias;
## - alinha a folha pela linha dos pés (pé mais baixo na linha 59);
## - grava uma tira por animação em game/assets/characters/<personagem>/pixel/
##   (<animacao>.png, quadros lado a lado) e um animacoes.json com a contagem.
##   godot --headless --path game --script res://tools/importar_pixel.gd -- <personagem>
##
## Ajustes por folha (quadros a usar, quando a IA errou a grade) ficam em SELECAO.

const NATIVE := 64
const BASELINE := 59
## personagem -> animação -> índices dos quadros aproveitáveis (na ordem da grade)
const SELECAO := {
	"seu_capivas": {"dor": [0, 2]},  # a folha veio fora da grade: só o 1º e o último quadro estão inteiros
}


func _initialize() -> void:
	var who: String = OS.get_cmdline_user_args()[0]
	var src := ProjectSettings.globalize_path("res://").path_join("../art/pixel").path_join(who)
	var dst := ProjectSettings.globalize_path("res://assets/characters").path_join(who).path_join("pixel")
	DirAccess.make_dir_recursive_absolute(dst)
	var meta := {}
	for file in DirAccess.get_files_at(src):
		if not file.ends_with(".png") or file == "base.png":
			continue
		var anim := file.get_basename()
		var sheet := Image.load_from_file(src.path_join(file))
		sheet.convert(Image.FORMAT_RGBA8)
		var scale := sheet.get_width() / (NATIVE * 3)
		var frames: Array[Image] = []
		for r in sheet.get_height() / (NATIVE * scale):
			for c in 3:
				var f := _cell(sheet, c, r, scale)
				if f != null:
					frames.append(f)
		var pick: Array = SELECAO.get(who, {}).get(anim, [])
		if not pick.is_empty():
			var chosen: Array[Image] = []
			for i in pick:
				chosen.append(_widest_block(frames[i]))
			frames = chosen
		# Alinha a folha inteira pela linha dos pés (mantém pulos e quedas relativos)
		var lowest := 0
		for f in frames:
			lowest = maxi(lowest, _bottom(f))
		var shift := BASELINE - lowest
		var strip := Image.create(NATIVE * frames.size(), NATIVE, false, Image.FORMAT_RGBA8)
		for i in frames.size():
			strip.blit_rect(frames[i], Rect2i(0, 0, NATIVE, NATIVE), Vector2i(i * NATIVE, shift))
		strip.save_png(dst.path_join(anim + ".png"))
		meta[anim] = frames.size()
		print("%s: %d quadros (pés deslocados %d px)" % [anim, frames.size(), shift])
	var keys := meta.keys()
	keys.sort()
	var ordered := {}
	for k in keys:
		ordered[k] = meta[k]
	FileAccess.open(dst.path_join("animacoes.json"), FileAccess.WRITE).store_string(JSON.stringify(ordered, "  ", false) + "\n")
	print("OK: ", dst)
	quit()


## Folha fora da grade: fica só com o maior bloco de colunas ocupadas do quadro
## (descarta fatias de quadros vizinhos que invadiram a célula).
func _widest_block(img: Image) -> Image:
	var used := []
	for x in NATIVE:
		var any := false
		for y in NATIVE:
			if img.get_pixel(x, y).a > 0.5:
				any = true
				break
		used.append(any)
	var best := Vector2i(0, NATIVE)
	var start := -1
	for x in NATIVE + 1:
		var on: bool = x < NATIVE and used[x]
		if on and start < 0:
			start = x
		elif not on and start >= 0:
			if x - start > best.y - best.x or best == Vector2i(0, NATIVE):
				best = Vector2i(start, x)
			start = -1
	var out := Image.create(NATIVE, NATIVE, false, Image.FORMAT_RGBA8)
	out.blit_rect(img, Rect2i(best.x, 0, best.y - best.x, NATIVE), Vector2i(best.x, 0))
	return out


## Um quadro nativo 64x64 (ou null se a célula está vazia ou só tem sujeira).
func _cell(sheet: Image, col: int, row: int, scale: int) -> Image:
	var img := Image.create(NATIVE, NATIVE, false, Image.FORMAT_RGBA8)
	var count := 0
	for y in NATIVE:
		for x in NATIVE:
			var c := sheet.get_pixel((col * NATIVE + x) * scale + scale / 2, (row * NATIVE + y) * scale + scale / 2)
			if c.r > 0.85 and c.b > 0.85 and c.g < 0.2:
				continue
			img.set_pixel(x, y, Color(c.r, c.g, c.b, 1.0))
			count += 1
	return img if count > 40 else null


func _bottom(img: Image) -> int:
	for y in range(NATIVE - 1, -1, -1):
		for x in NATIVE:
			if img.get_pixel(x, y).a > 0.5:
				return y
	return 0
