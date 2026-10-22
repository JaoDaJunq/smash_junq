extends Node
## Sonda (revisão): estandarte e cama em cima da vitória-régia (Pantanal) seguem a folha?
const MATCH := preload("res://scenes/match.tscn")
var me: Fighter
var foe: Fighter

func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	Game.ko_target = 99
	Music.muted = true
	Game.arena_index = 1
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
		var pad: Node2D
		for n in m.find_children("*", "AnimatableBody2D", true, false):
			pad = n
			break
		me.global_position = pad.global_position + Vector2(-40, -70)
		me.velocity = Vector2.ZERO
		me.state = Fighter.State.AIR
		me.facing = 1
		await _frames(25)
		print("antes: canga=", me.global_position, " chao=", me.is_on_floor(), " pad=", pad.global_position)
		me.start_special("side" if who == 3 else "up")
		var grp := "estandartes" if who == 3 else "camas_elasticas"
		for i in 14:
			await _frames(10)
			for o in get_tree().get_nodes_in_group(grp):
				print("%s t=%d obj=%s apoiado=%s floor=%s pad=%s me=%s" % [grp, i, o.global_position.round(), o.is_grounded(), o._floor, pad.global_position.round(), me.global_position.round()])
		m.queue_free()
		for n in get_tree().get_nodes_in_group("match_cleanup"):
			n.queue_free()
		await _frames(5)
	get_tree().quit()

func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
