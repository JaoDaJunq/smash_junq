extends Node
## Plataformas que se movem (vitórias-régias do Pantanal): o lutador parado, andando
## e batendo em cima delas não pode cair sozinho.
##   godot --headless --path game res://tests/platforms_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	for i in Game.ARENAS.size():
		if String(Game.ARENAS[i]["scene"]).ends_with("pantanal.tscn"):
			Game.arena_index = i
	var m := MATCH.instantiate()
	add_child(m)
	await _frames(240)
	var fighters := m.find_children("*", "Fighter", true, false)
	var p1: Fighter = fighters[0]
	var p2: Fighter = fighters[1]
	var pad: AnimatableBody2D = m.find_children("*", "AnimatableBody2D", true, false)[0]
	for f in [p1, p2]:
		f.global_position = pad.global_position + Vector2(-40 if f == p1 else 40, -60)
		f.velocity = Vector2.ZERO
		f.state = Fighter.State.AIR
	p1.facing = 1
	await _frames(30)
	_check("Pousa na vitória-régia", p1.is_on_floor(), Fighter.State.keys()[p1.state])
	var fell := 0
	var worst := 0.0
	for k in 600:
		await get_tree().physics_frame
		worst = maxf(worst, absf((p1.global_position.y + Fighter.HEIGHT * 0.5) - pad.global_position.y))
		if k > 5 and not p1.is_on_floor():
			fell += 1
	_check("Parado 10 s em cima dela sem sair do chão", fell == 0, "%d quadros no ar, desvio %.1f px" % [fell, worst])
	fell = 0
	for k in 12:
		await _tap("p1_attack")
		await _frames(8)
		p2.damage_percent = 0.0
	var dx := absf(p1.global_position.x - pad.global_position.x)
	await _frames(20)
	_check("Batendo em cima dela continua na plataforma", p1.is_on_floor() and dx < 128.0, "no chão=%s, %.0f px do centro, estado %s" % [p1.is_on_floor(), dx, Fighter.State.keys()[p1.state]])
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _tap(action: String) -> void:
	Input.action_press(action)
	await _frames(2)
	Input.action_release(action)
	await _frames(1)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1
