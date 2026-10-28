extends Node
## Teste de fumaça da partida (T16 a T19): KO, retorno com invencibilidade, placar,
## KO simultâneo e morte súbita, HUD, contagem, resultado, revanche, pausa e menus.
## Salva screenshots em evidence/etapa-2/match-*.png.
##   godot --path game res://tests/match_smoke.tscn

const MATCH := preload("res://scenes/match.tscn")
const MAIN_MENU := preload("res://scenes/ui/main_menu.tscn")
const CHAR_SELECT := preload("res://scenes/ui/character_select.tscn")
const ARENA_SELECT := preload("res://scenes/ui/arena_select.tscn")

var results: Array[String] = []
var failures := 0
var evidence_dir := ""
var m: MatchManager
var p1: Fighter
var p2: Fighter


func _ready() -> void:
	evidence_dir = ProjectSettings.globalize_path("res://").path_join("../evidence/etapa-2")
	DirAccess.make_dir_recursive_absolute(evidence_dir)
	Game.suppress_scene_changes = true
	await _run()
	Game.suppress_scene_changes = false
	get_tree().paused = false
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	await _test_arena_select()
	await _test_menus()
	await _test_countdown_and_ko()
	await _test_invincibility()
	await _test_normal_win_and_results()
	await _test_simultaneous_and_sudden_death()
	await _test_rematch_and_pause()
	await _test_cpu_mode()
	await _test_mirror()


# --- Partida ---

## Cria uma partida nova. step/delay curtos para o teste não demorar.
func _new_match(step := 0.12, delay := 0.15) -> void:
	if m != null:
		m.queue_free()
		await get_tree().process_frame
	m = MATCH.instantiate()
	m.countdown_step = step
	m.results_delay = delay
	add_child(m)
	p1 = m.fighters["p1"]
	p2 = m.fighters["p2"]
	await _frames(2)


func _start_fight() -> void:
	m.skip_countdown()
	await _frames(20)


func _teleport(f: Fighter, pos: Vector2) -> void:
	f.global_position = pos
	f.velocity = Vector2.ZERO


func _damage_text(pid: String) -> String:
	return (m.hud.panels[pid]["damage"] as Label).text


## Vidas acesas no HUD (cada KO do adversário apaga uma).
func _hud_lives(pid: String) -> int:
	return m.hud.lives_of(pid)


# --- Testes ---

