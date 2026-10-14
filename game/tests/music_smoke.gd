extends Node
## Teste de fumaça da música de fundo (sem janela):
##   godot --headless --path game res://tests/music_smoke.tscn

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	Music.auto_follow_scene = false
	await get_tree().process_frame
	var players: Array[AudioStreamPlayer] = Music._players
	_check("Tocadores usam o barramento Music", players[0].bus == "Music" and players[1].bus == "Music", players[0].bus)
	Music.play("menu")
	await _wait(0.2)
	var p := players[Music._active]
	_check("Menu toca a faixa do menu", p.stream != null and p.stream.resource_path.ends_with("menu_sporty.ogg"), p.stream.resource_path if p.stream else "")
	_check("Faixa repete em loop", p.stream is AudioStreamOggVorbis and (p.stream as AudioStreamOggVorbis).loop, "")
	Music.play("luta")
	await _wait(1.0)
	var q := players[Music._active]
	_check("Luta troca para uma faixa de luta", q.stream != null and "luta_" in q.stream.resource_path, q.stream.resource_path if q.stream else "")
	_check("Troca com fade: a faixa anterior para", not players[1 - Music._active].playing, "")
	_check("Volume da música segue a opção", is_equal_approx(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")), linear_to_db(Settings.music_volume)) or Settings.music_volume == 0.0, "%.1f dB" % AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])
