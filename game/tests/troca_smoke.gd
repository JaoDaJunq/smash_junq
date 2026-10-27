extends Node
## Teste de fumaça da troca justa (autoload Hits): acertos do mesmo quadro são
## aplicados juntos no fim do quadro, então os dois lutadores tomam o golpe.
##   godot --headless --path game res://tests/troca_smoke.tscn

const MAIN := preload("res://scenes/main.tscn")

var results: Array[String] = []
var failures := 0
var p1: Fighter
var p2: Fighter


func _ready() -> void:
	var main := MAIN.instantiate()
	add_child(main)
	p1 = main.get_node("P1")
	p2 = main.get_node("P2")
	await _frames(30)
	await _jab_trade()
	await _grab_vs_hit()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


## Os dois dão jab no mesmo quadro (mesmo golpe, mesma distância): os dois tomam.
func _jab_trade() -> void:
	var keep := p2.moveset
	p2.moveset = p1.moveset   # mesmo jab nos dois: ficam ativos no mesmo quadro
	await _face_off(60.0)
	p1.start_attack("jab")
	p2.start_attack("jab")
	await _frames(20)
	_check("Jab dos dois no mesmo quadro: os dois tomam dano", p1.damage_percent > 0.0 and p2.damage_percent > 0.0,
		"P1 %.1f%%, P2 %.1f%%" % [p1.damage_percent, p2.damage_percent])
	_check("Fila de acertos vazia no fim do quadro", Hits.pending_count() == 0, str(Hits.pending_count()))
	p2.moveset = keep
	await _frames(40)


## P1 (antes na árvore) dá jab no mesmo quadro em que o agarrão do P2 conecta:
## o golpe entra no P2 e o agarrão solta o P1.
func _grab_vs_hit() -> void:
	await _face_off(60.0)
	var fa := 1
	while not p1.moveset.jab.is_active(fa):
		fa += 1
	var fg := p2.grab_startup + 1   # quadro em que o agarrão procura o alvo
	p2.start_grab()
	await _frames(fg - fa)
	p1.start_attack("jab")
	await _frames(fa)
	# Neste ponto o quadro da coincidência acabou de rodar.
	var p1_attack := p1.attack_id
	await _frames(2)
	_check("Agarrão conectou no mesmo quadro do golpe (o jab do P1 foi cortado)", p1_attack == "", "golpe do P1: '%s'" % p1_attack)
	_check("Golpe do mesmo quadro entra no agarrador", p2.damage_percent > 0.0, "P2 %.1f%%" % p2.damage_percent)
	_check("Agarrão solta quando o agarrador toma golpe no mesmo quadro",
		p2.holding == null and p1.held_by == null and p1.state != Fighter.State.HELD,
		"P2 segurando=%s, P1 estado=%s" % [p2.holding, Fighter.State.keys()[p1.state]])
	await _frames(30)


func _face_off(gap: float) -> void:
	for f in [p1, p2]:
		var fi := f as Fighter
		fi.release_hold()
		fi.release_held()
		fi.attack = null
		fi.attack_id = ""
		fi.velocity = Vector2.ZERO
		fi._hitstop = 0
		fi._hitstun = 0.0
		fi.state = Fighter.State.IDLE
	p1.global_position = Vector2(-gap * 0.5, -56)
	p2.global_position = Vector2(gap * 0.5, -56)
	p1.facing = 1
	p2.facing = -1
	await _frames(15)
	p1.damage_percent = 0.0
	p2.damage_percent = 0.0


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
