extends Node
## Teste de fumaça do Cerrado: galho do meio alcançável por todos, zona de KO
## própria da arena aplicada sem matar quem está em cima dos galhos, e CPU que
## não fica presa uma em cima da outra.
##   godot --headless --path game res://tests/cerrado_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const CERRADO := 3
const TOP_Y := -330.0   # topo do galho do meio

var results: Array[String] = []
var failures := 0
var _match: Node


func _ready() -> void:
	Game.suppress_scene_changes = true
	_check("Arena 3 é o Cerrado", Game.ARENAS[CERRADO]["name"] == "Cerrado", Game.ARENAS[CERRADO]["name"])
	Game.arena_index = CERRADO
	Game.mode = "training"
	var reach_fail: Array[String] = []
	var top_fail: Array[String] = []
	var worst_top := 0.0
	for idx in Game.CHARACTERS.size():
		if not Game.character_ready(idx):
			continue
		Game.set_character("p1", idx)
		Game.set_character("p2", 0)
		await _start()
		var me: Fighter = _match.fighters["p1"]
		var foe: Fighter = _match.fighters["p2"]
		if idx == 0:
			var zone: Rect2 = _match.ko_zone
			_check("Partida usa a zona de KO do Cerrado", zone == Rect2(-1100, -1350, 2200, 2150), str(zone))
		foe.global_position = Vector2(700, -500)   # longe, em cima da ilha da direita
		# 1) Do chão, embaixo do galho do meio: pulo + pulo duplo chega lá em cima.
		var on_top := await _climb(me, Vector2(0, -60))
		if not on_top:
			reach_fail.append(me.display_name)
		# 2) Em cima do galho: pulo + pulo duplo + especial para cima não sai da zona.
		# (mede com a zona desligada, para saber até onde a pessoa sobe de verdade)
		var arena_zone: Rect2 = _match.ko_zone
		_match.ko_zone = Rect2(-5000, -5000, 10000, 10000)
		var min_y := await _max_up(me, Vector2(0, TOP_Y - 60.0))
		_match.ko_zone = arena_zone
		print("  %s: do galho do meio sobe até y=%.0f" % [me.display_name, min_y])
		worst_top = minf(worst_top, min_y)
		if min_y < arena_zone.position.y + 40.0:
			top_fail.append("%s (%.0f)" % [me.display_name, min_y])
		_match.queue_free()
		await _frames(3)
	_check("Todos sobem no galho do meio (pulo + pulo duplo, do chão)", reach_fail.is_empty(), "não sobem: %s" % str(reach_fail))
	_check("Ninguém sai pelo topo saltando do galho do meio", top_fail.is_empty(),
		"mais alto y=%.0f; perto do limite: %s" % [worst_top, str(top_fail)])
	await _cpu_unstack()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _start() -> void:
	_match = MATCH.instantiate()
	add_child(_match)
	await _frames(5)
	_match.skip_countdown()
	await _frames(60)


func _place(f: Fighter, pos: Vector2) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f.state = Fighter.State.AIR
	f.facing = 1
	f.invincible_time = 0.0
	for a in ["jump", "up", "special", "left", "right", "down"]:
		Input.action_release("p1_" + a)
	await _frames(40)


## Pula segurando, pulo duplo perto do auge; true se terminou em pé no galho do meio.
func _climb(f: Fighter, from: Vector2) -> bool:
	await _place(f, from)
	Input.action_press("p1_jump")
	await _frames(3)
	while f.velocity.y < -120.0:
		await get_tree().physics_frame
	Input.action_release("p1_jump")
	await get_tree().physics_frame
	Input.action_press("p1_jump")
	await _frames(20)
	Input.action_release("p1_jump")
	await _frames(60)
	var feet := f.global_position.y + Fighter.HEIGHT * 0.5
	return f.is_on_floor() and absf(feet - TOP_Y) < 12.0


## Do galho do meio: pulo, todos os pulos no ar (no auge) e especial para cima.
## Devolve o menor y alcançado.
func _max_up(f: Fighter, from: Vector2) -> float:
	await _place(f, from)
	var min_y := [f.global_position.y]
	Input.action_press("p1_jump")
	await _track(f, min_y, 3)
	while true:
		while f.velocity.y < -120.0:
			await _track(f, min_y, 1)
		Input.action_release("p1_jump")
		await _track(f, min_y, 1)
		if f.jumps_left <= 0:
			break
		Input.action_press("p1_jump")
		await _track(f, min_y, 3)
	Input.action_press("p1_up")
	Input.action_press("p1_special")
	await _track(f, min_y, 30)
	for a in ["jump", "up", "special"]:
		Input.action_release("p1_" + a)
	await _track(f, min_y, 60)
	return min_y[0]


func _track(f: Fighter, min_y: Array, n: int) -> void:
	for i in n:
		await get_tree().physics_frame
		min_y[0] = minf(min_y[0], f.global_position.y)


## Duas CPUs, uma no galho do meio e outra no chão embaixo: em até 8 s elas
## ficam na mesma altura em algum momento (quem está em cima desce ou o de baixo sobe).
func _cpu_unstack() -> void:
	Game.mode = "versus"
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	await _start()
	var top: Fighter = _match.fighters["p1"]
	var low: Fighter = _match.fighters["p2"]
	top.set_cpu(CpuBrain.new(5))
	low.set_cpu(CpuBrain.new(6))
	top.global_position = Vector2(0, TOP_Y - 60.0)
	low.global_position = Vector2(10, -60)
	top.velocity = Vector2.ZERO
	low.velocity = Vector2.ZERO
	var met_at := -1.0
	for i in 480:
		await get_tree().physics_frame
		if i > 30 and absf(top.global_position.y - low.global_position.y) < 100.0:
			met_at = i / 60.0
			break
	_check("CPUs não ficam uma em cima da outra (encontram-se em até 8 s)", met_at >= 0.0, "%.1f s" % met_at)
	_match.queue_free()
	await _frames(3)


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