func _test_menus() -> void:
	Game.mode = "versus"
	var menu := MAIN_MENU.instantiate()
	add_child(menu)
	await _frames(5)
	_check("Menu principal tem Jogar, Como jogar, Opções e Sair", menu.buttons.size() == 4 and menu.buttons[0].text == "Jogar" and menu.buttons[3].text == "Sair", "")
	_check("Menu: Jogar começa com foco", menu.buttons[0].has_focus(), "")
	await _shot("match-menu")
	await _tap("p1_down")
	_check("Menu navega com p1_down", menu.buttons[1].has_focus(), "")
	await _tap("p1_up")
	await _tap("p2_attack")
	_check("Menu confirma com p2_attack e vai ao modo", Game.requested_scene == Game.MODE_SCENE, Game.requested_scene)
	menu.queue_free()

	# Escolha de personagem em 2 jogadores
	var sel := CHAR_SELECT.instantiate()
	add_child(sel)
	await _frames(5)
	_check("Seleção começa com Juba e Seu Capivas", sel.choice["p1"] == 0 and sel.choice["p2"] == 1, str(sel.choice))
	_check("Grade mostra todos os 24 do elenco", sel.tiles.size() == 24, str(sel.tiles.size()))
	await _tap("p1_right")
	_check("p1_right pula o \"?\" e chega no Berrante", sel.choice["p1"] == 11 and sel.cursor["p1"] == Vector2i(2, 0), str(sel.cursor))
	await _tap("p1_left")
	await _tap("p1_left")
	_check("p1_left dá a volta pulando os \"?\" (Berrante -> Juba -> Preguinho)", sel.choice["p1"] == 14, str(sel.cursor))
	await _tap("p1_left")
	_check("p1_left do Preguinho volta ao Berrante", sel.choice["p1"] == 11, str(sel.cursor))
	# \"?\" à força (mouse/teste): não confirma
	sel._set_cursor("p1", Vector2i(1, 0))
	sel._refresh()
	await _tap("p1_attack")
	_check("\"?\" não confirma", not sel.locked["p1"], str(sel.locked))
	sel._set_cursor("p1", Vector2i(2, 1))
	await _tap("p1_down")
	_check("p1_down pula o \"?\" de baixo (Suçuarana) e chega na Dona Onça (coluna mais perto, empate vai para a esquerda)", sel.choice["p1"] == 8 and sel.cursor["p1"] == Vector2i(1, 2), str(sel.cursor))
	var empty_hits := 0
	var probe := Vector2i.ZERO
	for i in 40:
		probe = sel.next_cell(probe, [Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT, Vector2i.UP][i % 4])
		if not sel.cell_playable(probe):
			empty_hits += 1
	_check("Navegação nunca para num \"?\"", empty_hits == 0, str(empty_hits))
	await _tap("p2_left")
	await _tap("p2_up")
	_check("P2 anda pela grade até o Juba", sel.choice["p2"] == 0, str(sel.choice))
	await _shot("match-selecao")
	await _tap("p1_attack")
	_check("P1 confirma com ataque", sel.locked["p1"] and not sel.locked["p2"], str(sel.locked))
	await _tap("p2_jump")
	_check("P2 confirma com pulo", sel.locked["p2"], str(sel.locked))
	await _wait(sel.START_DELAY + 0.3)
	_check("Os dois prontos vão para a escolha de arena", Game.requested_scene == Game.ARENA_SELECT_SCENE, Game.requested_scene)
	_check("Escolhas ficam no Game", Game.character_scene("p1").ends_with("dona_onca.tscn") and Game.character_scene("p2").ends_with("agil.tscn"), str(Game.characters))
	sel.queue_free()
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	await _frames(2)


