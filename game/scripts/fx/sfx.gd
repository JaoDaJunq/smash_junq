extends Node
## Sons do jogo (autoload "Sfx"). Toca efeitos por nome de evento, com leve
## variação de tom para não cansar o ouvido. Arquivos em assets/sfx: golpes,
## escudo, KO e menu são sintetizados pelo projeto (tools/sintese_golpes.py);
## pulo, pouso, corrida e contagem são Kenney (CC0).
##   Sfx.play("hit_heavy")      Sfx.play("ui_move", -6.0)
##   Sfx.play_hit(data, launch_speed, heavy)   # golpe: volume e tom pelo dano
## Golpes, KO e assinaturas saem no barramento "Impacto" (filho do SFX), que
## também comanda o compressor sidechain da música (default_bus_layout.tres).

## Evento -> lista de arquivos (um é sorteado a cada vez, sem repetir o anterior).
const SOUNDS := {
	"hit_light": ["golpe_leve_1", "golpe_leve_2", "golpe_leve_3"],
	"hit_medium": ["golpe_medio_1", "golpe_medio_2", "golpe_medio_3"],
	"hit_heavy": ["golpe_forte_1", "golpe_forte_2", "golpe_forte_3"],
	"jump": ["impactSoft_medium_000", "impactSoft_medium_001"],
	"land": ["impactSoft_heavy_000"],
	"dash": ["footstep_concrete_000", "footstep_concrete_001"],
	"shield_hit": ["escudo_bolha"],
	"shield_break": ["escudo_quebra"],
	"ko": ["golpe_ko_1", "golpe_ko_2", "golpe_ko_3"],
	"ko_ring": ["impactBell_heavy_000"],
	"ui_move": ["menu_mover"],
	"ui_confirm": ["menu_confirmar"],
	"ui_back": ["menu_voltar"],
	"countdown": ["tick_001"],
	"fight": ["confirmation_004"],
	"match_end": ["bong_001"],
	"assinatura_berimbau": ["assinatura_berimbau"],
	"assinatura_apito": ["assinatura_apito"],
	"assinatura_pandeiro": ["assinatura_pandeiro"],
}
## Volume base por evento (dB).
const VOLUME := {"hit_light": -4.0, "hit_medium": -2.0, "hit_heavy": 0.0, "jump": -14.0, "land": -12.0,
	"dash": -14.0, "shield_hit": -9.0, "shield_break": -6.0, "ko": -3.0, "ko_ring": -9.0, "ui_move": -10.0,
	"ui_confirm": -10.0, "ui_back": -8.0, "countdown": -4.0, "fight": -2.0, "match_end": -2.0,
	"assinatura_berimbau": 0.0, "assinatura_apito": 0.0, "assinatura_pandeiro": 0.0}
## Eventos que saem no barramento "Impacto" (e por isso abaixam a música).
const IMPACT_EVENTS := ["hit_light", "hit_medium", "hit_heavy", "ko",
	"assinatura_berimbau", "assinatura_apito", "assinatura_pandeiro"]
const VOICES := 12
const IMPACT_VOICES := 8
const BUS_SFX := "SFX"
const BUS_IMPACT := "Impacto"

## Golpe: faixa de dano que vai do som mais agudo/baixo ao mais grave/alto.
const HIT_DAMAGE_MIN := 2.0
const HIT_DAMAGE_MAX := 18.0
## Volume extra (dB) no dano mínimo e no máximo (~6 dB de diferença).
const HIT_VOL_RANGE := Vector2(-3.0, 3.0)
## Tom no dano mínimo e no máximo.
const HIT_PITCH_RANGE := Vector2(1.08, 0.90)
## Variação leve de tom (±) para golpes iguais não soarem idênticos.
const HIT_PITCH_JITTER := 0.025
## Dano a partir do qual o golpe usa o som médio / forte.
const MEDIUM_DAMAGE := 6.0
const HEAVY_DAMAGE := 10.0
## Lançamento (px/s) a partir do qual o golpe pode matar: a música abaixa.
const KILL_LAUNCH := 1500.0
## Abaixada da música no golpe que pode matar e no KO.
const DUCK_DB := 6.0
const DUCK_SECONDS := 0.25
## A assinatura do personagem toca este tanto abaixo do golpe.
const SIGNATURE_DB := -4.0

