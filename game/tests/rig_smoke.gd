extends Node
## Teste de fumaça dos bonecos de recorte (sem janela):
##   godot --headless --path game res://tests/rig_smoke.tscn

const MAIN := preload("res://scenes/main.tscn")

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	var main := MAIN.instantiate()
	add_child(main)
	var p1: Fighter = main.get_node("P1")
	var p2: Fighter = main.get_node("P2")
	await _frames(30)
	for f in [p1, p2]:
		var rig: CutoutRig = f.get_node_or_null("Rig") as CutoutRig
		var tag: String = f.display_name
		_check("%s tem boneco montado" % tag, rig != null and rig._sprites.size() >= 10, str(rig._sprites.size() if rig else 0))
		_check("%s esconde o retângulo greybox" % tag, f.has_art, "")
		var all_tex := true
		for s in rig._sprites.values():
			all_tex = all_tex and (s as Sprite2D).texture != null
		_check("%s: todas as partes têm textura" % tag, all_tex, "")
	# Pose muda com o estado: golpe para frente mexe o braço/perna da frente
	p1.global_position = Vector2(-200, -56)
	p1.velocity = Vector2.ZERO
	await _frames(20)
	var rig1 := p1.get_node("Rig") as CutoutRig
	var idle := _snapshot(rig1)
	p1.start_attack("ftilt")
	for i in p1.attack.startup + 2:
		await get_tree().physics_frame
	await get_tree().process_frame
	var attacking := _snapshot(rig1)
	_check("Golpe muda a pose do boneco", _changed(idle, attacking) > 2, "%d partes mexeram" % _changed(idle, attacking))
	await _frames(40)
	# Espelha ao virar
	p1.facing = -1
	await get_tree().process_frame
	await get_tree().process_frame  # o sinal vem antes do _process dos nós
	_check("Boneco espelha ao virar de lado", rig1.transform.determinant() < 0.0, "determinante %.4f" % rig1.transform.determinant())
	p1.facing = 1
	# Pés perto do chão na pose neutra (o canela mais baixo perto de y=+55 do lutador)
	var p2rig := p2.get_node("Rig") as CutoutRig
	var lowest := -INF
	for s in p2rig._sprites.values():
		var sp := s as Sprite2D
		var size := sp.region_rect.size if sp.region_enabled else sp.texture.get_size()
		for corner in [Vector2(0, size.y), size]:
			lowest = maxf(lowest, (p2rig.transform * sp.transform * corner).y)
	_check("Pés do %s perto do chão" % p2.display_name, absf(lowest - 55.0) < 14.0, "parte mais baixa em y=%.1f (chão em 55)" % lowest)
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _snapshot(rig: CutoutRig) -> Dictionary:
	var out := {}
	for name in rig._sprites:
		out[name] = (rig._sprites[name] as Sprite2D).transform
	return out


func _changed(a: Dictionary, b: Dictionary) -> int:
	var n := 0
	for k in a:
		if not (a[k] as Transform2D).is_equal_approx(b[k]):
			n += 1
	return n


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