func _test_countdown_and_ko() -> void:
	Game.mode = "versus"
	await _new_match(0.25)
	_check("Contagem: começa em COUNTDOWN", m.phase == MatchManager.Phase.COUNTDOWN, "")
	_check("Contagem: lutadores não agem", not p1.is_physics_processing() and not p2.is_physics_processing(), "")
	_check("Contagem: mostra 3", m.hud.banner.visible and m.hud.banner.text == "3", m.hud.banner.text)
	var seen: Array[String] = [m.hud.banner.text]
	var t := 0.0
	while m.phase == MatchManager.Phase.COUNTDOWN and t < 3.0:
		await get_tree().process_frame
		t += get_process_delta_time()
		if m.hud.banner.text != seen[-1]:
			seen.append(m.hud.banner.text)
	_check("Contagem: 3, 2, 1, LUTEM!", seen == ["3", "2", "1", "LUTEM!"], str(seen))
	_check("Contagem: depois dela a luta começa", m.phase == MatchManager.Phase.FIGHT and p1.is_physics_processing() and p2.is_physics_processing(), "")
	await _frames(40)

	# HUD: dano e cores
	_check("HUD: dano começa em 0%", _damage_text("p1") == "0%" and _damage_text("p2") == "0%", _damage_text("p2"))
	_check("HUD: nomes dos lutadores", (m.hud.panels["p1"]["name"] as Label).text.contains("Juba") and (m.hud.panels["p2"]["name"] as Label).text.contains("Seu Capivas"), (m.hud.panels["p1"]["name"] as Label).text)
	_check("Cor do dano: 0% branco", Hud.damage_color(0).is_equal_approx(Color.WHITE), "")
	var c50 := Hud.damage_color(50)
	var c100 := Hud.damage_color(100)
	var c150 := Hud.damage_color(150)
	_check("Cor do dano: 50% amarelo, 100% laranja, 150% vermelho", c50.r > 0.9 and c50.g > 0.85 and c50.b < 0.4 and c100.g > 0.5 and c100.g < 0.65 and c150.g < 0.25 and c150.r > 0.85, "%s %s %s" % [c50, c100, c150])
	_check("Cor do dano: acima de 150% fica vermelho", Hud.damage_color(400).is_equal_approx(c150), "")
	_teleport(p1, Vector2(-70, -56))
	_teleport(p2, Vector2(0, -56))
	p2.facing = -1
	await _frames(6)
	# Golpe real: o dano aparece na hora
	p2.receive_hit(p1, p1.moveset.jab, 1)
	_check("HUD: dano atualiza na hora (golpe real)", _damage_text("p2") == "%d%%" % roundi(p2.damage_percent) and p2.damage_percent > 0.0, _damage_text("p2"))
	p2.damage_percent = 120.0
	p2.damage_changed.emit(120.0)
	_check("HUD: 120%", _damage_text("p2") == "120%", _damage_text("p2"))
	var col := (m.hud.panels["p2"]["damage"] as Label).get_theme_color("font_color")
	_check("HUD: cor do dano em 120% está entre laranja e vermelho", col.is_equal_approx(Hud.damage_color(120)) and col.g < 0.58, str(col))
	p2.damage_percent = 5000.0
	p2.damage_changed.emit(5000.0)
	_check("HUD: dano exibido até 999%", _damage_text("p2") == "999%", _damage_text("p2"))
	p2.damage_percent = 87.0
	p2.damage_changed.emit(87.0)
	await _frames(30)

	# KO de verdade: P2 cai pela lateral da arena
	_teleport(p1, Vector2(-300, -56))
	_teleport(p2, Vector2(900, 100))
	var fell := false
	for i in 400:
		await get_tree().physics_frame
		if m.kos["p1"] == 1:
			fell = true
			break
	_check("KO ao cair pela zona (natural): P1 marca", fell and m.kos["p2"] == 0, str(m.kos))
	_check("KO: HUD apaga 1 vida do P2 (KO do P1)", _hud_lives("p2") == m.ko_target - 1 and _hud_lives("p1") == m.ko_target, "%d/%d" % [_hud_lives("p1"), _hud_lives("p2")])
	_check("Retorno: P2 reaparece no alto", p2.global_position.y < -380 and p2.global_position.y > -470 and absf(p2.global_position.x - 300.0) < 5.0, str(p2.global_position))
	_check("Retorno: invencível por ~2 s", p2.invincible_time > 1.9, "%.2f" % p2.invincible_time)
	_check("Retorno: dano zerado e HUD em 0%", p2.damage_percent == 0.0 and _damage_text("p2") == "0%", _damage_text("p2"))
	_check("Retorno: invencível não é atingível", not p2.can_be_hit(), "")
	await _frames(20)
	await _shot("match-hud-luta")

	# Zonas: esquerda, cima e baixo
	for case in [["esquerda", Vector2(-1450, 0)], ["cima", Vector2(0, -1250)], ["baixo", Vector2(0, 950)]]:
		var before: int = m.kos["p1"]
		_teleport(p2, case[1])
		await _frames(2)
		_check("Zona de KO %s conta KO" % case[0], m.kos["p1"] == before + 1, str(m.kos))
		m.kos["p1"] = before  # mantém o placar para os próximos casos
		m.hud.set_kos(m.kos)
	var inside := Vector2(1390, -1190)
	_teleport(p2, inside)
	var kos_before: int = m.kos["p1"]
	await _frames(1)
	_check("Dentro da zona (perto do canto) não é KO", m.kos["p1"] == kos_before, str(m.kos))


func _test_invincibility() -> void:
	await _new_match()
	await _start_fight()
	m.resolve_kos(["p2"] as Array[String])
	await _frames(1)
	_check("Invencibilidade: ativa depois do KO", p2.invincible_time > 1.9, "%.2f" % p2.invincible_time)
	await _frames(30)
	_check("Invencibilidade: diminui com o tempo", p2.invincible_time < 1.6 and p2.invincible_time > 0.0, "%.2f" % p2.invincible_time)
	p2.start_attack("jab")
	await _frames(2)
	_check("Invencibilidade: termina cedo ao atacar", p2.invincible_time == 0.0, "%.2f" % p2.invincible_time)
	_check("Invencibilidade: P1 nunca tinha sido KO (sem efeito nele)", p1.invincible_time == 0.0, "")
	# Termina sozinha após 2 s
	m.resolve_kos(["p1"] as Array[String])
	await _wait(2.2)
	_check("Invencibilidade: acaba sozinha em 2 s", p1.invincible_time == 0.0 and p1.can_be_hit(), "%.2f" % p1.invincible_time)


