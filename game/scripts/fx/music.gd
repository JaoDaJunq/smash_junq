extends Node
## Música de fundo (autoload "Music"). Toca a faixa do menu nas telas de menu e
## uma faixa de luta (sorteada) durante a partida, com troca suave (fade).
## Usa o barramento "Music", cujo volume a tela de Opções controla.
## Faixas em assets/music (SubspaceAudio, CC0).

const TRACKS := {
	"menu": ["res://assets/music/menu_sporty.ogg"],
	"luta": ["res://assets/music/luta_stage_6.ogg", "res://assets/music/luta_stage_9.ogg"],
}
const MATCH_SCENE := "res://scenes/match.tscn"
const FADE := 0.8
## Volume base das faixas (dB); o ajuste fino fica no barramento "Music".
const BASE_DB := -8.0

## Troca a faixa sozinha conforme a cena atual (menu ou partida). Testes desligam.
var auto_follow_scene := true
## Desliga a música (testes, por exemplo).
var muted := false
var current := ""
var _players: Array[AudioStreamPlayer] = []
var _active := 0
var _check := 0.0
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # segue tocando na pausa
	_rng.randomize()
	for i in 2:
		var p := AudioStreamPlayer.new()
		if AudioServer.get_bus_index("Music") >= 0:
			p.bus = "Music"
		p.volume_db = -80.0
		add_child(p)
		_players.append(p)


func _process(delta: float) -> void:
	if not auto_follow_scene:
		return
	_check -= delta
	if _check > 0.0:
		return
	_check = 0.25
	var scene := get_tree().current_scene
	if scene == null:
		return
	var wanted := "luta" if scene.scene_file_path == MATCH_SCENE else "menu"
	if wanted != current:
		play(wanted)


## Troca para a faixa do grupo ("menu" ou "luta"), com fade.
func play(group: String) -> void:
	current = group
	if muted or not TRACKS.has(group):
		return
	var list: Array = TRACKS[group]
	var stream := load(list[_rng.randi() % list.size()]) as AudioStream
	if stream == null:
		return
	if stream is AudioStreamOggVorbis:
		(stream as AudioStreamOggVorbis).loop = true
	var old := _players[_active]
	_active = 1 - _active
	var new := _players[_active]
	new.stream = stream
	new.volume_db = -40.0
	new.play()
	var tw := create_tween().set_parallel(true)
	tw.tween_property(new, "volume_db", BASE_DB, FADE)
	if old.playing:
		tw.tween_property(old, "volume_db", -60.0, FADE)
		tw.chain().tween_callback(old.stop)


func stop() -> void:
	current = ""
	for p in _players:
		p.stop()


## Para a música por um instante (Paradinha da bateria da Dona Canga) e volta.
func paradinha(seconds: float) -> void:
	for p in _players:
		p.stream_paused = true
	await get_tree().create_timer(seconds, true, false, true).timeout
	for p in _players:
		p.stream_paused = false
