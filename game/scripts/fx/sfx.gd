extends Node
## Sons do jogo (autoload "Sfx"). Toca efeitos por nome de evento, com leve
## variação de tom para não cansar o ouvido. Arquivos em assets/sfx (Kenney, CC0).
##   Sfx.play("hit_heavy")      Sfx.play("ui_move", -6.0)

## Evento -> lista de arquivos (um é sorteado a cada vez).
const SOUNDS := {
	"hit_light": ["impactPunch_medium_000", "impactPunch_medium_001", "impactPunch_medium_002"],
	"hit_heavy": ["impactPunch_heavy_000", "impactPunch_heavy_001", "impactPunch_heavy_002"],
	"jump": ["impactSoft_medium_000", "impactSoft_medium_001"],
	"land": ["impactSoft_heavy_000"],
	"dash": ["footstep_concrete_000", "footstep_concrete_001"],
	"shield_hit": ["impactMetal_light_000", "impactMetal_light_001"],
	"shield_break": ["impactGlass_heavy_000"],
	"ko": ["impactPlate_heavy_000"],
	"ko_ring": ["impactBell_heavy_000"],
	"ui_move": ["select_001", "select_002"],
	"ui_confirm": ["confirmation_001"],
	"ui_back": ["back_001"],
	"countdown": ["tick_001"],
	"fight": ["confirmation_004"],
	"match_end": ["bong_001"],
}
## Volume base por evento (dB).
const VOLUME := {"hit_light": -4.0, "hit_heavy": 0.0, "jump": -14.0, "land": -12.0, "dash": -14.0,
	"shield_hit": -6.0, "shield_break": -2.0, "ko": 0.0, "ko_ring": -6.0, "ui_move": -10.0,
	"ui_confirm": -6.0, "ui_back": -8.0, "countdown": -4.0, "fight": -2.0, "match_end": -2.0}
const VOICES := 12

## Desliga todos os sons (útil em testes).
var muted := false
var _streams := {}
var _players: Array[AudioStreamPlayer] = []
var _next := 0
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # menus de pausa também têm som
	_rng.randomize()
	for event in SOUNDS:
		var list: Array[AudioStream] = []
		for file in SOUNDS[event]:
			var stream := load("res://assets/sfx/%s.ogg" % file) as AudioStream
			if stream != null:
				list.append(stream)
		_streams[event] = list
	for i in VOICES:
		var p := AudioStreamPlayer.new()
		if AudioServer.get_bus_index("SFX") >= 0:
			p.bus = "SFX"  # barramento criado pelo Settings (volume de efeitos)
		add_child(p)
		_players.append(p)


## Toca um evento. volume_db soma ao volume base; pitch_spread varia o tom (±).
func play(event: String, volume_db := 0.0, pitch_spread := 0.06) -> void:
	if muted or not _streams.has(event):
		return
	var list: Array = _streams[event]
	if list.is_empty():
		return
	var p := _players[_next]
	_next = (_next + 1) % _players.size()
	p.stream = list[_rng.randi() % list.size()]
	p.volume_db = float(VOLUME.get(event, 0.0)) + volume_db
	p.pitch_scale = 1.0 + _rng.randf_range(-pitch_spread, pitch_spread)
	p.play()