func _test_normal_win_and_results() -> void:
	await _new_match()
	await _start_fight()
	var ended := []
	m.match_ended.connect(func(w: String) -> void: ended.append(w))
	# Acertos reais para as estatísticas do resultado: 2 jabs e 1 ftilt do P1, 1 dtilt do P2
	var dano_p1 := 0.0
	for mv in ["jab", "jab", "ftilt"]:
		var d: AttackData = p1.moveset.move(mv)
		p2.invincible_time = 0.0
		p2.receive_hit(p1, d, 1)
		dano_p1 += d.damage
		await _frames(2)
	p1.invincible_time = 0.0
	p1.receive_hit(p2, p2.moveset.move("dtilt"), -1)
	await _frames(2)
	for i in 3:
		_check("Placar parcial %d x 0: partida segue" % i, m.phase == MatchManager.Phase.FIGHT and ended.is_empty(), str(m.kos))
		_teleport(p2, Vector2(1500, 0))
		await _frames(3)
	_check("3 KOs encerram a partida", m.phase == MatchManager.Phase.ENDED and ended == ["p1"], str(ended))
	_check("Fim: lutadores param", not p1.is_physics_processing(), "")
	_check("Fim: HUD com P2 sem vidas e P1 com todas", _hud_lives("p2") == 0 and _hud_lives("p1") == m.ko_target, "%d/%d" % [_hud_lives("p1"), _hud_lives("p2")])
	await _wait(m.results_delay + 0.3)
	_check("Resultado aparece", m.results.visible, "")
	_check("Resultado: vencedor", m.results.title_label.text == "Jogador 1 venceu!", m.results.title_label.text)
	_check("Resultado: KOs de cada um", m.results.kos_label.text.contains("3") and m.results.kos_label.text.contains("0"), m.results.kos_label.text)
	var st: Dictionary = Game.last_result.get("stats", {})
	_check("Resultado: stats do P1 (dano somado, 3 KOs, golpe top = jab)", st.has("p1") and int(st["p1"]["dano"]) == roundi(dano_p1) and st["p1"]["kos"] == 3 and st["p1"]["golpe_top"] == "jab" and st["p1"]["golpe_top_acertos"] == 2, str(st.get("p1")))
	_check("Resultado: stats do P2 (1 acerto de dtilt, 0 KO)", st.has("p2") and st["p2"]["acertos"] == 1 and st["p2"]["golpe_top"] == "dtilt" and st["p2"]["kos"] == 0, str(st.get("p2")))
	_check("Resultado: nome legível do golpe na tela", (m.results.stat_cards["p1"]["golpe"] as Label).text.begins_with("Soco rápido"), (m.results.stat_cards["p1"]["golpe"] as Label).text)
	_check("Resultado: dano causado na tela", (m.results.stat_cards["p1"]["dano"] as Label).text == "%d%%" % roundi(dano_p1), (m.results.stat_cards["p1"]["dano"] as Label).text)
	_check("Resultado: não dá para pausar", not m.can_pause(), "")
	await _wait(ResultsScreen.INPUT_LOCK + 0.1)
	await _shot("match-resultado")


