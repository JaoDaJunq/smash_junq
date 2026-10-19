extends Node
## Prints das telas fora da partida (COM janela; sem --headless não desenha):
## menu inicial, seleção de personagem (2 jogadores, cursores em lugares
## diferentes) e escolha de arena, em evidence/telas/.
##   godot --path game res://tests/menu_shots.tscn

const SCREENS := {
	"menu": "res://scenes/ui/main_menu.tscn",
	"selecao": "res://scenes/ui/character_select.tscn",
	"arena": "res://scenes/ui/arena_select.tscn",
	"modo": "res://scenes/ui/mode_select.tscn",
}


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "versus"
	var out := ProjectSettings.globalize_path("res://").path_join("../evidence/telas")
	DirAccess.make_dir_recursive_absolute(out)
	for key in SCREENS:
		var s: Node = (load(SCREENS[key]) as PackedScene).instantiate()
		add_child(s)
		await _frames(30)
		if key == "selecao":
			s._move("p2", Vector2i(1, 0))   # P2 num "?" para mostrar o "em breve"
			await _frames(5)
			s._toggle_lock("p1")
		elif key == "arena":
			s._select(2)
		await _frames(40)
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png(out.path_join(key + ".png"))
		print("print: ", key)
		s.queue_free()
		await _frames(3)
	get_tree().quit()


func _frames(n: int) -> void:
	for i in n:
		await get_tree().process_frame
