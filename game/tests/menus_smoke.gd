extends Node
## Teste de fumaça dos menus novos: menu principal (4 botões), Opções (persistência,
## barramentos de áudio, tremor de tela, navegação por teclado/gamepad simulada) e
## Como jogar. Usa um arquivo de opções próprio (não mexe nas opções do jogador).
##   godot --headless --path game res://tests/menus_smoke.tscn

const MAIN_MENU := preload("res://scenes/ui/main_menu.tscn")
const OPTIONS := preload("res://scenes/ui/options.tscn")
const HOW_TO_PLAY := preload("res://scenes/ui/how_to_play.tscn")
const TEST_FILE := "user://settings_menus_smoke.cfg"
const VIEW := Vector2(1920, 1080)

var results: Array[String] = []
var failures := 0
var _real_path := ""


func _ready() -> void:
	_real_path = Settings.file_path
	Settings.file_path = TEST_FILE
	DirAccess.remove_absolute(TEST_FILE)
	Settings.reset_to_defaults()
	Game.suppress_scene_changes = true
	await _run()
	Game.suppress_scene_changes = false
	DirAccess.remove_absolute(TEST_FILE)
	Settings.file_path = _real_path
	Settings.load_settings()  # devolve as opções reais do jogador
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _run() -> void:
	_test_settings_and_buses()
	await _test_main_menu()
	await _test_options()
	await _test_how_to_play()


# --- Settings e áudio ---

func _test_settings_and_buses() -> void:
	var sfx := AudioServer.get_bus_index("SFX")
	var music := AudioServer.get_bus_index("Music")
	_check("Barramentos SFX e Music existem", sfx >= 0 and music >= 0, "%d %d" % [sfx, music])
	_check("SFX e Music saem no Master", AudioServer.get_bus_send(sfx) == &"Master" and AudioServer.get_bus_send(music) == &"Master", "")
	_check("Padrões: 0.8 / 1.0 / 0.7 / janela / tremor", is_equal_approx(Settings.master_volume, 0.8) and is_equal_approx(Settings.sfx_volume, 1.0) \
		and is_equal_approx(Settings.music_volume, 0.7) and not Settings.fullscreen and Settings.screen_shake, "")
	_check("Volume do Master aplicado", is_equal_approx(AudioServer.get_bus_volume_db(0), linear_to_db(0.8)), "")
	var routed := true
	for c in Sfx.get_children():
		if c is AudioStreamPlayer and c.bus != &"SFX":
			routed = false
	_check("Sons do Sfx saem no barramento SFX", routed and Sfx.get_child_count() > 0, "")
	Settings.set_value("master_volume", 5.0)
	_check("Valor fora da faixa é limitado a 1.0", is_equal_approx(Settings.master_volume, 1.0), str(Settings.master_volume))
	Settings.set_value("master_volume", 0.8)


# --- Menu principal ---

func _test_main_menu() -> void:
	var menu := MAIN_MENU.instantiate()
	add_child(menu)
	await _frames(5)
	var names: Array[String] = []
	for b in menu.buttons:
		names.append(b.text)
	_check("Menu principal: Jogar, Como jogar, Opções, Sair", names == ["Jogar", "Como jogar", "Opções", "Sair"], str(names))
	_check("Menu: Jogar começa com foco", menu.buttons[0].has_focus(), "")
	await _tap("p1_down")
	_check("Menu: p1_down vai a Como jogar", menu.buttons[1].has_focus(), "")
	Game.requested_scene = ""
	await _tap("p1_attack")
	_check("Menu: Como jogar abre a tela", Game.requested_scene == Game.HOW_TO_PLAY_SCENE, Game.requested_scene)
	await _tap("p2_down")
	_check("Menu: p2_down vai a Opções", menu.buttons[2].has_focus(), "")
	Game.requested_scene = ""
	await _tap("p2_jump")
	_check("Menu: Opções abre a tela", Game.requested_scene == Game.OPTIONS_SCENE, Game.requested_scene)
	_check("Cenas novas existem", ResourceLoader.exists(Game.OPTIONS_SCENE) and ResourceLoader.exists(Game.HOW_TO_PLAY_SCENE), "")
	menu.queue_free()
	await _frames(2)


# --- Opções ---

func _saved(key: String) -> Variant:
	var cfg := ConfigFile.new()
	cfg.load(TEST_FILE)
	return cfg.get_value(Settings.SECTION, key, null)


func _near(a: Variant, b: float) -> bool:
	return a != null and absf(float(a) - b) < 0.001