## Desliga todos os sons (útil em testes).
var muted := false
## O que o último play_hit decidiu (para testes).
var last_hit_event := ""
var last_hit_volume_db := 0.0
var last_hit_pitch := 1.0
var last_signature := ""
var last_hit_ducked := false
var _streams := {}
var _last_index := {}
var _players: Array[AudioStreamPlayer] = []
var _impact_players: Array[AudioStreamPlayer] = []
var _next := 0
var _next_impact := 0
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
		if AudioServer.get_bus_index(BUS_SFX) >= 0:
			p.bus = BUS_SFX  # volume de efeitos do jogador
		add_child(p)
		_players.append(p)
	# Vozes dos golpes num nó à parte, no barramento Impacto (sidechain da música).
	var holder := Node.new()
	holder.name = "Impacto"
	add_child(holder)
	for i in IMPACT_VOICES:
		var p := AudioStreamPlayer.new()
		if AudioServer.get_bus_index(BUS_IMPACT) >= 0:
			p.bus = BUS_IMPACT
		elif AudioServer.get_bus_index(BUS_SFX) >= 0:
			p.bus = BUS_SFX
		holder.add_child(p)
		_impact_players.append(p)


## Toca um evento. volume_db soma ao volume base; pitch_spread varia o tom (±).
func play(event: String, volume_db := 0.0, pitch_spread := 0.06) -> void:
	_play(event, float(VOLUME.get(event, 0.0)) + volume_db,
		1.0 + _rng.randf_range(-pitch_spread, pitch_spread))


## Som de golpe que acertou: escolhe leve/médio/forte pelo dano (ou forte se o
## lançamento é forte), deixa mais alto e mais grave quanto maior o dano, toca a
## assinatura do personagem nos golpes fortes/especiais e abaixa a música se o
## golpe pode matar. Chamar no mesmo quadro do acerto (começo da pausa de impacto):
## o som não espera a pausa acabar.
func play_hit(data: AttackData, launch_speed: float, heavy := false) -> void:
	var damage := data.damage if data != null else 3.0
	var event := "hit_light"
	if heavy or damage >= HEAVY_DAMAGE:
		event = "hit_heavy"
	elif damage >= MEDIUM_DAMAGE:
		event = "hit_medium"
	var t := clampf((damage - HIT_DAMAGE_MIN) / (HIT_DAMAGE_MAX - HIT_DAMAGE_MIN), 0.0, 1.0)
	var vol := float(VOLUME[event]) + lerpf(HIT_VOL_RANGE.x, HIT_VOL_RANGE.y, t)
	var pitch := lerpf(HIT_PITCH_RANGE.x, HIT_PITCH_RANGE.y, t) \
		* (1.0 + _rng.randf_range(-HIT_PITCH_JITTER, HIT_PITCH_JITTER))
	last_hit_event = event
	last_hit_volume_db = vol
	last_hit_pitch = pitch
	last_signature = ""
	last_hit_ducked = launch_speed >= KILL_LAUNCH
	_play(event, vol, pitch)
	var signature := signature_for(data)
	if signature != "" and (event == "hit_heavy" or data.id.begins_with("special")):
		last_signature = signature
		_play(signature, vol + SIGNATURE_DB, 1.0 + _rng.randf_range(-0.02, 0.02))
	if last_hit_ducked:
		_duck_music()


## Nome do som de assinatura do golpe ("" se não tem ou se o som não existe).
func signature_for(data: AttackData) -> String:
	if data == null:
		return ""
	var value: Variant = data.get("signature_layer")
	var sig := str(value) if value != null else ""
	return sig if sig != "" and _streams.has(sig) else ""


func _play(event: String, volume_db: float, pitch: float) -> void:
	if muted or not _streams.has(event):
		return
	var list: Array = _streams[event]
	if list.is_empty():
		return
	var p: AudioStreamPlayer
	if event in IMPACT_EVENTS:
		p = _impact_players[_next_impact]
		_next_impact = (_next_impact + 1) % _impact_players.size()
	else:
		p = _players[_next]
		_next = (_next + 1) % _players.size()
	p.stream = list[_pick(event, list.size())]
	p.volume_db = volume_db
	p.pitch_scale = pitch
	p.play()
	if event == "ko":
		_duck_music()


## Sorteia um índice sem repetir o último deste evento.
func _pick(event: String, size: int) -> int:
	var last: int = _last_index.get(event, -1)
	var i := _rng.randi() % size
	if size > 1 and i == last:
		i = (i + 1 + _rng.randi() % (size - 1)) % size
	_last_index[event] = i
	return i


func _duck_music() -> void:
	var music := get_node_or_null("/root/Music")
	if music != null and music.has_method("duck"):
		music.duck(DUCK_DB, DUCK_SECONDS)
