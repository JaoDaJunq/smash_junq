class_name DummyBrain
extends CpuBrain
## Boneco do modo treino. Fica parado, pula, segura escudo ou luta como a CPU.
## Em qualquer comportamento, volta para a arena quando é lançado para fora.

enum Behavior { STAND, JUMP, SHIELD, CPU }
const BEHAVIOR_NAMES := ["Parado", "Pulando", "Escudo", "CPU"]

var behavior := Behavior.STAND
var _tick := 0


func think(me: Fighter, delta: float) -> void:
	if behavior == Behavior.CPU:
		super.think(me, delta)
		return
	var c := me.controls as CpuControls
	if c == null:
		return
	_tick += 1
	match me.state:
		Fighter.State.HITSTUN, Fighter.State.SHIELD_BREAK, Fighter.State.HELD, Fighter.State.RESPAWN:
			return
		Fighter.State.LEDGE:
			if _tick % 30 == 0:
				c.press("up")
			return
	if _offstage(me):
		_recover(me, c)
		return
	match behavior:
		Behavior.JUMP:
			if me.is_on_floor() and _tick % 45 == 0:
				c.press("jump")
		Behavior.SHIELD:
			if me.is_on_floor():
				c.press("shield")
