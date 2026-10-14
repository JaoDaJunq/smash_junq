class_name CpuControls
extends FighterControls
## Controles virtuais da CPU. A cada quadro o cérebro chama press() para os
## botões que quer segurar; "acabou de apertar" é o que está apertado agora e
## não estava no quadro anterior, como num controle de verdade.

var _now := {}
var _prev := {}


func begin_frame() -> void:
	_prev = _now
	_now = {}


func press(action: String, strength := 1.0) -> void:
	_now[action] = clampf(strength, 0.0, 1.0)


func pressed(action: String) -> bool:
	return _now.has(action)


func just_pressed(action: String) -> bool:
	return _now.has(action) and not _prev.has(action)


func just_released(action: String) -> bool:
	return _prev.has(action) and not _now.has(action)


func axis(negative: String, positive: String) -> float:
	return float(_now.get(positive, 0.0)) - float(_now.get(negative, 0.0))


func horizontal_from_keyboard() -> bool:
	return false