func _test_options() -> void:
	Settings.reset_to_defaults()
	var o: OptionsScreen = OPTIONS.instantiate()
	add_child(o)
	await _frames(5)
	_check("Opções: 3 deslizantes, 2 liga/desliga e Voltar", o.focusables.size() == 6 and o.sliders.size() == 3 and o.toggles.size() == 2 \
		and o.buttons.size() == 1 and o.buttons[0].text == "Voltar", str(o.focusables.size()))
	_check("Opções: foco inicial em Volume geral", o.sliders["master_volume"].has_focus(), "")
	_check("Opções: mostra os valores salvos", is_equal_approx(o.sliders["master_volume"].value, 0.8) \
		and is_equal_approx(o.sliders["sfx_volume"].value, 1.0) and is_equal_approx(o.sliders["music_volume"].value, 0.7), "")

	# Volume geral: direita +10% (p1_right), esquerda duas vezes (ui_left e p2_left)
	await _tap("p1_right")
	_check("Volume geral +10% com p1_right", is_equal_approx(Settings.master_volume, 0.9), str(Settings.master_volume))
	_check("Volume geral aplicado no Master", is_equal_approx(AudioServer.get_bus_volume_db(0), linear_to_db(0.9)), str(AudioServer.get_bus_volume_db(0)))
	_check("Volume geral salvo no arquivo", _near(_saved("master_volume"), 0.9), str(_saved("master_volume")))
	await _tap("ui_left")
	await _tap("p2_left")
	_check("Volume geral -20% (ui_left e p2_left)", is_equal_approx(Settings.master_volume, 0.7), str(Settings.master_volume))

	# Efeitos sonoros
	await _tap("p1_down")
	_check("p1_down vai a Efeitos sonoros", o.sliders["sfx_volume"].has_focus(), "")
	await _tap("p1_right")
	_check("Efeitos no máximo não passa de 100%", is_equal_approx(Settings.sfx_volume, 1.0), str(Settings.sfx_volume))
	await _tap("ui_left")
	_check("Efeitos 90% no barramento SFX", is_equal_approx(Settings.sfx_volume, 0.9) \
		and is_equal_approx(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")), linear_to_db(0.9)), str(Settings.sfx_volume))
	_check("Efeitos salvo no arquivo", _near(_saved("sfx_volume"), 0.9), str(_saved("sfx_volume")))

	# Música: 0% silencia o barramento
	await _tap("ui_down")
	_check("ui_down vai a Música", o.sliders["music_volume"].has_focus(), "")
	for i in 7:
		await _tap("p2_left")
	var music := AudioServer.get_bus_index("Music")
	_check("Música em 0% muda o barramento Music", is_equal_approx(Settings.music_volume, 0.0) and AudioServer.is_bus_mute(music), str(Settings.music_volume))
	await _tap("p1_right")
	await _tap("p1_right")
	_check("Música 20% ativa o barramento", is_equal_approx(Settings.music_volume, 0.2) and not AudioServer.is_bus_mute(music) \
		and is_equal_approx(AudioServer.get_bus_volume_db(music), linear_to_db(0.2)), str(Settings.music_volume))
	var percent := (o._value_labels[o.sliders["music_volume"]] as Label).text
	_check("Rótulo da porcentagem", percent == "20%", percent)

	# Segurar a direção repete
	var before := Settings.music_volume
	Input.action_press("p1_right")
	await _wait(1.0)
	Input.action_release("p1_right")
	await _frames(2)
	_check("Segurar a direção repete o ajuste", Settings.music_volume > before + 0.25, "%s -> %s" % [before, Settings.music_volume])

	# Liga/desliga
	await _tap("p1_down")
	_check("p1_down vai a Tela cheia", o.toggles["fullscreen"].has_focus(), "")
	await _tap("p1_attack")
	_check("Tela cheia liga com confirmar", Settings.fullscreen and o.toggles["fullscreen"].text == "Ligado" and _saved("fullscreen") == true, str(Settings.fullscreen))
	await _tap("ui_accept")
	_check("Tela cheia desliga de novo", not Settings.fullscreen and _saved("fullscreen") == false, str(Settings.fullscreen))
	await _tap("p2_down")
	_check("p2_down vai a Tremor de tela", o.toggles["screen_shake"].has_focus(), "")
	_check("Tremor começa ligado", Settings.screen_shake and o.toggles["screen_shake"].text == "Ligado", "")
	await _tap("p2_jump")
	_check("Tremor desliga e salva", not Settings.screen_shake and _saved("screen_shake") == false, str(Settings.screen_shake))
	await _test_shake_reaches_camera()
	await _tap("p2_right")
	_check("Direita no liga/desliga liga", Settings.screen_shake, "")
	await _test_shake_reaches_camera()
	await _tap("p2_left")
	_check("Esquerda no liga/desliga desliga", not Settings.screen_shake, "")

	# Persistência: zera na memória e recarrega do arquivo
	Settings.master_volume = 0.0
	Settings.sfx_volume = 0.0
	Settings.music_volume = 0.0
	Settings.fullscreen = true
	Settings.screen_shake = true
	Settings.load_settings()
	_check("Recarregar do arquivo devolve tudo", _near(Settings.master_volume, 0.7) and _near(Settings.sfx_volume, 0.9) \
		and Settings.music_volume > 0.25 and not Settings.fullscreen and not Settings.screen_shake, \
		"%s %s %s %s %s" % [Settings.master_volume, Settings.sfx_volume, Settings.music_volume, Settings.fullscreen, Settings.screen_shake])
	_check("Recarregar reaplica nos barramentos", is_equal_approx(AudioServer.get_bus_volume_db(0), linear_to_db(0.7)), "")

	# Layout e saída
	var col := o.get_child(1).get_child(0) as Control
	_check("Opções cabem em 1920x1080", col.get_combined_minimum_size().x <= VIEW.x and col.get_combined_minimum_size().y <= VIEW.y, str(col.get_combined_minimum_size()))
	await _tap("p1_down")
	_check("Voltar fica com foco", o.buttons[0].has_focus(), "")
	Game.requested_scene = ""
	await _tap("p1_attack")
	_check("Voltar leva ao menu principal", Game.requested_scene == Game.MENU_SCENE, Game.requested_scene)
	Game.requested_scene = ""
	await _tap("ui_cancel")
	_check("Cancelar (Esc) também volta", Game.requested_scene == Game.MENU_SCENE, Game.requested_scene)
	o.queue_free()
	await _frames(2)
	Settings.reset_to_defaults()


## Cria uma câmera da luta e manda o tremor pelo mesmo caminho dos lutadores.
func _test_shake_reaches_camera() -> void:
	var cam: Camera2D = load("res://scripts/fight_camera.gd").new()
	add_child(cam)
	await _frames(2)
	get_tree().call_group("fight_camera", "shake", 3000.0)
	var trauma: float = cam._trauma
	if Settings.screen_shake:
		_check("Tremor ligado: a câmera treme", trauma > 0.0, str(trauma))
	else:
		_check("Tremor desligado: a câmera não treme", is_zero_approx(trauma), str(trauma))
	cam.queue_free()
	await _frames(2)


# --- Como jogar ---

func _test_how_to_play() -> void:
	var h: HowToPlayScreen = HOW_TO_PLAY.instantiate()
	add_child(h)
	await _frames(6)
	_check("Como jogar: tabela com cabeçalho e 8 linhas", h.table.get_child_count() == 4 * (1 + HowToPlayScreen.CONTROLS.size()), str(h.table.get_child_count()))
	_check("Como jogar: textos dos 3 controles", _has_text(h.table, "Numpad 3 + Numpad 1") and _has_text(h.table, "RT") and _has_text(h.table, "L + J"), "")
	_check("Como jogar: 3 a 5 regras", HowToPlayScreen.RULES.size() >= 3 and HowToPlayScreen.RULES.size() <= 5, str(HowToPlayScreen.RULES.size()))
	_check("Como jogar: Voltar com foco", h.buttons.size() == 1 and h.buttons[0].text == "Voltar" and h.buttons[0].has_focus(), "")
	var col := h.scroll.get_parent() as Control
	var need := col.get_combined_minimum_size()
	_check("Como jogar cabe em 1920x1080", need.x <= VIEW.x and need.y <= VIEW.y, str(need))
	var content_need := h.content.get_combined_minimum_size()
	_check("Como jogar: conteúdo cabe sem rolagem", content_need.y <= h.scroll.custom_minimum_size.y and content_need.x <= h.scroll.custom_minimum_size.x, \
		"%s em %s" % [content_need, h.scroll.custom_minimum_size])
	Game.requested_scene = ""
	await _tap("p1_attack")
	_check("Como jogar: Voltar leva ao menu principal", Game.requested_scene == Game.MENU_SCENE, Game.requested_scene)
	h.queue_free()
	await _frames(2)


func _has_text(node: Node, text: String) -> bool:
	for c in node.get_children():
		if c is Label and c.text == text:
			return true
	return false


# --- Utilidades ---

func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().process_frame


func _wait(seconds: float) -> void:
	await get_tree().create_timer(seconds, true).timeout


## Aperta uma ação por alguns quadros de processamento (os menus leem Input em _process).
func _tap(action: String, hold := 3) -> void:
	await get_tree().process_frame
	Input.action_press(action)
	for i in hold:
		await get_tree().process_frame
	Input.action_release(action)
	for i in 2:
		await get_tree().process_frame
