extends Node
## Teste de fumaça do Preguinho (macaco-prego faz-tudo, rodada 11): golpes básicos acertam,
## caixa de ferramentas (troca e efeito nos 3 golpes fortes) e cada especial
## (coco quebrado, escada dobrável, prego).
##   godot --headless --path game res://tests/macaco_prego_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const ID := "macaco_prego"

var results: Array[String] = []
var failures := 0
var me: Fighter
var foe: Fighter
var _match: Node
var _hits: Array[AttackData] = []


func _ready() -> void:
	Game.suppress_scene_changes = true
	Game.mode = "training"
	Game.arena_index = 0
	var idx := -1
	for i in Game.CHARACTERS.size():
		if Game.CHARACTERS[i].get("id", "") == ID:
			idx = i
	_check("%s está no elenco" % ID, idx >= 0, str(idx))
	if idx >= 0 and Game.character_ready(idx):
		_check("roster aponta para o Preguinho", Roster.slot(Roster.cell_of(idx))["name"] == "Preguinho", str(Roster.cell_of(idx)))
		Game.set_character("p1", idx)
		Game.set_character("p2", 0)
		_match = MATCH.instantiate()
		add_child(_match)
		await _frames(240)
		for f in _match.find_children("*", "Fighter", true, false):
			if f.player_id == "p1":
				me = f
			else:
				foe = f
		foe.hit_taken.connect(func(_a: Node2D, d: AttackData, _l: Vector2) -> void:
			_hits.append(d))
		_check("Preguinho com arte", me.has_art, "")
		await _basics()
		await _ferramentas()
		await _coco()
		await _escada()
		await _prego()
	else:
		results.append("[PULADO] sprites ainda não importados")
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _basics() -> void:
	for mv in ["jab", "ftilt", "utilt", "dtilt"]:
		await _face_off()
		if mv == "utilt":
			foe.global_position.x = me.global_position.x + 6.0
		me.start_attack(mv)
		await _frames(50)
		_check("%s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for mv in ["nair", "fair", "bair", "uair", "dair"]:
		await _face_off()
		await _place(me, Vector2(-200, -140), 1)
		await _place(foe, Vector2(-200 + (-60 if mv == "bair" else 60), -140), 1)
		if mv == "uair":
			foe.global_position = me.global_position + Vector2(4, -60)
		elif mv == "dair":
			foe.global_position = me.global_position + Vector2(0, 66)
		foe.velocity = Vector2.ZERO
		me.start_attack(mv)
		await _frames(26)
		_check("%s acerta" % mv, foe.damage_percent > 0.0, "%.1f%%" % foe.damage_percent)
	for kind in ["neutral", "side", "up", "down"]:
		await _face_off()
		me.start_special(kind)
		await _frames(120)
		_check("especial %s roda sem travar" % kind, me.state != Fighter.State.ATTACK, Fighter.State.keys()[me.state])
		await _place(me, Vector2(-200, -60), 1)
		await _frames(60)


## Caixa de ferramentas: o especial neutro troca; cada ferramenta muda os golpes fortes.
func _ferramentas() -> void:
	var p := me as Preguinho
	p.tool = Preguinho.MARTELO
	await _face_off(400.0)
	var seq: Array[int] = []
	for i in 3:
		me.start_special("neutral")
		await _frames(30)
		seq.append(p.tool)
	_check("Troca: martelo → chave → furadeira → martelo", seq == [1, 2, 0], str(seq))
	_check("Troca: sem dano", foe.damage_percent == 0.0 and me.damage_percent == 0.0, "")
	# dano e início de cada ferramenta no forte para a frente
	var dmg := {}
	var start := {}
	for t in 3:
		p.tool = t
		await _face_off(70.0)
		me.start_attack("ftilt")
		start[t] = me.attack.startup
		await _frames(60)
		dmg[t] = foe.damage_percent
	_check("Martelo: mais forte e lento que a chave", dmg[0] > dmg[1] * 1.4 and start[0] >= start[1] + 3, "dano %.1f x %.1f, início %d x %d" % [dmg[0], dmg[1], start[0], start[1]])
	_check("Furadeira: dano total parecido, em vários acertos", dmg[2] > 5.0 and dmg[2] < dmg[0], "%.1f%%" % dmg[2])
	# alcance: a chave chega onde o martelo não chega
	var reach := {}
	for t in [0, 1]:
		p.tool = t
		await _face_off(160.0)
		me.start_attack("ftilt")
		await _frames(50)
		reach[t] = foe.damage_percent
	_check("Chave: alcança quem o martelo não alcança", reach[1] > 0.0 and reach[0] == 0.0, "chave %.1f%% martelo %.1f%%" % [reach[1], reach[0]])
	# furadeira: 4 acertos no total, o último lança
	for mv in ["ftilt", "utilt", "dtilt"]:
		p.tool = Preguinho.FURADEIRA
		await _face_off(64.0)
		if mv == "utilt":
			foe.global_position.x = me.global_position.x + 6.0
		_hits.clear()
		me.start_attack(mv)
		await _frames(70)
		_check("Furadeira (%s): 4 acertos, o último é o mais forte" % mv, _hits.size() == 4 and _hits[-1].base_knockback > _hits[0].base_knockback * 1.5,
			"%d acertos" % _hits.size())
	# o ícone mostra a ferramenta
	_check("Ícone das ferramentas carregado", p._icons != null, "")
	p.tool = Preguinho.MARTELO


## Coco quebrado: arco, quebra em 2 pedaços ao bater no chão, pedaços rolam e acertam.
func _coco() -> void:
	await _face_off(500.0)
	await _place(foe, Vector2(2000, -3000), -1)
	me.start_special("side")
	var coco: Node2D = null
	for i in 30:
		await _frames(1)
		var ps := _projectiles(me)
		if not ps.is_empty():
			coco = ps[0]
			break
	_check("Coco: sai o coquinho", coco != null, "")
	var peak := coco.global_position.y if coco != null else 0.0
	var land_x := 0.0
	var pieces := []
	for i in 120:
		await _frames(1)
		if coco != null and is_instance_valid(coco):
			peak = minf(peak, coco.global_position.y)
			land_x = coco.global_position.x
		else:
			pieces = _projectiles(me)
			if not pieces.is_empty():
				break
	_check("Coco: voa em arco (sobe e desce)", peak < me.global_position.y - 60.0, "subiu %.0f px" % (me.global_position.y - peak))
	_check("Coco: quebra em 2 pedaços ao bater no chão", pieces.size() == 2, str(pieces.size()))
	if pieces.size() == 2:
		_check("Coco: os pedaços rolam para lados opostos", pieces[0].velocity.x * pieces[1].velocity.x < 0.0, "%.0f / %.0f" % [pieces[0].velocity.x, pieces[1].velocity.x])
	# pedaço acerta quem está no caminho
	await _face_off(500.0)
	await _frames(2)
	_hits.clear()
	await _place(foe, Vector2(land_x + 110.0, -60), -1)
	foe.global_position.y = -60
	me.start_special("side")
	await _frames(110)
	_check("Coco: o pedaço rolando acerta", foe.damage_percent > 0.0 and not _hits.is_empty() and _hits[0].damage == 3.5, "%.1f%%" % foe.damage_percent)
	# bater direto no alvo não quebra em pedaços
	await _face_off(350.0)   # o coco desce na altura dele antes de pousar
	await _frames(2)
	me.start_special("side")
	await _frames(70)
	var direct := foe.damage_percent
	_check("Coco: acerto direto tira 5%", absf(direct - 5.0) < 0.01, "%.1f%%" % direct)
	_check("Coco: acerto direto não quebra em pedaços", _projectiles(me).is_empty(), str(_projectiles(me).size()))


## Escada: abre, sobe, dura 2 s e o adversário também sobe nela.
func _escada() -> void:
	await _face_off(500.0)
	await _place(foe, Vector2(2000, -3000), -1)
	var y0 := me.global_position.y
	me.start_special("up")
	await _frames(14)
	var es := get_tree().get_nodes_in_group("escadas")
	_check("Escada: abre no palco", es.size() == 1, str(es.size()))
	_check("Escada: Preguinho sobe", me.global_position.y < y0 - 100.0, "%.0f px" % (y0 - me.global_position.y))
	await _frames(125)
	_check("Escada: fecha depois de 2 s", get_tree().get_nodes_in_group("escadas").is_empty(), str(get_tree().get_nodes_in_group("escadas").size()))
	# o adversário também pode usar
	await _face_off(500.0)
	await _place(foe, Vector2(2000, -3000), -1)
	await _place(me, Vector2(-200, -60), 1)
	await _frames(30)
	me.start_special("up")
	await _frames(10)
	var ladder: Node2D = get_tree().get_nodes_in_group("escadas")[0] if not get_tree().get_nodes_in_group("escadas").is_empty() else null
	_check("Escada: aberta de novo", ladder != null, "")
	if ladder != null:
		foe.brain = null   # o boneco do treino não aperta nada: o teste assume os botões do P2
		foe.controls = FighterControls.new("p2")
		await _place(me, Vector2(-1500, -60), 1)
		await _place(foe, Vector2(ladder.global_position.x, ladder.global_position.y - 60.0), -1)
		await _frames(30)
		var fy := foe.global_position.y
		Input.action_press("p2_up")
		await _frames(20)
		Input.action_release("p2_up")
		_check("Escada: o adversário também sobe nela", foe.global_position.y < fy - 60.0, "subiu %.0f px" % (fy - foe.global_position.y))
	await _frames(100)


## Prego: fica no chão, 1 por vez, quem pisa tropeça (e o dono não).
func _prego() -> void:
	await _face_off(500.0)
	await _place(foe, Vector2(2000, -3000), -1)
	await _place(me, Vector2(-200, -60), 1)
	await _frames(30)
	me.start_special("down")
	await _frames(30)
	var pregos := get_tree().get_nodes_in_group("pregos")
	_check("Prego: fica espetado no chão", pregos.size() == 1, str(pregos.size()))
	var nx: float = pregos[0].global_position.x if not pregos.is_empty() else 0.0
	_check("Prego: no chão, à frente dele", not pregos.is_empty() and absf(pregos[0].global_position.y - (me.global_position.y + Fighter.HEIGHT * 0.5)) < 8.0 and nx > me.global_position.x + 20.0,
		"%.0f,%.0f" % [pregos[0].global_position.x if not pregos.is_empty() else 0.0, pregos[0].global_position.y if not pregos.is_empty() else 0.0])
	# o dono pisa e nada acontece
	await _place(me, Vector2(nx, -60), 1)
	await _frames(40)
	_check("Prego: o dono não tropeça", me.damage_percent == 0.0 and not get_tree().get_nodes_in_group("pregos").is_empty(), "%.1f%%" % me.damage_percent)
	# 1 por vez: o novo troca o velho
	await _place(me, Vector2(-300, -60), 1)
	await _frames(30)
	me.start_special("down")
	await _frames(30)
	var again := get_tree().get_nodes_in_group("pregos").filter(func(n: Node) -> bool: return not n.is_queued_for_deletion())
	_check("Prego: só 1 por vez", again.size() == 1, str(again.size()))
	nx = again[0].global_position.x
	# o adversário pisa e tropeça
	await _place(me, Vector2(-1500, -60), 1)
	await _place(foe, Vector2(nx - 90.0, -60), 1)
	await _frames(30)
	_hits.clear()
	foe.facing = 1
	await _place(foe, Vector2(nx, -60), 1)
	await _frames(30)
	_check("Prego: quem pisa tropeça", foe.damage_percent >= 3.9 and _hits.size() == 1, "%.1f%%" % foe.damage_percent)
	await _frames(40)
	_check("Prego: some depois de pisado", get_tree().get_nodes_in_group("pregos").filter(func(n: Node) -> bool: return not n.is_queued_for_deletion()).is_empty(), "")
	# no ar não tem onde pregar
	await _place(me, Vector2(-200, -300), 1)
	me.start_special("down")
	await _frames(12)
	_check("Prego: no ar não prega", get_tree().get_nodes_in_group("pregos").filter(func(n: Node) -> bool: return not n.is_queued_for_deletion()).is_empty(), "")


func _projectiles(owner_f: Fighter) -> Array:
	var out := []
	for p in get_tree().get_nodes_in_group("projectiles"):
		if p.owner_fighter == owner_f and not p.is_queued_for_deletion():
			out.append(p)
	return out


func _face_off(gap := 70.0) -> void:
	for g in ["escadas", "pregos", "projectiles"]:
		for n in get_tree().get_nodes_in_group(g):
			n.queue_free()
	await _place(me, Vector2(-200, -60), 1)
	await _place(foe, Vector2(-200 + gap, -60), -1)
	await _frames(20)
	me.damage_percent = 0.0
	foe.damage_percent = 0.0
	_hits.clear()


func _place(f: Fighter, pos: Vector2, face := 1) -> void:
	f.release_hold()
	f.release_held()
	f.global_position = pos
	f.velocity = Vector2.ZERO
	f.attack = null
	f.attack_id = ""
	f.helpless = false
	f._hitstop = 0
	f._hitstun = 0.0
	f.state = Fighter.State.AIR
	f.facing = face
	f.visible = true
	f.slip_time = 0.0
	f.turn_lock = 0.0
	f.sand_time = 0.0
	f.invincible_time = 0.0
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


func _check(name: String, ok: bool, detail: String) -> void:
	results.append(("[OK] " if ok else "[FALHA] ") + name + " — " + detail)
	if not ok:
		failures += 1
