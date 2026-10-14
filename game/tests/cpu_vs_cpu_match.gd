extends Node
## Partida completa CPU contra CPU, acelerada. Confere que a partida termina com
## vencedor e mede a duração em tempo de jogo, para comparar com os 3 a 5 minutos
## esperados no GDD. Roda os quatro confrontos de personagens.
##   godot --headless --fixed-fps 60 --path game res://tests/cpu_vs_cpu_match.tscn  (-- --one --log)

const MATCH_SCENE := preload("res://scenes/match.tscn")
const MAX_SECONDS := 600.0

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "cpu"
	var pairs := [[0, 1], [1, 0], [0, 0], [1, 1]]
	if "--one" in OS.get_cmdline_user_args():
		pairs = [[0, 1]]
	for pair in pairs:
		Game.set_character("p1", pair[0])
		Game.set_character("p2", pair[1])
		await _play_one()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _play_one() -> void:
	var match_node := MATCH_SCENE.instantiate()
	add_child(match_node)
	await get_tree().physics_frame
	var p1: Fighter = match_node.fighters["p1"]
	var p2: Fighter = match_node.fighters["p2"]
	p1.set_cpu(CpuBrain.new(11))
	_winner = ""
	match_node.match_ended.connect(func(w: String) -> void: _winner = w)
	match_node.ko_scored.connect(func(scorer: String, victim: String) -> void: _log_ko(match_node, scorer, victim))
	_elapsed = 0.0
	match_node.skip_countdown()
	var seconds := 0.0
	var step := 1.0 / Engine.physics_ticks_per_second
	while _winner == "" and seconds < MAX_SECONDS:
		await get_tree().physics_frame
		seconds += step
		_elapsed = seconds
		if "--log" in OS.get_cmdline_user_args() and fmod(seconds, 15.0) < step:
			print("t=%3ds real=%5dms kos %d-%d | P1 %s %s %.0f%% %s | P2 %s %s %.0f%% %s" % [int(seconds), Time.get_ticks_msec(), match_node.kos["p1"], match_node.kos["p2"], p1.global_position.round(), Fighter.State.keys()[p1.state], p1.damage_percent, p1.brain.mode, p2.global_position.round(), Fighter.State.keys()[p2.state], p2.damage_percent, p2.brain.mode])
	var label := "%s x %s" % [p1.display_name, p2.display_name]
	var ok := _winner != ""
	if not ok:
		failures += 1
	results.append("[%s] %s — %s em %d:%02d, placar %d x %d" % ["OK" if ok else "FALHA", label,
		("venceu " + _winner.to_upper()) if ok else "sem vencedor", int(seconds) / 60, int(seconds) % 60,
		match_node.kos["p1"], match_node.kos["p2"]])
	match_node.queue_free()
	await get_tree().physics_frame


var _winner := ""
var _elapsed := 0.0
var ko_log: Array[String] = []


func _log_ko(match_node: Node, scorer: String, victim: String) -> void:
	var v: Fighter = match_node.fighters[victim]
	var line := "  KO t=%5.1fs %s caiu (%s, %.0f%%, estado %s, sem pulo=%s, pos %s)" % [_elapsed, victim.to_upper(),
		v.display_name, v.damage_percent, Fighter.State.keys()[v.state], v.helpless, v.global_position.round()]
	ko_log.append(line)
	if "--log" in OS.get_cmdline_user_args():
		print(line)
