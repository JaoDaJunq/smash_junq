extends SceneTree
## Escreve no project.godot o mapa de entradas definido no GDD.
## Rodar a partir da pasta game/:
##   godot --headless --script res://tools/configure_input_map.gd
## Pode ser rodado de novo sempre que o mapeamento mudar; ele substitui as ações p1_* e p2_*.

const KEYS := {
	"p1": {
		"left": KEY_A, "right": KEY_D, "up": KEY_W, "down": KEY_S,
		"jump": KEY_SPACE, "attack": KEY_J, "special": KEY_K, "shield": KEY_SHIFT,
		"pause": KEY_ESCAPE,
	},
	"p2": {
		"left": KEY_LEFT, "right": KEY_RIGHT, "up": KEY_UP, "down": KEY_DOWN,
		"jump": KEY_KP_0, "attack": KEY_KP_1, "special": KEY_KP_2, "shield": KEY_KP_3,
		"pause": KEY_KP_ENTER,
	},
}

const PAD_BUTTONS := {
	"left": [JOY_BUTTON_DPAD_LEFT], "right": [JOY_BUTTON_DPAD_RIGHT],
	"up": [JOY_BUTTON_DPAD_UP], "down": [JOY_BUTTON_DPAD_DOWN],
	"jump": [JOY_BUTTON_A], "attack": [JOY_BUTTON_X], "special": [JOY_BUTTON_B],
	"shield": [JOY_BUTTON_RIGHT_SHOULDER, JOY_BUTTON_LEFT_SHOULDER],
	"pause": [JOY_BUTTON_START],
}

# [eixo, direção]
const PAD_AXES := {
	"left": [JOY_AXIS_LEFT_X, -1.0], "right": [JOY_AXIS_LEFT_X, 1.0],
	"up": [JOY_AXIS_LEFT_Y, -1.0], "down": [JOY_AXIS_LEFT_Y, 1.0],
	"grab": [JOY_AXIS_TRIGGER_RIGHT, 1.0],
}

const ACTIONS := ["left", "right", "up", "down", "jump", "attack", "special", "shield", "grab", "pause"]
const STICK_DEADZONE := 0.3


func _init() -> void:
	var device := 0
	for player in ["p1", "p2"]:
		for action in ACTIONS:
			var events: Array[InputEvent] = []
			if KEYS[player].has(action):
				var key := InputEventKey.new()
				key.device = -1  # qualquer teclado, como o editor faz em "All Devices"
				key.physical_keycode = KEYS[player][action]
				events.append(key)
			for button in PAD_BUTTONS.get(action, []):
				var pad := InputEventJoypadButton.new()
				pad.device = device
				pad.button_index = button
				events.append(pad)
			if PAD_AXES.has(action):
				var motion := InputEventJoypadMotion.new()
				motion.device = device
				motion.axis = PAD_AXES[action][0]
				motion.axis_value = PAD_AXES[action][1]
				events.append(motion)
			var deadzone := STICK_DEADZONE if action in ["left", "right", "up", "down"] else 0.5
			ProjectSettings.set_setting("input/%s_%s" % [player, action], {"deadzone": deadzone, "events": events})
		device += 1
	var err := ProjectSettings.save()
	print("Mapa de entradas salvo: ", error_string(err))
	quit(err)
