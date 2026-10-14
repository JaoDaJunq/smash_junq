class_name TrainingMode
extends Node
## Modo treino: o P2 é um boneco configurável, a partida não acaba e um quadro
## mostra os números do último golpe (dano, lançamento, distância). A pausa abre
## o painel de treino no lugar do menu de pausa. Cada golpe é registrado em
## user://playtest/treino.jsonl para calibrar a força dos golpes.

const DAMAGE_STEP := 10
const DAMAGE_MAX := 300

var match_manager: Node
var player: Fighter
var dummy: Fighter
var brain: DummyBrain

## Dano com que o boneco começa (e volta, se "manter dano" estiver ligado).
var dummy_damage := 0
var lock_damage := false
var show_hitboxes := false

## Último golpe no boneco.
var last_hit := {}
var _hit_origin := Vector2.ZERO
var _tracking := false
var _track_time := 0.0

var _info: Label
var _panel: PanelContainer
var _buttons: Array[Button] = []
var _layer: CanvasLayer


func setup(manager: Node, p1: Fighter, p2: Fighter) -> void:
	match_manager = manager
	player = p1
	dummy = p2
	brain = DummyBrain.new()
	dummy.set_cpu(brain)
	dummy.hit_taken.connect(_on_dummy_hit)
	_build_ui()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# --- Golpes no boneco ---

func _on_dummy_hit(attacker: Node2D, data: AttackData, launch: Vector2) -> void:
	_finish_tracking()
	var move := data.id
	if move == "" and attacker is Fighter:
		move = (attacker as Fighter).attack_id
	last_hit = {
		"golpe": move,
		"atacante": (attacker as Fighter).display_name if attacker is Fighter else "?",
		"alvo": dummy.display_name,
		"dano_golpe": data.damage,
		"dano_boneco": snappedf(dummy.damage_percent, 0.1),
		"lancamento": roundi(launch.length()),
		"distancia": 0,
		"ko": false,
	}
	_hit_origin = dummy.global_position
	_tracking = true
	_track_time = 0.0
	_refresh_info()


func _physics_process(delta: float) -> void:
	if get_tree().paused or dummy == null:
		return
	if _tracking:
		_track_time += delta
		var dist := roundi(dummy.global_position.distance_to(_hit_origin))
		if dist > int(last_hit.get("distancia", 0)):
			last_hit["distancia"] = dist
			_refresh_info()
		var settled := dummy.state != Fighter.State.HITSTUN and dummy.is_on_floor()
		if settled or _track_time > 4.0:
			_finish_tracking()
	if lock_damage and dummy.state != Fighter.State.HITSTUN and not is_equal_approx(dummy.damage_percent, float(dummy_damage)):
		dummy.add_damage(float(dummy_damage) - dummy.damage_percent)


func _finish_tracking() -> void:
	if not _tracking:
		return
	_tracking = false
	PlaytestLog.append("treino.jsonl", last_hit.duplicate())


## Chamado pela partida quando o boneco sai da arena.
func on_dummy_ko() -> void:
	if not last_hit.is_empty():
		last_hit["ko"] = true
		_finish_tracking()
		_refresh_info()


## Chamado pela partida depois de o boneco voltar à arena.
func on_dummy_respawned() -> void:
	if dummy_damage > 0:
		dummy.add_damage(float(dummy_damage) - dummy.damage_percent)


func reset_positions() -> void:
	_finish_tracking()
	get_tree().call_group("match_cleanup", "queue_free")
	for f in [player, dummy]:
		f.spawn_point = match_manager._start_positions[f.player_id]
		f.respawn()
		f.facing = 1 if f == player else -1
	dummy.add_damage(float(dummy_damage))


# --- Painel (abre com a pausa) ---

func _process(_delta: float) -> void:
	for p in ["p1", "p2"]:
		if Input.is_action_just_pressed(p + "_pause"):
			toggle_panel()
			return


func toggle_panel() -> void:
	if _panel.visible:
		close_panel()
	else:
		open_panel()


func open_panel() -> void:
	_refresh_buttons()
	_panel.visible = true
	get_tree().paused = true
	Sfx.play("ui_confirm")
	_buttons[0].grab_focus()


func close_panel() -> void:
	_panel.visible = false
	get_tree().paused = false
	Sfx.play("ui_back")


func _input(event: InputEvent) -> void:
	if not _panel.visible:
		return
	var focused := get_viewport().gui_get_focus_owner()
	var step := 0
	if event.is_action_pressed("ui_left") or event.is_action_pressed("p1_left"):
		step = -1
	elif event.is_action_pressed("ui_right") or event.is_action_pressed("p1_right"):
		step = 1
	if step != 0 and focused is Button and focused.has_meta("adjust"):
		(focused.get_meta("adjust") as Callable).call(step)
		_refresh_buttons()
		Sfx.play("ui_move")
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("ui_cancel"):
		close_panel()
		get_viewport().set_input_as_handled()


