extends Node
## Sonda (revisão): cama e estandarte na ponta de cima da laje da Caatinga (lado esquerdo).
const MATCH := preload("res://scenes/match.tscn")
var me: Fighter
var foe: Fighter

func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	Game.ko_target = 99
	Music.muted = true
	Game.arena_index = 2
	for who in [3, 4]:
		Game.set_character("p1", who)
		Game.set_character("p2", 0)
		var m := MATCH.instantiate()
		add_child(m)
		await _frames(240)
		for f in m.find_children("*", "Fighter", true, false):
			if f.player_id == "p1":
				me = f
			else:
				foe = f
		foe.global_position = Vector2(0, -1500)
		foe.set_physics_process(false)
		for l in get_tree().get_nodes_in_group("ledges"):
			print("ledge ", l.global_position, " side ", l.get_meta("side", 1))
		var top := -120.0
		var edge_x := -640.0   # quina esquerda da laje (ledge)
		for dx in [12.0, 60.0]:
			me.global_position = Vector2(edge_x + dx, top - 60)
			me.velocity = Vector2.ZERO
			me.state = Fighter.State.AIR
			me.facing = -1
			await _frames(30)
			me.start_special("side" if who == 3 else "up")
			await _frames(40)
			var grp := "estandartes" if who == 3 else "camas_elasticas"
			for o in get_tree().get_nodes_in_group(grp):
				if not o.is_queued_for_deletion():
					print("%s dx=%d obj=%s apoiado=%s me=%s" % [grp, dx, o.global_position.round(), o.is_grounded(), me.global_position.round()])
			for n in get_tree().get_nodes_in_group("match_cleanup"):
				n.queue_free()
			await _frames(3)
		m.queue_free()
		await _frames(5)
	get_tree().quit()

func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
