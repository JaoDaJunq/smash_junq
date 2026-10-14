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
