extends Node
## Sonda (revisão Canga/Marianinha/Capivas): onde ficam estandarte e cama na beirada.
const MATCH := preload("res://scenes/match.tscn")
var me: Fighter
var foe: Fighter
var _match: Node

func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	Game.ko_target = 99
	Music.muted = true
	for arena in Game.ARENAS.size():
		Game.arena_index = arena
		for who in [3, 4]:
			Game.set_character("p1", who)
			Game.set_character("p2", 0)
			_match = MATCH.instantiate()
			add_child(_match)
			await _frames(240)
			for f in _match.find_children("*", "Fighter", true, false):
				if f.player_id == "p1":
					me = f
				else:
					foe = f
			foe.global_position = Vector2(0, -1500)
			foe.set_physics_process(false)
			var e := _edge(1)
			for dx in [12.0, 90.0]:
				me.global_position = Vector2(e.x - dx, -60)
				me.velocity = Vector2.ZERO
				me.state = Fighter.State.AIR
				me.facing = 1
				await _frames(30)
				var feet := me.global_position.y + Fighter.HEIGHT * 0.5
				me.start_special("side" if who == 3 else "up")
				await _frames(50)
				var grp := "estandartes" if who == 3 else "camas_elasticas"
				for o in get_tree().get_nodes_in_group(grp):
					if o.is_queued_for_deletion():
						continue
					print("arena %d %s dx=%d edge=%s feet_y=%.0f obj=%s grounded=%s" % [arena, grp, dx, e, feet, o.global_position.round(), o.is_grounded()])
				for n in get_tree().get_nodes_in_group("match_cleanup"):
					n.queue_free()
				await _frames(2)
			_match.queue_free()
			await _frames(5)
	get_tree().quit()

func _edge(side: int) -> Vector2:
	var best := Vector2(NAN, NAN)
	for l in get_tree().get_nodes_in_group("ledges"):
		var p: Vector2 = l.global_position
		if absf(p.y) < 2.0 and int(l.get_meta("side", 1)) == side:
			if is_nan(best.x) or p.x * side > best.x * side:
				best = p
	return best

func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