func _test_simultaneous_and_sudden_death() -> void:
	# KO simultâneo comum: os dois marcam
	await _new_match()
	await _start_fight()
	_teleport(p1, Vector2(-1500, 0))
	_teleport(p2, Vector2(1500, 0))
	await _frames(3)
	_check("KO simultâneo: os dois marcam", m.kos["p1"] == 1 and m.kos["p2"] == 1, str(m.kos))
	_check("KO simultâneo: os dois voltam invencíveis", p1.invincible_time > 1.8 and p2.invincible_time > 1.8, "")

	# Os dois chegam a 3 juntos: morte súbita
	m.kos = {"p1": 2, "p2": 2}
	var sudden := []
	m.sudden_death_started.connect(func() -> void: sudden.append(true))
	_teleport(p1, Vector2(-1500, 0))
	_teleport(p2, Vector2(1500, 0))
	await _frames(3)
	_check("Morte súbita: 3 x 3 não encerra", m.phase == MatchManager.Phase.FIGHT and m.kos["p1"] == 3 and m.kos["p2"] == 3, str(m.kos))
	_check("Morte súbita: ativada", m.sudden_death and sudden.size() == 1, "")
	_check("Morte súbita: aviso na tela", m.hud.banner.visible and m.hud.banner.text == "MORTE SÚBITA", m.hud.banner.text)
	await _shot("match-morte-subita")
	_check("Morte súbita: resultado ainda não aparece", not m.results.visible, "")
	# Outro KO simultâneo na morte súbita não decide
	_teleport(p1, Vector2(-1500, 0))
	_teleport(p2, Vector2(1500, 0))
	await _frames(3)
	_check("Morte súbita: KO duplo não decide", m.phase == MatchManager.Phase.FIGHT and m.kos["p1"] == 4 and m.kos["p2"] == 4, str(m.kos))
	# O próximo KO decide
	_teleport(p1, Vector2(-1500, 0))
	await _frames(3)
	_check("Morte súbita: próximo KO decide (P2 vence)", m.phase == MatchManager.Phase.ENDED and Game.last_result["winner"] == "p2", str(Game.last_result))
	await _wait(m.results_delay + 0.3)
	_check("Morte súbita: resultado mostra o vencedor", m.results.visible and m.results.title_label.text == "Jogador 2 venceu!", m.results.title_label.text)

	# Só um chega à meta num KO duplo: 2x1 vira 3x2 e o P1 vence
	await _new_match()
	await _start_fight()
	m.kos = {"p1": 2, "p2": 1}
	_teleport(p1, Vector2(-1500, 0))
	_teleport(p2, Vector2(1500, 0))
	await _frames(3)
	_check("KO duplo 2x1 vira 3x2: quem passa da meta vence", m.phase == MatchManager.Phase.ENDED and Game.last_result["winner"] == "p1" and m.kos["p2"] == 2, str(m.kos))


