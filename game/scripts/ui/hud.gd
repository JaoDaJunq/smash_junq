class_name Hud
extends CanvasLayer
## Interface da luta (T18): por jogador, nome, dano % grande que muda de cor e
## marcadores de KO; mais um aviso grande no centro (contagem, "MORTE SÚBITA").
## Atualiza na hora pelo sinal damage_changed e por set_kos(). Os números "estouram"
## quando o dano sobe, os marcadores de KO animam e o aviso entra com um quique.

const MAX_SHOWN_DAMAGE := 999
## Cores do dano: 0% branco, 50% amarelo, 100% laranja, 150% ou mais vermelho.
const DAMAGE_STOPS: Array[Array] = [
	[0.0, Color(1.0, 1.0, 1.0)],
	[50.0, Color(1.0, 0.92, 0.25)],
	[100.0, Color(1.0, 0.58, 0.12)],
	[150.0, Color(0.95, 0.16, 0.12)],
]
const PUNCH_TIME := 0.22
const BANNER_TIME := 0.3

## Círculos de KO de um jogador: cheios os marcados, vazios os que faltam.
## Ganhar um KO faz o círculo estourar com um anel; perder um faz ele murchar.
class KoMarkers extends Control:
	var total := 3
	var count := 0
	var color := Color.WHITE
	const SIZE := 30.0
	const GAP := 12.0
	const ANIM_TIME := 0.42

	var _gained: Array[int] = []
	var _lost: Array[int] = []
	## Progresso da animação de 0 a 1 (1 = parado).
	var _t := 1.0
	var _tween: Tween

	func _init() -> void:
		mouse_filter = Control.MOUSE_FILTER_IGNORE

	func configure(new_total: int, new_color: Color) -> void:
		total = new_total
		color = new_color
		custom_minimum_size = Vector2(total * (SIZE + GAP) - GAP, SIZE)
		queue_redraw()

	## Muda a quantidade marcada e anima só os círculos que mudaram.
	func set_count(new_count: int) -> void:
		new_count = clampi(new_count, 0, total)
		if new_count == count:
			return
		_gained.clear()
		_lost.clear()
		if new_count > count:
			for i in range(count, new_count):
				_gained.append(i)
		else:
			for i in range(new_count, count):
				_lost.append(i)
		count = new_count
		if _tween != null and _tween.is_valid():
			_tween.kill()
		if not is_inside_tree():
			_t = 1.0
			queue_redraw()
			return
		_t = 0.0
		_tween = create_tween()
		_tween.tween_method(_set_t, 0.0, 1.0, ANIM_TIME)

	func _set_t(value: float) -> void:
		_t = value
		queue_redraw()

	func _draw() -> void:
		for i in total:
			var center := Vector2(SIZE * 0.5 + i * (SIZE + GAP), SIZE * 0.5)
			var radius := SIZE * 0.5
			if i < count:
				var grow := 1.0
				if i in _gained and _t < 1.0:
					# Estoura grande e assenta com um quique; o anel se abre e some
					grow = 1.0 + 0.7 * pow(1.0 - _t, 2.0) * cos(_t * PI * 2.5)
					draw_arc(center, radius * (1.0 + 1.6 * _t), 0.0, TAU, 28, Color(1, 1, 1, 0.9 * (1.0 - _t)), 3.0, true)
				draw_circle(center, radius * grow, color)
				draw_arc(center, radius * grow, 0.0, TAU, 24, Color.WHITE, 2.0, true)
			else:
				draw_arc(center, radius - 1.0, 0.0, TAU, 24, Color(1, 1, 1, 0.45), 3.0, true)
				if i in _lost and _t < 1.0:
					# Murcha: o círculo cheio encolhe e esmaece sobre o vazio
					var fade := 1.0 - _t
					draw_circle(center, radius * (0.4 + 0.6 * fade), Color(color, 0.85 * fade))

## player_id -> {name, damage, markers, fighter, shown, tweens}
var panels := {}
var banner: Label
var ko_target := 3
var _banner_id := 0
var _banner_tween: Tween


static func damage_color(percent: float) -> Color:
	if percent <= 0.0:
		return DAMAGE_STOPS[0][1]
	for i in range(1, DAMAGE_STOPS.size()):
		var lo: Array = DAMAGE_STOPS[i - 1]
		var hi: Array = DAMAGE_STOPS[i]
		if percent <= hi[0]:
			return (lo[1] as Color).lerp(hi[1], (percent - lo[0]) / (hi[0] - lo[0]))
	return DAMAGE_STOPS[DAMAGE_STOPS.size() - 1][1]


func _ready() -> void:
	layer = 5


## Monta os painéis. fighters: player_id -> Fighter.
func setup(fighters: Dictionary, target: int) -> void:
	ko_target = target
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)

	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for side in ["left", "right", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 36)
	root.add_child(margin)
	var row := HBoxContainer.new()
	row.size_flags_vertical = Control.SIZE_SHRINK_END
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.add_child(row)
	var ids: Array = fighters.keys()
	ids.sort()
	for i in ids.size():
		if i > 0:
			var spacer := Control.new()
			spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
			row.add_child(spacer)
		var pid: String = ids[i]
		var panel := _build_panel(pid, fighters[pid])
		row.add_child(panel)

	banner = Label.new()
	banner.theme_type_variation = "BannerLabel"
	banner.set_anchors_preset(Control.PRESET_FULL_RECT)
	banner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	banner.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	banner.mouse_filter = Control.MOUSE_FILTER_IGNORE
	banner.visible = false
	root.add_child(banner)