func change_behavior(step: int) -> void:
	var n := DummyBrain.BEHAVIOR_NAMES.size()
	var next := (int(brain.behavior) + step + n) % n
	brain.behavior = next as DummyBrain.Behavior


func change_damage(step: int) -> void:
	dummy_damage = clampi(dummy_damage + step * DAMAGE_STEP, 0, DAMAGE_MAX)
	dummy.add_damage(float(dummy_damage) - dummy.damage_percent)


func toggle_lock(_step := 1) -> void:
	lock_damage = not lock_damage


func toggle_hitboxes(_step := 1) -> void:
	show_hitboxes = not show_hitboxes
	for f in [player, dummy]:
		f.show_debug_label = show_hitboxes


func _build_ui() -> void:
	_layer = CanvasLayer.new()
	_layer.layer = 30
	_layer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_layer)

	_info = Label.new()
	_info.theme_type_variation = "HintLabel"
	_info.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_info.set_anchors_and_offsets_preset(Control.PRESET_CENTER_TOP)
	_info.position = Vector2(-560, 24)
	_info.size = Vector2(1120, 90)
	_info.add_theme_font_size_override("font_size", 26)
	_layer.add_child(_info)
	_refresh_info()

	_panel = PanelContainer.new()
	_panel.visible = false
	_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	_panel.custom_minimum_size = Vector2(760, 0)
	_panel.position = Vector2(-380, -330)
	_layer.add_child(_panel)
	var col := VBoxContainer.new()
	col.add_theme_constant_override("separation", 14)
	_panel.add_child(col)
	var title := Label.new()
	title.text = "Treino"
	title.theme_type_variation = "TitleLabel"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	col.add_child(title)
	var hint := Label.new()
	hint.text = "Esquerda/Direita muda os valores · Pausa fecha"
	hint.theme_type_variation = "HintLabel"
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	col.add_child(hint)
	_add_button(col, "continuar", func() -> void: close_panel())
	_add_button(col, "boneco", func() -> void: change_behavior(1), change_behavior)
	_add_button(col, "dano", func() -> void: change_damage(1), change_damage)
	_add_button(col, "manter", func() -> void: toggle_lock(), toggle_lock)
	_add_button(col, "areas", func() -> void: toggle_hitboxes(), toggle_hitboxes)
	_add_button(col, "posicoes", func() -> void:
		reset_positions()
		close_panel())
	_add_button(col, "personagens", func() -> void: Game.go_to(Game.SELECT_SCENE))
	_add_button(col, "sair", func() -> void: Game.go_menu())
	_refresh_buttons()


func _add_button(col: VBoxContainer, key: String, on_press: Callable, adjust := Callable()) -> void:
	var b := Button.new()
	b.name = key
	b.focus_mode = Control.FOCUS_ALL
	b.process_mode = Node.PROCESS_MODE_ALWAYS
	b.pressed.connect(func() -> void:
		on_press.call()
		_refresh_buttons()
		Sfx.play("ui_confirm"))
	if adjust.is_valid():
		b.set_meta("adjust", adjust)
	col.add_child(b)
	_buttons.append(b)


func _refresh_buttons() -> void:
	var texts := {
		"continuar": "Continuar",
		"boneco": "Boneco: « %s »" % DummyBrain.BEHAVIOR_NAMES[brain.behavior],
		"dano": "Dano do boneco: « %d%% »" % dummy_damage,
		"manter": "Manter esse dano: %s" % ("Sim" if lock_damage else "Não"),
		"areas": "Mostrar áreas de acerto: %s" % ("Sim" if show_hitboxes else "Não"),
		"posicoes": "Recomeçar posições",
		"personagens": "Trocar personagens",
		"sair": "Sair para o menu",
	}
	for b in _buttons:
		b.text = texts[b.name]


func _refresh_info() -> void:
	if _info == null:
		return
	if last_hit.is_empty():
		_info.text = "TREINO · Acerte o boneco para ver os números do golpe · Pausa abre as opções"
		return
	_info.text = "Golpe: %s (%s)   ·   Dano do boneco: %.0f%%   ·   Lançamento: %d px/s   ·   Distância: %d px%s" % [
		last_hit["golpe"], last_hit["atacante"], last_hit["dano_boneco"], last_hit["lancamento"],
		last_hit["distancia"], "   ·   KO!" if last_hit["ko"] else ""]
