class_name FighterControls
extends RefCounted
## Entrada de um lutador. Esta versão lê o mapa de entradas do jogador
## (p1_*, p2_*: teclado e gamepad). A CPU usa CpuControls, que tem a mesma
## interface mas recebe os botões escolhidos pelo cérebro da CPU.
## Ações: left, right, up, down, jump, attack, special, shield, grab, pause.

var prefix := "p1"


func _init(player_prefix := "p1") -> void:
	prefix = player_prefix


func action_name(action: String) -> String:
	return "%s_%s" % [prefix, action]


func pressed(action: String) -> bool:
	return Input.is_action_pressed(action_name(action))


func just_pressed(action: String) -> bool:
	return Input.is_action_just_pressed(action_name(action))


func just_released(action: String) -> bool:
	return Input.is_action_just_released(action_name(action))


func axis(negative: String, positive: String) -> float:
	return Input.get_axis(action_name(negative), action_name(positive))


## Direção atual da alavanca (x: esquerda/direita, y: cima negativo, baixo positivo).
func stick() -> Vector2:
	return Vector2(axis("left", "right"), axis("up", "down"))


## true se a direção horizontal vem de tecla física (no teclado não existe
## "alavanca empurrada rápido", então só o toque duplo faz correr).
func horizontal_from_keyboard() -> bool:
	for action in ["left", "right"]:
		for e in InputMap.action_get_events(action_name(action)):
			if e is InputEventKey and Input.is_physical_key_pressed(e.physical_keycode):
				return true
	return false


## Chamado no início de cada quadro do lutador. A versão humana não precisa.
func begin_frame() -> void:
	pass


# --- Fila de entrada (buffer) ---
# Botão apertado pouco antes de o lutador ficar livre não se perde: o toque fica
# guardado por BUFFER_FRAMES quadros e sai no primeiro quadro em que der.
# Cada toque guarda o quadro em que aconteceu, para respeitar a ordem
# (pulo e depois ataque = pulo e depois aéreo).

## Quantos quadros um toque fica guardado.
const BUFFER_FRAMES := 8
## Botões que entram na fila (direções não: elas são lidas na hora).
const BUFFERED_ACTIONS: Array[String] = ["attack", "special", "jump", "grab", "shield"]

var _frame := 0
var _taps: Dictionary = {}   # ação -> quadro do toque ainda não usado
var _prev_down: Dictionary = {}   # ação -> estava apertada no quadro anterior


## Anota os toques deste quadro. Chamar 1x por quadro de física, DEPOIS de a CPU
## escolher os botões (para a CPU, just_pressed só vale depois de think()).
## Toque = botão desceu neste quadro (pressed agora e não no quadro anterior) ou
## just_pressed (toque rapidíssimo, apertou e soltou entre dois quadros). O
## just_pressed de um botão que já estava descido no quadro anterior é ignorado
## (Input.action_press de script só acusa just_pressed um quadro depois).
func record_frame() -> void:
	_frame += 1
	for action in BUFFERED_ACTIONS:
		var down := pressed(action)
		var was_down: bool = _prev_down.get(action, false)
		if not was_down and (down or just_pressed(action)):
			_taps[action] = _frame
		_prev_down[action] = down


## O botão foi tocado há no máximo BUFFER_FRAMES quadros e o toque não foi usado?
func buffered(action: String) -> bool:
	if not _taps.has(action):
		return false
	var age: int = _frame - int(_taps[action])
	if age >= BUFFER_FRAMES:
		_taps.erase(action)
		return false
	return true


## Gasta o toque guardado (o golpe/pulo saiu).
func consume(action: String) -> void:
	_taps.erase(action)


## buffered() + consume(): true se havia toque guardado (e agora foi gasto).
func take(action: String) -> bool:
	if buffered(action):
		consume(action)
		return true
	return false


## Entre as ações dadas, a de toque guardado MAIS ANTIGO ("" se nenhuma).
## Empate (mesmo quadro): vale a ordem da lista.
func oldest(actions: Array) -> String:
	var best := ""
	var best_frame := 0
	for a in actions:
		var action: String = a
		if buffered(action) and (best == "" or int(_taps[action]) < best_frame):
			best = action
			best_frame = int(_taps[action])
	return best


## Esquece todos os toques guardados (ex.: ao ser nocauteado).
func clear_buffer() -> void:
	_taps.clear()