func _build_panel(pid: String, fighter: Fighter) -> Control:
	var box := PanelContainer.new()
	box.theme_type_variation = "HudPanel"
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Faixa de cor do topo é a cor do lutador
	var style := MenuScreen.theme_shared().get_stylebox("panel", "HudPanel").duplicate() as StyleBoxFlat
	style.border_color = fighter.body_color
	box.add_theme_stylebox_override("panel", style)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 0)
	v.mouse_filter = Control.MOUSE_FILTER_IGNORE
	box.add_child(v)

	var name_label := Label.new()
	name_label.text = "%s · %s" % [Game.player_label(pid), fighter.display_name]
	name_label.add_theme_font_size_override("font_size", 30)
	name_label.add_theme_color_override("font_color", fighter.body_color.lightened(0.25))
	name_label.add_theme_color_override("font_outline_color", Color(0.03, 0.04, 0.08, 0.9))
	name_label.add_theme_constant_override("outline_size", 6)
	v.add_child(name_label)

	var damage := Label.new()
	damage.theme_type_variation = "DamageLabel"
	damage.custom_minimum_size = Vector2(260, 0)
	v.add_child(damage)

	var markers := KoMarkers.new()
	markers.configure(ko_target, fighter.body_color.lightened(0.15))
	v.add_child(markers)

	panels[pid] = {"name": name_label, "damage": damage, "markers": markers, "fighter": fighter,
		"shown": 0.0, "tweens": []}
	if not fighter.damage_changed.is_connected(_on_damage_changed.bind(pid)):
		fighter.damage_changed.connect(_on_damage_changed.bind(pid))
	_show_damage(pid, fighter.damage_percent, false)
	return box


func _on_damage_changed(percent: float, pid: String) -> void:
	_show_damage(pid, percent, true)


func _show_damage(pid: String, percent: float, pop: bool) -> void:
	var info: Dictionary = panels[pid]
	var label: Label = info["damage"]
	label.text = "%d%%" % mini(roundi(percent), MAX_SHOWN_DAMAGE)
	label.add_theme_color_override("font_color", damage_color(percent))
	var gained: float = percent - float(info["shown"])
	info["shown"] = percent
	if pop and gained > 0.0:
		_punch_damage(info, gained)
	elif gained < 0.0:
		_clear_punch(info)


## Número "estoura": escala, brilho e um tremor curto. Golpes fortes batem mais forte.
func _punch_damage(info: Dictionary, gained: float) -> void:
	var label: Label = info["damage"]
	_clear_punch(info)
	var power := clampf(gained / 25.0, 0.0, 1.0)
	var text_w := label.get_theme_font("font").get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, label.get_theme_font_size("font_size")).x
	label.pivot_offset = Vector2(minf(label.size.x, text_w) * 0.5, label.size.y * 0.5)
	label.scale = Vector2.ONE * (1.25 + 0.3 * power)
	label.modulate = Color(1.8, 1.8, 1.8)
	var pop_tween := create_tween().set_parallel(true)
	pop_tween.tween_property(label, "scale", Vector2.ONE, PUNCH_TIME).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	pop_tween.tween_property(label, "modulate", Color.WHITE, PUNCH_TIME)
	# Tremor: balança de um lado a outro e assenta
	var shake := deg_to_rad(3.0 + 4.0 * power)
	var shake_tween := create_tween()
	for k in [1.0, -0.8, 0.5, -0.25, 0.0]:
		shake_tween.tween_property(label, "rotation", shake * k, 0.035)
	info["tweens"] = [pop_tween, shake_tween]


func _clear_punch(info: Dictionary) -> void:
	for tw: Tween in info["tweens"]:
		if tw != null and tw.is_valid():
			tw.kill()
	info["tweens"] = []
	var label: Label = info["damage"]
	label.scale = Vector2.ONE
	label.rotation = 0.0
	label.modulate = Color.WHITE


## kos: player_id -> KOs marcados por esse jogador.
func set_kos(kos: Dictionary) -> void:
	for pid in panels:
		var markers: KoMarkers = panels[pid]["markers"]
		markers.set_count(mini(kos.get(pid, 0), ko_target))
		markers.queue_redraw()


func refresh_damage() -> void:
	for pid in panels:
		_show_damage(pid, panels[pid]["fighter"].damage_percent, false)


## Aviso grande no centro. duration 0 = fica até hide_banner().
func show_banner(text: String, duration := 0.0, color := Color.WHITE) -> void:
	_banner_id += 1
	var id := _banner_id
	banner.text = text
	banner.add_theme_color_override("font_color", color)
	banner.visible = true
	if _banner_tween != null and _banner_tween.is_valid():
		_banner_tween.kill()
	# Entra pequeno e transparente, passa um pouco do tamanho e assenta (quique)
	var area := banner.size if banner.size.x > 0.0 else get_viewport().get_visible_rect().size
	banner.pivot_offset = area * 0.5
	banner.scale = Vector2(0.35, 0.35)
	banner.modulate.a = 0.0
	_banner_tween = create_tween().set_parallel(true)
	_banner_tween.tween_property(banner, "scale", Vector2.ONE, BANNER_TIME).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_banner_tween.tween_property(banner, "modulate:a", 1.0, BANNER_TIME * 0.35)
	if duration > 0.0:
		var t := create_tween()
		t.tween_interval(duration)
		t.tween_callback(func() -> void:
			if id == _banner_id:
				hide_banner())


func hide_banner() -> void:
	_banner_id += 1
	if _banner_tween != null and _banner_tween.is_valid():
		_banner_tween.kill()
	banner.modulate.a = 1.0
	banner.scale = Vector2.ONE
	banner.visible = false
