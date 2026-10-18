extends Node
## Autoload "Controles": deixa o jogador trocar as teclas, botões do mouse e
## botões do controle de cada ação (p1_* e p2_*). Os padrões vêm do
## project.godot (tools/configure_input_map.gd); as trocas ficam em
## user://controles.cfg e são aplicadas ao abrir o jogo.
##
## Cada ação tem duas "vagas" que podem ser trocadas:
##   "teclado" = tecla ou botão do mouse;  "controle" = botão do gamepad.
## Eixos do analógico continuam os do padrão.

const FILE_PATH := "user://controles.cfg"
const PLAYERS := ["p1", "p2"]
## Ações que aparecem na tela de controles, na ordem, com o nome em português.
const ACTIONS: Array[Array] = [
	["left", "Esquerda"], ["right", "Direita"], ["up", "Cima"], ["down", "Baixo"],
	["jump", "Pular"], ["attack", "Ataque"], ["special", "Especial"],
	["shield", "Defesa / esquiva"], ["grab", "Agarrão"], ["pause", "Pausa"],
]

## Teste: caminho do arquivo (os testes usam outro para não mexer no do jogador).
var file_path := FILE_PATH


func _ready() -> void:
	load_controls()


## Volta ao padrão do projeto e aplica as trocas salvas.
func load_controls() -> void:
	InputMap.load_from_project_settings()
	var cfg := ConfigFile.new()
	if cfg.load(file_path) != OK:
		return
	for p in PLAYERS:
		for a in ACTIONS:
			var action := "%s_%s" % [p, a[0]]
			for slot in ["teclado", "controle"]:
				var key := "%s/%s" % [action, slot]
				if cfg.has_section_key("trocas", key):
					var ev := _decode(cfg.get_value("trocas", key))
					if ev != null:
						_put(action, ev, false)


## Troca a tecla/botão de uma ação. Devolve as outras ações que já usavam esse
## mesmo botão (para avisar o jogador).
func rebind(action: String, ev: InputEvent) -> Array[String]:
	var conflicts: Array[String] = []
	for p in PLAYERS:
		for a in ACTIONS:
			var other := "%s_%s" % [p, a[0]]
			if other != action and _same_button_in(other, ev):
				conflicts.append(other)
	_put(action, ev, true)
	return conflicts


## Apaga as trocas e volta tudo ao padrão.
func reset_to_defaults() -> void:
	DirAccess.remove_absolute(ProjectSettings.globalize_path(file_path))
	InputMap.load_from_project_settings()


## Texto curto do que está ligado a uma ação numa vaga ("teclado" ou "controle").
func describe(action: String, slot := "teclado") -> String:
	var names: Array[String] = []
	for ev in InputMap.action_get_events(action):
		var sl := _slot_of(ev)
		# Gatilhos (ex.: RT do agarrão) aparecem junto do controle; o analógico das
		# direções não (a tabela já diz "Analógico").
		var trigger := sl == "eixo" and not _is_direction(action)
		if sl == slot or (slot == "controle" and trigger):
			names.append(event_name(ev))
	return " / ".join(names) if not names.is_empty() else "—"


## Nome legível de uma tecla, botão do mouse ou botão do controle.
static func event_name(ev: InputEvent) -> String:
	if ev is InputEventKey:
		var k := ev as InputEventKey
		var code := k.physical_keycode if k.physical_keycode != 0 else k.keycode
		var special := {KEY_SPACE: "Espaço", KEY_SHIFT: "Shift", KEY_ENTER: "Enter", KEY_ESCAPE: "Esc",
			KEY_LEFT: "←", KEY_RIGHT: "→", KEY_UP: "↑", KEY_DOWN: "↓", KEY_CTRL: "Ctrl", KEY_ALT: "Alt",
			KEY_TAB: "Tab", KEY_BACKSPACE: "Backspace", KEY_KP_ENTER: "Numpad Enter"}
		if special.has(code):
			return special[code]
		var text := OS.get_keycode_string(DisplayServer.keyboard_get_keycode_from_physical(code) if k.physical_keycode != 0 else code)
		return text.replace("Kp ", "Numpad ")
	if ev is InputEventMouseButton:
		match (ev as InputEventMouseButton).button_index:
			MOUSE_BUTTON_LEFT: return "Mouse esquerdo"
			MOUSE_BUTTON_RIGHT: return "Mouse direito"
			MOUSE_BUTTON_MIDDLE: return "Mouse meio"
			MOUSE_BUTTON_XBUTTON1: return "Mouse lateral 1"
			MOUSE_BUTTON_XBUTTON2: return "Mouse lateral 2"
		return "Mouse %d" % (ev as InputEventMouseButton).button_index
	if ev is InputEventJoypadButton:
		var pad := {JOY_BUTTON_A: "A", JOY_BUTTON_B: "B", JOY_BUTTON_X: "X", JOY_BUTTON_Y: "Y",
			JOY_BUTTON_LEFT_SHOULDER: "LB", JOY_BUTTON_RIGHT_SHOULDER: "RB", JOY_BUTTON_START: "Start",
			JOY_BUTTON_BACK: "Select", JOY_BUTTON_LEFT_STICK: "L3", JOY_BUTTON_RIGHT_STICK: "R3",
			JOY_BUTTON_DPAD_UP: "Direcional ↑", JOY_BUTTON_DPAD_DOWN: "Direcional ↓",
			JOY_BUTTON_DPAD_LEFT: "Direcional ←", JOY_BUTTON_DPAD_RIGHT: "Direcional →"}
		return pad.get((ev as InputEventJoypadButton).button_index, "Botão %d" % (ev as InputEventJoypadButton).button_index)
	if ev is InputEventJoypadMotion:
		match (ev as InputEventJoypadMotion).axis:
			JOY_AXIS_TRIGGER_RIGHT: return "RT"
			JOY_AXIS_TRIGGER_LEFT: return "LT"
		return "Analógico"
	return "?"


