extends Node
## Autoload "Hits": resolve os acertos corpo a corpo no FIM do quadro de física.
## Sem isto, quando os dois lutadores acertam no mesmo quadro, só quem vem antes
## na árvore aplica o golpe (o outro já está atordoado quando chega a vez dele).
## Aqui cada golpe é só anotado (queue) e todos são aplicados juntos depois que
## todos os lutadores andaram: troca justa, os dois tomam o dano.
## Projéteis e golpes especiais que chamam receive_hit direto não passam por aqui.


class Pending:
	var attacker: Fighter
	var target: Fighter
	var data: AttackData
	var dir: int
	var move_id: String


var _queue: Array[Pending] = []


func _ready() -> void:
	# Depois de todos os lutadores (prioridade padrão 0).
	process_physics_priority = 100
	process_mode = Node.PROCESS_MODE_PAUSABLE


## Anota um acerto para aplicar no fim deste quadro.
func queue(attacker: Fighter, target: Fighter, data: AttackData, dir: int, move_id: String) -> void:
	var p := Pending.new()
	p.attacker = attacker
	p.target = target
	p.data = data
	p.dir = dir
	p.move_id = move_id
	_queue.append(p)


## Quantos acertos esperam o fim do quadro (para testes).
func pending_count() -> int:
	return _queue.size()


func _physics_process(_delta: float) -> void:
	flush()


## Aplica todos os acertos anotados (na ordem em que chegaram).
func flush() -> void:
	if _queue.is_empty():
		return
	var batch := _queue
	_queue = []
	for p in batch:
		if not is_instance_valid(p.attacker) or not is_instance_valid(p.target) or p.data == null:
			continue
		if p.target.receive_hit(p.attacker, p.data, p.dir):
			p.attacker._on_hit_landed(p.target, p.move_id)
			if p.attacker.move_fx != null:
				p.attacker.move_fx.on_hit_landed(p.target, p.move_id)
