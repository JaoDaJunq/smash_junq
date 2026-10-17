extends SceneTree
## Checagem de "ilhas" de pixels nas tiras de pixel art que estão no jogo (sem janela).
## Em cada quadro de 64x64, junta os pixels opacos que se tocam (inclusive na
## diagonal) em grupos. O personagem é o grupo maior; qualquer outro grupo é uma
## ilha: sobra do quadro vizinho, efeito desenhado solto (poeira, rastro, brilho)
## ou pedaço de cenário. Também avisa quando o desenho encosta na lateral do quadro
## (sinal de pose cortada ou de lasca da célula ao lado).
##
## Regra do projeto (design/identidade.md, "Regras de produção do pixel art"):
## rodar em TODAS as folhas dos DOIS personagens a cada importação.
##   godot --headless --path game --script res://tools/checar_ilhas.gd
##   godot --headless --path game --script res://tools/checar_ilhas.gd -- juba
## Termina com código 1 se achar algum problema.

const NATIVE := 64
## Ilha com até este número de pixels é tratada como pixel solto/sobra.
const SOBRA := 12
## Tiras que não são o lutador (efeitos e projéteis): pedaços soltos são esperados.
const NAO_LUTADOR := ["castanha"]
## Objetos soltos de propósito: "personagem/animação" -> o que é.
const OBJETOS := {"seu_capivas/dor": "laranjinha voando da cabeça (piada)"}


func _initialize() -> void:
	var root := ProjectSettings.globalize_path("res://assets/characters")
	var who: Array = OS.get_cmdline_user_args()
	if who.is_empty():
		who = Array(DirAccess.get_directories_at(root)).filter(func(d: String) -> bool:
			return FileAccess.file_exists(root.path_join(d).path_join("pixel/animacoes.json")))
	var problems := 0
	var total := 0
	for person in who:
		var dir := root.path_join(person).path_join("pixel")
		var meta: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(dir.path_join("animacoes.json")))
		var anims := meta.keys()
		anims.sort()
		for anim in anims:
			if anim.begins_with("fx_") or anim in NAO_LUTADOR or OBJETOS.has("%s/%s" % [person, anim]):
				continue
			var img := Image.load_from_file(dir.path_join(anim + ".png"))
			img.convert(Image.FORMAT_RGBA8)
			var n := img.get_width() / NATIVE
			for i in n:
				total += 1
				var notes := _check(img.get_region(Rect2i(i * NATIVE, 0, NATIVE, NATIVE)))
				if not notes.is_empty():
					problems += 1
					print("%s/%s quadro %d: %s" % [person, anim, i, "; ".join(notes)])
	print("RESULTADO: %d quadro(s) com problema em %d conferido(s)" % [problems, total])
	quit(1 if problems > 0 else 0)


func _check(frame: Image) -> PackedStringArray:
	var groups := _groups(frame)
	var notes := PackedStringArray()
	if groups.is_empty():
		return PackedStringArray(["quadro vazio"])
	groups.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return a["px"] > b["px"])
	for g in groups.slice(1):
		var r: Rect2i = g["rect"]
		var kind := "pixel solto" if g["px"] <= SOBRA else "pedaço separado"
		notes.append("%s de %d px em x %d-%d, y %d-%d" % [kind, g["px"], r.position.x, r.end.x - 1, r.position.y, r.end.y - 1])
	for side in [0, NATIVE - 1]:
		for y in NATIVE:
			if frame.get_pixel(side, y).a > 0.5:
				notes.append("encosta na %s do quadro" % ("esquerda" if side == 0 else "direita"))
				break
	return notes


## Grupos de pixels opacos ligados (8 vizinhos): [{px, rect}].
func _groups(frame: Image) -> Array[Dictionary]:
	var seen := PackedByteArray()
	seen.resize(NATIVE * NATIVE)
	var out: Array[Dictionary] = []
	for start in NATIVE * NATIVE:
		if seen[start] or frame.get_pixel(start % NATIVE, start / NATIVE).a <= 0.5:
			continue
		seen[start] = 1
		var stack := [start]
		var count := 0
		var lo := Vector2i(NATIVE, NATIVE)
		var hi := Vector2i(-1, -1)
		while not stack.is_empty():
			var k: int = stack.pop_back()
			var p := Vector2i(k % NATIVE, k / NATIVE)
			count += 1
			lo = lo.min(p)
			hi = hi.max(p)
			for dy in [-1, 0, 1]:
				for dx in [-1, 0, 1]:
					var q := p + Vector2i(dx, dy)
					if q.x < 0 or q.y < 0 or q.x >= NATIVE or q.y >= NATIVE:
						continue
					var j := q.y * NATIVE + q.x
					if not seen[j] and frame.get_pixel(q.x, q.y).a > 0.5:
						seen[j] = 1
						stack.append(j)
		out.append({"px": count, "rect": Rect2i(lo, hi - lo + Vector2i.ONE)})
	return out
