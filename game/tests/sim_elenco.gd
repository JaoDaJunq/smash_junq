extends Node
## Simulação do elenco: partidas CPU x CPU sem janela, gravadas num CSV para
## medir equilíbrio (tools/checa_matriz.py lê o CSV).
##   godot --headless --fixed-fps 60 --path game res://tests/sim_elenco.tscn -- \
##       --pairs all --seeds 1,2,3 --arena 3 --max 600 --out C:/caminho/sim.csv
## Argumentos (todos opcionais, depois de "--"):
##   --pairs  "i:j,k:l" (índices em Game.CHARACTERS) ou "all" (todos x todos prontos)
##   --seeds  "1,2,3"  semente das duas CPUs (P1 = s*1000+1, P2 = s*1000+2)
##   --arena  índice em Game.ARENAS (padrão 0)
##   --max    segundos de jogo por partida antes de desistir (padrão 600)
##   --out    caminho do CSV (padrão user://sim_elenco.csv); acrescenta linhas
##   --log    S: imprime posição/estado dos dois a cada S segundos de jogo
## Colunas: p1_idx,p2_idx,p1_nome,p2_nome,arena,semente,vencedor,sem_vencedor,
##          dur_jogo_s,ko_p1,ko_p2   (ko_pX = KOs marcados pelo jogador X)

const MATCH_SCENE := preload("res://scenes/match.tscn")
const HEADER := "p1_idx,p2_idx,p1_nome,p2_nome,arena,semente,vencedor,sem_vencedor,dur_jogo_s,ko_p1,ko_p2"

var _winner := ""
var _args := {}


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "cpu"
	var args := _parse(OS.get_cmdline_user_args())
	_args = args
	Game.arena_index = int(args.get("arena", "0"))
	var max_s := float(args.get("max", "600"))
	var out_path: String = args.get("out", "user://sim_elenco.csv")
	var seeds: Array[int] = []
	for s in String(args.get("seeds", "1")).split(",", false):
		seeds.append(int(s))
	var pairs := _pairs(String(args.get("pairs", "all")))
	var new_file := not FileAccess.file_exists(out_path)
	var f := FileAccess.open(out_path, FileAccess.READ_WRITE if not new_file else FileAccess.WRITE)
	if f == null:
		printerr("[FALHA] não abriu %s (erro %d)" % [out_path, FileAccess.get_open_error()])
		get_tree().quit(1)
		return
	f.seek_end()
	if new_file:
		f.store_line(HEADER)
	var total := pairs.size() * seeds.size()
	var n := 0
	var stuck := 0
	for pair in pairs:
		for s in seeds:
			n += 1
			var row := await _play(pair[0], pair[1], s, max_s)
			f.store_line(row["csv"])
			f.flush()
			if row["stuck"]:
				stuck += 1
			print("[%d/%d] %s" % [n, total, row["csv"]])
	f.close()
	print("SIM: %d partida(s), %d sem vencedor -> %s" % [total, stuck, ProjectSettings.globalize_path(out_path)])
	print("RESULTADO: OK (0 falha(s))")
	get_tree().quit(0)


func _parse(raw: PackedStringArray) -> Dictionary:
	var out := {}
	var i := 0
	while i < raw.size():
		var a := raw[i]
		if a.begins_with("--") and i + 1 < raw.size():
			out[a.substr(2)] = raw[i + 1]
			i += 2
		else:
			i += 1
	return out


## Pares [p1, p2]. "all" = todos os personagens prontos contra todos (com espelhos).
func _pairs(spec: String) -> Array:
	var out: Array = []
	if spec == "all":
		var ready: Array[int] = []
		for i in Game.CHARACTERS.size():
			if Game.character_ready(i):
				ready.append(i)
		for a in ready:
			for b in ready:
				out.append([a, b])
		return out
	for p in spec.split(",", false):
		var ab := p.split(":")
		if ab.size() == 2:
			out.append([int(ab[0]), int(ab[1])])
	return out


func _play(i1: int, i2: int, s: int, max_s: float) -> Dictionary:
	seed(s)   # aleatório global (efeitos, personagens) também fica reproduzível
	Game.set_character("p1", i1)
	Game.set_character("p2", i2)
	var match_node := MATCH_SCENE.instantiate()
	match_node.cpu_seed = s * 1000 + 2   # P2 já nasce com semente
	add_child(match_node)
	await get_tree().physics_frame
	var p1: Fighter = match_node.fighters["p1"]
	var p2: Fighter = match_node.fighters["p2"]
	# As duas CPUs com semente (a partida cria a do P2 sem semente).
	p1.set_cpu(CpuBrain.new(s * 1000 + 1))
	p2.set_cpu(CpuBrain.new(s * 1000 + 2))
	_winner = ""
	match_node.match_ended.connect(func(w: String) -> void: _winner = w)
	match_node.skip_countdown()
	var seconds := 0.0
	var step := 1.0 / Engine.physics_ticks_per_second
	var log_every := float(_args.get("log", "0"))
	while _winner == "" and seconds < max_s:
		await get_tree().physics_frame
		seconds += step
		if log_every > 0.0 and fmod(seconds, log_every) < step:
			print("  t=%3ds kos %d-%d | P1 %s %s %.0f%% | P2 %s %s %.0f%%" % [int(seconds), match_node.kos["p1"], match_node.kos["p2"],
				p1.global_position.round(), Fighter.State.keys()[p1.state], p1.damage_percent,
				p2.global_position.round(), Fighter.State.keys()[p2.state], p2.damage_percent])
	var stuck := _winner == ""
	var cols: Array[String] = [str(i1), str(i2), p1.display_name.replace(",", " "), p2.display_name.replace(",", " "),
		str(Game.arena_index), str(s), _winner if not stuck else "nenhum", "sim" if stuck else "nao",
		"%.1f" % seconds, str(match_node.kos["p1"]), str(match_node.kos["p2"])]
	match_node.queue_free()
	await get_tree().physics_frame
	await get_tree().physics_frame
	return {"csv": ",".join(cols), "stuck": stuck}
