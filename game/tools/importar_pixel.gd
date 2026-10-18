extends SceneTree
## Importa as folhas de pixel art do ChatGPT para o jogo (sem janela):
## - lê cada folha de art/pixel/<personagem>/ (1536x1024, grade 3x2, quadros de
##   64x64 ampliados 8x, fundo magenta);
## - reduz para o tamanho nativo (1 pixel por bloco de 8x8), troca o magenta por
##   transparente, descarta células vazias;
## - alinha cada folha pela linha dos pés (pé mais baixo na linha 59);
## - <animacao>_meio.png (quadros intermediários) é intercalado com a folha
##   principal: 1, 1½, 2, 2½... Em animações em loop há também o quadro entre o
##   último e o primeiro;
## - folhas com várias animações (DIVIDIR) viram uma tira para cada uma;
## - grava uma tira por animação em game/assets/characters/<personagem>/pixel/
##   (<animacao>.png, quadros lado a lado) e animacoes.json com, por animação,
##   "quadros", "fator" (2 se intercalada) e "impacto" (quadro do golpe).
##   godot --headless --path game --script res://tools/importar_pixel.gd -- <personagem>
##
## Folhas _meio incompletas ou com o personagem fora de escala são recusadas
## (aviso no console) e a animação fica só com os quadros originais.
## Ajustes por folha (quadros a usar, quando a IA errou a grade) ficam em SELECAO.

const NATIVE := 64
const BASELINE := 59
## Pedaço solto com até este número de pixels (separado do personagem) é migalha
## da célula vizinha ou da redução de escala e é apagado. Objetos de propósito
## (laranjinha, coco, castanha) são bem maiores que isso. Playtest 01.
const MIGALHA := 4
## personagem -> animação -> índices dos quadros aproveitáveis (na ordem da grade)
const SELECAO := {}
## Intermediários errados (pose que não está entre os vizinhos): personagem ->
## animação -> índices (0 = entre o 1º e o 2º quadro). Viram cópia do quadro anterior.
const MEIO_REPETIR := {
	"seu_capivas": {"dor": [2]},  # veio em pé entre "lançado de costas" e "girando"
}
## Animações que não se alinham pelos pés (ficam como vieram; ex.: pendurado na
## borda, que o jogo prende pela mão).
const SEM_ALINHAR := ["pendurado"]
## Animações em loop (recebem também o intermediário entre o último e o primeiro).
const LOOPS := ["parado", "andar", "correr", "vitoria", "tonto", "descanso", "pendurado"]
## Folhas com mais de uma animação: folha -> {animação: quadros}.
const DIVIDIR := {
	"transicoes_a": {"virar": [0, 1, 2], "arrancar": [3, 4, 5]},
	"transicoes_b": {"frear": [0, 1, 2], "pouso": [3, 4, 5]},
}
## Quadro de impacto (na folha principal) quando foge do padrão 3->1, 5->2, 6->3.
const IMPACTO := {
	"seu_capivas": {"especial_neutro": 4, "especial_lado": 2, "especial_baixo": 2},
}


