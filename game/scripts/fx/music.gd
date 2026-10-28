extends Node
## Música de fundo (autoload "Music"). Toca a faixa do menu nas telas de menu e
## uma faixa de luta (sorteada) durante a partida, com troca suave (fade).
## Usa o barramento "Music", cujo volume a tela de Opções controla.
## Faixas em assets/music (SubspaceAudio, CC0), normalizadas a ~-14 LUFS.
## O barramento "Music" tem um compressor sidechain pelo "Impacto" (golpes
## abaixam a música sozinhos) e um Amplify "Abaixada" que duck() usa; nenhum
## dos dois mexe no volume do barramento, que é o volume do jogador.

const TRACKS := {
	"menu": ["res://assets/music/menu_sporty.ogg"],
	"luta": ["res://assets/music/luta_stage_6.ogg", "res://assets/music/luta_stage_9.ogg"],
}
const MATCH_SCENE := "res://scenes/match.tscn"
const FADE := 0.8
## Volume base das faixas (dB); o ajuste fino fica no barramento "Music".
const BASE_DB := -5.0

## Troca a faixa sozinha conforme a cena atual (menu ou partida). Testes desligam.
var auto_follow_scene := true
## Desliga a música (testes, por exemplo).
var muted := false
var current := ""
var _players: Array[AudioStreamPlayer] = []
var _active := 0
var _check := 0.0
var _rng := RandomNumberGenerator.new()
var _duck_tween: Tween


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
	var wanted := "luta" if is_match_running(scene) else "menu"
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


## Há uma partida rodando? Vale para match.tscn como cena principal, para uma
## cena cujo nó raiz é a partida (outra cena com o script do MatchManager) e para
## cenas que montam a partida dentro delas (testes, simulações, treino): basta
## ter lutadores no grupo "fighters".
func is_match_running(scene: Node = null) -> bool:
	if scene == null:
		scene = get_tree().current_scene
	if scene != null and (scene.scene_file_path == MATCH_SCENE or scene is MatchManager):
		return true
	return get_tree().get_first_node_in_group("fighters") != null


## Abaixa a música db decibéis por um instante (golpe que pode matar, KO) e
## volta. Usa o efeito Amplify do barramento Music, não o volume do jogador.
## Não sofre com a câmera lenta (ignora Engine.time_scale).
func duck(db: float, seconds: float) -> void:
	var amp := _duck_effect()
	if amp == null:
		return
	if _duck_tween != null and _duck_tween.is_valid():
		_duck_tween.kill()
	var attack := minf(0.02, seconds * 0.2)
	var release := seconds * 0.4
	_duck_tween = create_tween().set_ignore_time_scale(true)
	_duck_tween.tween_property(amp, "volume_db", -absf(db), attack)
	_duck_tween.tween_interval(maxf(0.0, seconds - attack - release))
	_duck_tween.tween_property(amp, "volume_db", 0.0, release)


## Abaixada atual em dB (0 = normal).
func duck_db() -> float:
	var amp := _duck_effect()
	return amp.volume_db if amp != null else 0.0


func _duck_effect() -> AudioEffectAmplify:
	var bus := AudioServer.get_bus_index("Music")
	if bus < 0:
		return null
	for k in AudioServer.get_bus_effect_count(bus):
		var fx := AudioServer.get_bus_effect(bus, k)
		if fx is AudioEffectAmplify:
			return fx as AudioEffectAmplify
	return null
