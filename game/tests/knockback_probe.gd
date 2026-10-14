extends Node
## Sonda de calibração: aplica golpes direto no alvo (sem KO automático) e mede até
## onde ele voa em 3 s, partindo do centro; só conta KO direto pela lateral ou topo. Não é teste de aprovação; imprime uma
## tabela para ajustar Combat.LAUNCH_DECAY, gravidade no atordoamento e zonas de KO.
##   godot --headless --path game res://tests/knockback_probe.tscn

const MAIN := preload("res://scenes/main.tscn")
const KO_ZONE := Rect2(-1400, -1200, 2800, 2100)
const MOVES := ["ftilt", "utilt", "fair", "uair", "special_neutral", "special_side"]


func _ready() -> void:
	var main := MAIN.instantiate()
	add_child(main)
	var p1: Fighter = main.get_node("P1")
	var p2: Fighter = main.get_node("P2")
	for f in [p1, p2]:
		f.auto_respawn = false
	await get_tree().physics_frame
	for pair in [[p1, p2], [p2, p1]]:
		var mover: Fighter = pair[0]
		var target: Fighter = pair[1]
		mover.set_physics_process(false)
		target.set_physics_process(true)
		print("== %s acerta %s (peso %d)" % [mover.display_name, target.display_name, target.weight])
		for move in MOVES:
			var data: AttackData = mover.moveset.move(move)
			if data == null:
				continue
			var line := "%-16s" % move
			for pct in [0, 60, 100, 140, 180]:
				target.respawn()
				target.global_position = Vector2(0, -56)
				target.state = Fighter.State.IDLE
				await get_tree().physics_frame
				target.damage_percent = float(pct)
				target.receive_hit(mover, data, 1)
				var far := 0.0
				var top := 0.0
				var ko := false
				for i in 180:
					await get_tree().physics_frame
					far = maxf(far, target.global_position.x)
					top = minf(top, target.global_position.y)
					if target.global_position.x > KO_ZONE.end.x or target.global_position.y < KO_ZONE.position.y:
						ko = true
						break
				line += " | %3d%% x+%4.0f y%5.0f%s" % [pct, far, top, " KO" if ko else "   "]
			print(line)
	get_tree().quit()
