extends Node
## Autoload "Settings": opções do jogador (volumes, tela cheia, tremor de tela).
## Salva em user://settings.cfg e aplica na hora ao carregar e a cada mudança.
## Deve carregar antes do Sfx, que usa o barramento "SFX" criado aqui.
##   Settings.set_value("master_volume", 0.5)     Settings.screen_shake

signal changed(key: String)

const FILE_PATH := "user://settings.cfg"
const SECTION := "settings"
const BUS_SFX := "SFX"
const BUS_MUSIC := "Music"

const DEFAULTS := {
	"master_volume": 0.8,
	"sfx_volume": 1.0,
	"music_volume": 0.7,
	"fullscreen": false,
	"screen_shake": true,
}

var master_volume: float = DEFAULTS["master_volume"]
var sfx_volume: float = DEFAULTS["sfx_volume"]
var music_volume: float = DEFAULTS["music_volume"]
var fullscreen: bool = DEFAULTS["fullscreen"]
var screen_shake: bool = DEFAULTS["screen_shake"]

## Caminho do arquivo (testes podem apontar para outro arquivo).
var file_path := FILE_PATH


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_ensure_buses()
	load_settings()


## Lê o arquivo (valores ausentes ou inválidos voltam ao padrão) e aplica tudo.
func load_settings() -> void:
	var cfg := ConfigFile.new()
	var ok := cfg.load(file_path) == OK
	for key in DEFAULTS:
		var value: Variant = DEFAULTS[key]
		if ok:
			value = _sanitize(key, cfg.get_value(SECTION, key, DEFAULTS[key]))
		set(key, value)
	apply_all()


func save_settings() -> void:
	var cfg := ConfigFile.new()
	for key in DEFAULTS:
		cfg.set_value(SECTION, key, get(key))
	cfg.save(file_path)


## Muda uma opção, aplica na hora e salva.
func set_value(key: String, value: Variant) -> void:
	if not DEFAULTS.has(key):
		push_warning("Opção desconhecida: " + key)
		return
	set(key, _sanitize(key, value))
	_apply(key)
	save_settings()
	changed.emit(key)


func reset_to_defaults() -> void:
	for key in DEFAULTS:
		set(key, DEFAULTS[key])
	apply_all()
	save_settings()


func apply_all() -> void:
	for key in DEFAULTS:
		_apply(key)


func _sanitize(key: String, value: Variant) -> Variant:
	if DEFAULTS[key] is bool:
		return bool(value) if typeof(value) == TYPE_BOOL else DEFAULTS[key]
	if typeof(value) != TYPE_FLOAT and typeof(value) != TYPE_INT:
		return DEFAULTS[key]
	return clampf(float(value), 0.0, 1.0)


func _apply(key: String) -> void:
	match key:
		"master_volume":
			_set_bus_volume("Master", master_volume)
		"sfx_volume":
			_set_bus_volume(BUS_SFX, sfx_volume)
		"music_volume":
			_set_bus_volume(BUS_MUSIC, music_volume)
		"fullscreen":
			if DisplayServer.get_name() != "headless":
				DisplayServer.window_set_mode(
					DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)


## Os barramentos vêm de default_bus_layout.tres (Master com limitador, SFX,
## Music com compressor sidechain pelo Impacto, Impacto, Voz). Aqui só confere:
## se faltar algum (layout apagado), cria sem efeitos para o jogo não ficar mudo.
## O volume do jogador é sempre o volume do barramento; o sidechain e a abaixada
## da música são efeitos dentro do Music e não mexem nesse volume.
const BUS_SENDS := {"SFX": "Master", "Music": "Master", "Impacto": "SFX", "Voz": "SFX"}


func _ensure_buses() -> void:
	for bus_name in BUS_SENDS:
		if AudioServer.get_bus_index(bus_name) < 0:
			push_warning("Barramento '%s' faltando no default_bus_layout.tres; criando sem efeitos." % bus_name)
			AudioServer.add_bus()
			var index := AudioServer.bus_count - 1
			AudioServer.set_bus_name(index, bus_name)
			AudioServer.set_bus_send(index, BUS_SENDS[bus_name])


func _set_bus_volume(bus_name: String, linear: float) -> void:
	var index := AudioServer.get_bus_index(bus_name)
	if index < 0:
		return
	AudioServer.set_bus_volume_db(index, linear_to_db(linear))
	AudioServer.set_bus_mute(index, linear <= 0.0)