func _test_rematch_and_pause() -> void:
	Game.requested_scene = ""
	await _new_match()
	await _start_fight()
	for i in 3:
		_teleport(p2, Vector2(1500, 0))
		await _frames(3)
	await _wait(m.results_delay + ResultsScreen.INPUT_LOCK + 0.3)
	_check("Revanche: resultado com botões ativos", m.results.visible and not m.results.buttons[0].disabled, "")
	m.results.buttons[1].pressed.emit()
	_check("Botão Menu volta ao menu", Game.requested_scene == Game.MENU_SCENE, Game.requested_scene)
	m.results.buttons[0].pressed.emit()
	await _frames(3)
	_check("Revanche: placar 0 x 0", m.kos["p1"] == 0 and m.kos["p2"] == 0 and _hud_lives("p1") == m.ko_target and _hud_lives("p2") == m.ko_target, str(m.kos))
	_check("Revanche: resultado some e contagem recomeça", not m.results.visible and m.phase == MatchManager.Phase.COUNTDOWN, "")
	_check("Revanche: mesmos personagens e dano zerado", p1.display_name == "Juba" and p2.display_name == "Seu Capivas" and p2.damage_percent == 0.0 and _damage_text("p2") == "0%", "")
	_check("Revanche: lutadores nas posições iniciais", p1.global_position.distance_to(Vector2(-300, -400)) < 5.0 and p2.global_position.distance_to(Vector2(300, -400)) < 5.0, str(p2.global_position))
	await _start_fight()
	# Uma segunda partida completa
	for i in 3:
		_teleport(p1, Vector2(-1500, 0))
		await _frames(3)
	_check("Segunda partida seguida termina (P2 venceu)", m.phase == MatchManager.Phase.ENDED and Game.last_result["winner"] == "p2", str(Game.last_result))
	m.restart()
	await _start_fight()

	# Pausa
	var clock_before := p1._clock
	await _tap("p1_pause", 1.0, 3)
	_check("Pausa: p1_pause pausa o jogo", get_tree().paused and m.pause_menu.visible, "")
	var clock_paused := p1._clock
	await _wait(0.2)
	_check("Pausa: lutadores congelados", is_equal_approx(p1._clock, clock_paused) and clock_paused > clock_before, "")
	_check("Pausa: Continuar tem foco", m.pause_menu.buttons[0].has_focus(), "")
	var cel_atk := m.pause_menu.control_cells[[3, "p1"]] as Label
	_check("Pausa: tabela mostra o Ataque do P1 do mapeamento", cel_atk.text.begins_with(Controles.describe("p1_attack", "teclado")), cel_atk.text)
	await _shot("match-pausa")
	await _tap("p1_pause", 1.0, 3)
	_check("Pausa: p1_pause de novo continua", not get_tree().paused and not m.pause_menu.visible, "")
	await _tap("p2_pause", 1.0, 3)
	_check("Pausa: p2_pause também pausa", get_tree().paused and m.pause_menu.visible, "")
	# Reiniciar pelo menu de pausa
	m.kos["p1"] = 2
	m.hud.set_kos(m.kos)
	m.pause_menu.buttons[1].pressed.emit()
	await _frames(3)
	_check("Pausa: Reiniciar zera o placar e despausa", not get_tree().paused and m.kos["p1"] == 0 and m.phase == MatchManager.Phase.COUNTDOWN, str(m.kos))
	await _start_fight()
	# Troca a tecla do Ataque do P1 e reabre: a pausa mostra a nova (não é fixa)
	Controles.file_path = "user://controles_teste.cfg"
	var k := InputEventKey.new()
	k.physical_keycode = KEY_K
	Controles.rebind("p1_attack", k)
	m.pause_menu.open()
	var cel := m.pause_menu.control_cells[[3, "p1"]] as Label
	_check("Pausa: tabela segue o mapeamento trocado (Ataque P1 = K)", cel.text.begins_with("K"), cel.text)
	Controles.reset_to_defaults()
	Controles.file_path = Controles.FILE_PATH
	_check("Pausa: aberta por código", get_tree().paused, "")
	Game.requested_scene = ""
	m.pause_menu.buttons[2].pressed.emit()
	_check("Pausa: Sair para o menu", Game.requested_scene == Game.MENU_SCENE, Game.requested_scene)
	get_tree().paused = false
	m.pause_menu.visible = false
	await _frames(2)


## Espelho: mesmo lutador dos dois lados -> P2 com a paleta trocada (só ele).
func _test_mirror() -> void:
	var old_mode := Game.mode
	Game.mode = "versus"
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	await _new_match()
	_check("Espelho: lutadores diferentes não trocam paleta", not Espelho.is_applied(p2) and not m.hud.mirror, "")
	for idx in [0, 1, 8]:
		Game.set_character("p1", idx)
		Game.set_character("p2", idx)
		await _new_match()
		var s1 := p1.get_node_or_null("Visual/Quadro") as CanvasItem
		var s2 := p2.get_node_or_null("Visual/Quadro") as CanvasItem
		var ok2 := s2 != null and s2.material is ShaderMaterial and (s2.material as ShaderMaterial).shader == Espelho.SHADER
		var ok1 := s1 != null and s1.material is ShaderMaterial and (s1.material as ShaderMaterial).shader != Espelho.SHADER
		_check("Espelho %s: P2 com paleta trocada, P1 normal" % Game.CHARACTERS[idx]["name"], ok1 and ok2 and m.hud.mirror, "%s %s" % [s1, s2])
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)
	Game.mode = old_mode