## O evento serve para trocar um controle? (tecla, botão do mouse ou do gamepad, apertado)
static func is_bindable(ev: InputEvent) -> bool:
	if ev is InputEventKey:
		return ev.pressed and not (ev as InputEventKey).echo
	if ev is InputEventMouseButton:
		return ev.pressed and (ev as InputEventMouseButton).button_index not in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN, MOUSE_BUTTON_WHEEL_LEFT, MOUSE_BUTTON_WHEEL_RIGHT]
	if ev is InputEventJoypadButton:
		return ev.pressed
	return false


# --- Interno ---

func _is_direction(action: String) -> bool:
	for d in ["_left", "_right", "_up", "_down"]:
		if action.ends_with(d):
			return true
	return false


func _slot_of(ev: InputEvent) -> String:
	if ev is InputEventKey or ev is InputEventMouseButton:
		return "teclado"
	if ev is InputEventJoypadButton:
		return "controle"
	if ev is InputEventJoypadMotion:
		return "eixo"  # analógico e gatilhos: não são trocados pela tela
	return ""


## Põe o evento na vaga dele, tirando o que estava na mesma vaga.
func _put(action: String, ev: InputEvent, save: bool) -> void:
	var slot := _slot_of(ev)
	var clean := _clean_copy(ev, action)
	for old in InputMap.action_get_events(action):
		if _slot_of(old) == slot:
			InputMap.action_erase_event(action, old)
	InputMap.action_add_event(action, clean)
	if save:
		var cfg := ConfigFile.new()
		cfg.load(file_path)
		cfg.set_value("trocas", "%s/%s" % [action, slot], _encode(clean))
		cfg.save(file_path)


func _clean_copy(ev: InputEvent, action: String) -> InputEvent:
	if ev is InputEventKey:
		var k := InputEventKey.new()
		k.device = -1
		k.physical_keycode = (ev as InputEventKey).physical_keycode if (ev as InputEventKey).physical_keycode != 0 else (ev as InputEventKey).keycode
		return k
	if ev is InputEventMouseButton:
		var m := InputEventMouseButton.new()
		m.device = -1
		m.button_index = (ev as InputEventMouseButton).button_index
		return m
	var j := InputEventJoypadButton.new()
	j.button_index = (ev as InputEventJoypadButton).button_index
	j.device = 0 if action.begins_with("p1") else 1  # um controle por jogador
	return j


func _same_button_in(action: String, ev: InputEvent) -> bool:
	var probe := _clean_copy(ev, action)
	for old in InputMap.action_get_events(action):
		if old.get_class() != probe.get_class():
			continue
		if probe is InputEventKey and (old as InputEventKey).physical_keycode == (probe as InputEventKey).physical_keycode:
			return true
		if probe is InputEventMouseButton and (old as InputEventMouseButton).button_index == (probe as InputEventMouseButton).button_index:
			return true
		if probe is InputEventJoypadButton and (old as InputEventJoypadButton).button_index == (probe as InputEventJoypadButton).button_index \
				and old.device == probe.device:
			return true
	return false


func _encode(ev: InputEvent) -> Dictionary:
	if ev is InputEventKey:
		return {"tipo": "tecla", "codigo": (ev as InputEventKey).physical_keycode}
	if ev is InputEventMouseButton:
		return {"tipo": "mouse", "codigo": (ev as InputEventMouseButton).button_index}
	return {"tipo": "controle", "codigo": (ev as InputEventJoypadButton).button_index, "aparelho": ev.device}


func _decode(d: Variant) -> InputEvent:
	if typeof(d) != TYPE_DICTIONARY:
		return null
	match String(d.get("tipo", "")):
		"tecla":
			var k := InputEventKey.new()
			k.physical_keycode = int(d["codigo"])
			return k
		"mouse":
			var m := InputEventMouseButton.new()
			m.button_index = int(d["codigo"])
			return m
		"controle":
			var j := InputEventJoypadButton.new()
			j.button_index = int(d["codigo"])
			j.device = int(d.get("aparelho", 0))
			return j
	return null
