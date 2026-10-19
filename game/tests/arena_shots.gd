extends Node
## Prints das arenas dentro do jogo (COM janela; sem --headless não desenha):
## para cada arena, começa uma partida, espera a contagem e salva a tela em
## evidence/arenas/<arena>.png (e um segundo print com os lutadores trocando golpes).
##   godot --path game res://tests/arena_shots.tscn

const MATCH := preload("res://scenes/match.tscn")


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "cpu"
	var out := ProjectSettings.globalize_path("res://").path_join("../evidence/arenas")
	DirAccess.make_dir_recursive_absolute(out)
	var only := OS.get_cmdline_user_args()
	for i in Game.ARENAS.size():
		var a: Dictionary = Game.ARENAS[i]
		var key := String(a["scene"]).get_file().get_basename()
		if not only.is_empty() and key not in only:
			continue
		if not Game.arena_ready(a):
			continue
		Game.arena_index = i
		var m := MATCH.instantiate()
		add_child(m)
		await _frames(260)
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png(out.path_join(key + ".png"))
		await _frames(240)
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png(out.path_join(key + "_luta.png"))
		print("print: ", key)
		m.queue_free()
		await _frames(5)
	get_tree().quit()


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