func _test_cpu_mode() -> void:
	Game.mode = "cpu"
	await _new_match()
	_check("Modo CPU: P2 controlado pela CPU", p2.brain != null and p1.brain == null, "")
	var selo := (m.hud.panels["p2"]["tag"] as Control).get_node("Texto") as Label
	_check("Modo CPU: selo do HUD chama o P2 de CPU", selo.text == "CPU", selo.text)
	var cor_selo := ((m.hud.panels["p2"]["tag"] as Panel).get_theme_stylebox("panel") as StyleBoxFlat).bg_color
	_check("Modo CPU: selo na cor do jogador 2", cor_selo.is_equal_approx(Game.PLAYER_COLORS["p2"]), str(cor_selo))
	var box := m.hud.panels["p1"]["box"] as Control
	_check("HUD: painel compacto (<= 400x145 em 1080p)", box.size.x <= 400.0 and box.size.y <= 145.0, str(box.size))
	# Escolha de personagem no modo CPU: P1 escolhe os dois
	var sel := CHAR_SELECT.instantiate()
	add_child(sel)
	await _frames(4)
	await _tap("p1_attack")
	_check("CPU: P1 confirma e a vez da CPU começa", sel.locked["p1"] and not sel.locked["p2"] and sel.slot_active("p2"), str(sel.locked))
	await _tap("p1_left")
	await _tap("p1_up")
	_check("CPU: P1 escolhe o personagem da CPU", sel.choice["p2"] == 0 and sel.choice["p1"] == 0, str(sel.choice))
	await _shot("match-selecao-cpu")
	Game.requested_scene = ""
	await _tap("p1_attack")
	await _wait(sel.START_DELAY + 0.3)
	_check("CPU: escolhas completas vão para a escolha de arena", Game.requested_scene == Game.ARENA_SELECT_SCENE and Game.character_scene("p2").ends_with("agil.tscn"), Game.requested_scene)
	sel.queue_free()
	Game.mode = "versus"
	Game.set_character("p1", 0)
	Game.set_character("p2", 1)


# --- Auxiliares ---

func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


## Escolha de arena: setas trocam, Ataque confirma e vai para a luta; um clique
## do mouse (com o Ataque no mouse) não confirma nada sozinho na tela de personagens.
func _test_arena_select() -> void:
	Game.arena_index = 0
	var a := ARENA_SELECT.instantiate()
	add_child(a)
	await _frames(4)
	_check("Arenas: cartões de Aleatória + arenas prontas", a.cards.size() >= 2, str(a.cards.size()))
	var start: int = a.index
	await _tap("p1_right")
	_check("Arenas: direita troca o cartão", a.index == posmod(start + 1, a.cards.size()), str(a.index))
	Game.requested_scene = ""
	await _tap("p1_attack")
	await _wait(0.5)
	_check("Arenas: Ataque confirma e vai para a luta", Game.requested_scene == Game.MATCH_SCENE and Game.arena_index == a._options[a.index], "%s %d" % [Game.requested_scene, Game.arena_index])
	a.queue_free()
	Game.arena_index = 0
	var sel := CHAR_SELECT.instantiate()
	add_child(sel)
	await _frames(3)
	Controles.file_path = "user://controles_teste.cfg"
	var left := InputEventMouseButton.new()
	left.button_index = MOUSE_BUTTON_LEFT
	left.pressed = true
	Controles.rebind("p1_attack", left)
	Input.parse_input_event(left.duplicate())
	await _frames(3)
	var up := left.duplicate() as InputEventMouseButton
	up.pressed = false
	Input.parse_input_event(up)
	await _frames(2)
	Controles.reset_to_defaults()
	Controles.file_path = Controles.FILE_PATH
	_check("Clique do mouse não confirma o personagem sozinho", not sel.locked["p1"], str(sel.locked))
	sel.queue_free()
	await _frames(2)


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame


## Espera tempo real (o relógio do teste não depende da pausa).
func _wait(seconds: float) -> void:
	await get_tree().create_timer(seconds, true).timeout


## Aperta uma ação de interface. Os menus leem Input em _process, então o aperto
## precisa começar e durar dentro de quadros de processamento (se vários passos de
## física rodarem de uma vez, depois de salvar um PNG, um aperto só de física se perderia).
func _tap(action: String, strength := 1.0, hold := 3) -> void:
	await get_tree().process_frame
	Input.action_press(action, strength)
	for i in hold:
		await get_tree().process_frame
	Input.action_release(action)
	for i in 2:
		await get_tree().process_frame


func _shot(name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return  # sem renderização não há screenshot
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	img.save_png(evidence_dir.path_join(name + ".png"))
