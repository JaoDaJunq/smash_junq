extends Node
## Ferramenta de captura da arena: instancia a cena principal, posiciona a câmera em
## alguns enquadramentos e salva PNGs em evidence/etapa-3/. Rodar com a janela fora da tela:
##   godot --path game --position -10000,-10000 res://scenes/arena/arena_screenshot.tscn

const OUT_REL := "../evidence/etapa-3/"
# Enquadramentos: nome, posição da câmera, zoom.
const SHOTS := [
	["arena-zoom1", Vector2(0, -150), 1.0],
	["arena-zoom05", Vector2(0, -150), 0.5],
	["arena-lado", Vector2(520, -60), 0.75],
	["arena-queda", Vector2(-200, 380), 0.45],
]


func _ready() -> void:
	get_window().size = Vector2i(1920, 1080)
	var main: Node = load("res://scenes/main.tscn").instantiate()
	add_child(main)
	var out_dir := ProjectSettings.globalize_path("res://").path_join(OUT_REL).simplify_path()
	DirAccess.make_dir_recursive_absolute(out_dir)
	for i in 100:
		await get_tree().process_frame
	var cam := main.get_node("Camera") as Camera2D
	cam.set_process(false)
	for shot in SHOTS:
		cam.global_position = shot[1]
		cam.zoom = Vector2(shot[2], shot[2])
		cam.offset = Vector2.ZERO
		for i in 20:
			await get_tree().process_frame
		var img := get_viewport().get_texture().get_image()
		var path: String = out_dir.path_join(shot[0] + ".png")
		img.save_png(path)
		print("salvo: ", path, " ", img.get_size())
	get_tree().quit()
