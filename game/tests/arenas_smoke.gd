extends Node
## Teste das arenas (sem janela): cada arena da lista carrega com a arte
## importada, tem as duas bordas, as duas plataformas e os pontos de entrada, e
## uma partida começa nela com os dois lutadores pisando no palco.
##   godot --headless --path game res://tests/arenas_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	Game.suppress_scene_changes = true
	for i in Game.ARENAS.size():
		var a: Dictionary = Game.ARENAS[i]
		_check("%s: arte e cena prontas" % a["name"], Game.arena_ready(a), a["scene"])
		var arena := (load(a["scene"]) as PackedScene).instantiate()
		add_child(arena)
		await get_tree().process_frame
		var ledges := arena.find_children("*", "Marker2D", true, false).filter(func(n: Node) -> bool: return n.is_in_group("ledges"))
		_check("%s: bordas para agarrar" % a["name"], ledges.size() >= 2, str(ledges.size()))
		_check("%s: pontos de entrada" % a["name"], arena.has_node("SpawnP1") and arena.has_node("SpawnP2"), "")
		var art := arena.get_node_or_null("ArtArena")
		if art:
			_check("%s: terreno montado com blocos" % a["name"], art.get_children().filter(func(n: Node) -> bool: return n is Sprite2D).size() >= 12, "")
			var key := String(a["scene"]).get_file().get_basename()
			var layout: Dictionary = art.LAYOUTS[key]
			var movers := art.find_children("*", "AnimatableBody2D", true, false).size()
			_check("%s: plataformas que se movem conforme o formato" % a["name"], movers == layout["moving"].size(), str(movers))
		arena.queue_free()
		await get_tree().process_frame
		Game.arena_index = i
		var m := MATCH.instantiate()
		add_child(m)
		await _frames(320)  # contagem regressiva + queda
		var fighters := get_tree().get_nodes_in_group("fighters")
		var standing := fighters.filter(func(f: Fighter) -> bool: return f.is_on_floor())
		_check("%s: partida começa e os dois pisam no palco" % a["name"], fighters.size() == 2 and standing.size() == 2, "%d de %d no chão" % [standing.size(), fighters.size()])
		m.queue_free()
		await _frames(3)
	Game.arena_index = 0
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