func _initialize() -> void:
	var who: String = OS.get_cmdline_user_args()[0]
	var src := ProjectSettings.globalize_path("res://").path_join("../art/pixel").path_join(who)
	var dst := ProjectSettings.globalize_path("res://assets/characters").path_join(who).path_join("pixel")
	DirAccess.make_dir_recursive_absolute(dst)
	for old in DirAccess.get_files_at(dst):
		if old.ends_with(".png"):
			DirAccess.remove_absolute(dst.path_join(old))
	var meta := {}
	var rejected: Array[String] = []
	for file in DirAccess.get_files_at(src):
		var anim := file.get_basename()
		if not file.ends_with(".png") or anim == "base" or anim.ends_with("_meio"):
			continue
		var frames := _read(src.path_join(file), SELECAO.get(who, {}).get(anim, []))
		if anim not in SEM_ALINHAR:
			frames = _align(frames)
		if DIVIDIR.has(anim):
			for part in DIVIDIR[anim]:
				var sub: Array[Image] = []
				for i in DIVIDIR[anim][part]:
					if i < frames.size():
						sub.append(frames[i])
				_save(dst, part, _align(sub), 1, meta, who)  # cada parte no próprio chão
			continue
		var factor := 1
		var mid_path := src.path_join(anim + "_meio.png")
		if FileAccess.file_exists(mid_path):
			var mids := _read(mid_path, [])
			var want := frames.size() if anim in LOOPS else frames.size() - 1
			var scale_off := _scale_drift(frames, mids)
			if mids.size() != want:
				push_warning("%s_meio: %d quadros, esperava %d: folha ignorada até vir completa" % [anim, mids.size(), want])
			elif scale_off != "":
				push_warning("%s_meio: personagem fora de escala (%s): folha ignorada, pedir de novo" % [anim, scale_off])
				rejected.append(anim)
			else:
				var mixed: Array[Image] = []
				var worst := Vector2i.ZERO
				for i in frames.size():
					mixed.append(frames[i])
					if i < mids.size():
						if i in MEIO_REPETIR.get(who, {}).get(anim, []):
							mixed.append(frames[i].duplicate())
							continue
						var fixed := _between(frames[i], frames[(i + 1) % frames.size()], mids[i])
						worst = worst.max(fixed[1].abs())
						mixed.append(fixed[0])
				frames = mixed
				factor = 2
				print("%s_meio: intermediários ajustados até %d px na horizontal e %d na vertical" % [anim, worst.x, worst.y])
		_save(dst, anim, frames, factor, meta, who)
	var keys := meta.keys()
	keys.sort()
	var ordered := {}
	for k in keys:
		ordered[k] = meta[k]
	# .import de tiras que não existem mais
	for old in DirAccess.get_files_at(dst):
		if old.ends_with(".png.import") and not meta.has(old.trim_suffix(".png.import")):
			DirAccess.remove_absolute(dst.path_join(old))
	FileAccess.open(dst.path_join("animacoes.json"), FileAccess.WRITE).store_string(JSON.stringify(ordered, "  ", false) + "\n")
	if not rejected.is_empty():
		print("RECUSADAS (escala): ", ", ".join(rejected))
	print("OK: ", dst)
	quit()


## Quadros nativos de uma folha (sem alinhar).
func _read(path: String, pick: Array) -> Array[Image]:
	var sheet := Image.load_from_file(path)
	sheet.convert(Image.FORMAT_RGBA8)
	var scale := sheet.get_width() / (NATIVE * 3)
	var frames: Array[Image] = []
	for r in sheet.get_height() / (NATIVE * scale):
		for c in 3:
			var f := _cell(sheet, c, r, scale)
			if f != null:
				frames.append(_clean_slivers(f, path.get_file(), frames.size()))
	if not pick.is_empty():
		var chosen: Array[Image] = []
		for i in pick:
			chosen.append(_widest_block(frames[i]))
		frames = chosen
	return frames


## Alinha um grupo de quadros pela linha dos pés (o pé mais baixo do grupo na
## linha 59), mantendo pulos e quedas relativos entre eles.
func _align(frames: Array[Image]) -> Array[Image]:
	var lowest := 0
	for f in frames:
		lowest = maxi(lowest, _bottom(f))
	var out: Array[Image] = []
	for f in frames:
		out.append(_moved(f, Vector2i(0, BASELINE - lowest)))
	return out


## Posiciona um quadro intermediário no meio do caminho entre os vizinhos (pelo
## centro do desenho); se os dois vizinhos estão no chão, ele também fica.
## Devolve [quadro, deslocamento aplicado].
func _between(a: Image, b: Image, mid: Image) -> Array:
	var target := (_centroid(a) + _centroid(b)) * 0.5
	var mc := _centroid(mid)
	var d := Vector2i(roundi(target.x - mc.x), roundi(target.y - mc.y))
	if _bottom(a) == BASELINE and _bottom(b) == BASELINE:
		d.y = BASELINE - _bottom(mid)
	return [_moved(mid, d), d]


func _moved(f: Image, d: Vector2i) -> Image:
	var out := Image.create(NATIVE, NATIVE, false, Image.FORMAT_RGBA8)
	out.blit_rect(f, Rect2i(0, 0, NATIVE, NATIVE), d)
	return out


func _centroid(img: Image) -> Vector2:
	var sum := Vector2.ZERO
	var n := 0
	for y in NATIVE:
		for x in NATIVE:
			if img.get_pixel(x, y).a > 0.5:
				sum += Vector2(x, y)
				n += 1
	return sum / maxf(1.0, n)

func _save(dst: String, anim: String, frames: Array[Image], factor: int, meta: Dictionary, who: String) -> void:
	if frames.is_empty():
		return
	var strip := Image.create(NATIVE * frames.size(), NATIVE, false, Image.FORMAT_RGBA8)
	for i in frames.size():
		strip.blit_rect(frames[i], Rect2i(0, 0, NATIVE, NATIVE), Vector2i(i * NATIVE, 0))
	strip.save_png(dst.path_join(anim + ".png"))
	var n0 := frames.size() if factor == 1 else (frames.size() + 1) / 2
	var impact: int = IMPACTO.get(who, {}).get(anim, 1 if n0 <= 3 else (2 if n0 <= 5 else 3))
	meta[anim] = {"quadros": frames.size(), "fator": factor, "impacto": impact * factor}
	print("%s: %d quadros%s" % [anim, frames.size(), " (intercalada)" if factor == 2 else ""])


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


## Intermediários desenhados em outra escala fazem o personagem "pulsar" de
## tamanho. Compara a área visível de cada intermediário com a média dos
## vizinhos; devolve "" se está tudo dentro de -25%..+15%.
func _scale_drift(frames: Array[Image], mids: Array[Image]) -> String:
	for i in mini(mids.size(), frames.size()):
		var a := _area(frames[i])
		var b := _area(frames[(i + 1) % frames.size()])
		var r := float(_area(mids[i])) / maxf(1.0, (a + b) * 0.5)
		if r > 1.15 or r < 0.75:
			return "intermediário %d com %d%% da área dos vizinhos" % [i + 1, roundi(r * 100.0)]
	return ""


func _area(img: Image) -> int:
	var n := 0
	for y in NATIVE:
		for x in NATIVE:
			if img.get_pixel(x, y).a > 0.5:
				n += 1
	return n


## Restos do quadro vizinho: quando o GPT desenha um quadro passando um pouco da
## célula, sobra no quadro ao lado uma lasquinha vertical fina colada na lateral.
## Apaga pedaços soltos com até 2 px de largura, pelo menos 3 de altura e a até
## 6 px da lateral esquerda ou direita. Efeitos de propósito (linhas de
## velocidade horizontais, poeira, faíscas, objetos) não têm esse formato, e
## lasquinhas brancas ou bem claras (linhas de tremida e de impacto) são mantidas.
func _clean_slivers(img: Image, sheet_name: String, index: int) -> Image:
	var seen := {}
	var parts := []
	for y in NATIVE:
		for x in NATIVE:
			var start := Vector2i(x, y)
			if seen.has(start) or img.get_pixel(x, y).a < 0.5:
				continue
			var stack: Array[Vector2i] = [start]
			seen[start] = true
			var comp: Array[Vector2i] = []
			while not stack.is_empty():
				var p: Vector2i = stack.pop_back()
				comp.append(p)
				for dy in [-1, 0, 1]:
					for dx in [-1, 0, 1]:
						var q := p + Vector2i(dx, dy)
						if q.x < 0 or q.y < 0 or q.x >= NATIVE or q.y >= NATIVE or seen.has(q):
							continue
						if img.get_pixel(q.x, q.y).a < 0.5:
							continue
						seen[q] = true
						stack.append(q)
			parts.append(comp)
	parts.sort_custom(func(a, b) -> bool: return a.size() > b.size())
	for comp in parts.slice(1):
		var lo := Vector2i(NATIVE, NATIVE)
		var hi := Vector2i(-1, -1)
		for p in comp:
			lo = lo.min(p)
			hi = hi.max(p)
		var w := hi.x - lo.x + 1
		var h := hi.y - lo.y + 1
		if comp.size() <= MIGALHA:
			for p in comp:
				img.set_pixel(p.x, p.y, Color(0, 0, 0, 0))
			print("  limpo: %s, célula %d, migalha de %d px em (%d, %d)" % [sheet_name, index + 1, comp.size(), lo.x, lo.y])
			continue
		if w <= 2 and h >= 3 and (lo.x <= 5 or hi.x >= NATIVE - 6):
			var avg := Color(0, 0, 0, 0)
			for p in comp:
				avg += img.get_pixel(p.x, p.y) / comp.size()
			if avg.get_luminance() > 0.8:
				continue  # branco/azul-claro: linha de efeito, não resto de sprite
			for p in comp:
				img.set_pixel(p.x, p.y, Color(0, 0, 0, 0))
			print("  limpo: %s, célula %d, lasca de %dx%d px em x=%d, cor %s" % [sheet_name, index + 1, w, h, lo.x, avg.to_html(false)])
	return img
