class_name Hud
extends CanvasLayer
## Interface da luta (T18): por jogador, nome, dano % grande que muda de cor e
## marcadores de KO; mais um aviso grande no centro (contagem, "MORTE SÚBITA").
## Atualiza na hora pelo sinal damage_changed e por set_kos().

const MAX_SHOWN_DAMAGE := 999
## Cores do dano: 0% branco, 50% amarelo, 100% laranja, 150% ou mais vermelho.
const DAMAGE_STOPS: Array[Array] = [
	[0.0, Color(1.0, 1.0, 1.0)],
	[50.0, Color(1.0, 0.92, 0.25)],
	[100.0, Color(1.0, 0.58, 0.12)],
	[150.0, Color(0.95, 0.16, 0.12)],
]

## Círculos de KO de um jogador: cheios os marcados, vazios os que faltam.
class KoMarkers extends Control:
	var total := 3
	var count := 0
	var color := Color.WHITE
	const SIZE := 30.0
	const GAP := 12.0

	func _init() -> void:
		mouse_filter = Control.MOUSE_FILTER_IGNORE

	func configure(new_total: int, new_color: Color) -> void:
		total = new_total
		color = new_color
		custom_minimum_size = Vector2(total * (SIZE + GAP) - GAP, SIZE)
		queue_redraw()

	func _draw() -> void:
		for i in total:
			var center := Vector2(SIZE * 0.5 + i * (SIZE + GAP), SIZE * 0.5)
			if i < count:
				draw_circle(center, SIZE * 0.5, color)
				draw_arc(center, SIZE * 0.5, 0.0, TAU, 24, Color.WHITE, 2.0, true)
			else:
				draw_arc(center, SIZE * 0.5 - 1.0, 0.0, TAU, 24, Color(1, 1, 1, 0.45), 3.0, true)

## player_id -> {name, damage, markers, fighter}
var panels := {}
var banner: Label
var ko_target := 3
var _banner_id := 0


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
	banner.set_anchors_preset(Control.PRESET_FULL_RECT)
	banner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	banner.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	banner.add_theme_font_size_override("font_size", 170)
	banner.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.9))
	banner.add_theme_constant_override("outline_size", 18)
	banner.mouse_filter = Control.MOUSE_FILTER_IGNORE
	banner.visible = false
	root.add_child(banner)


func _build_panel(pid: String, fighter: Fighter) -> Control:
	var box := PanelContainer.new()
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.06, 0.09, 0.72)
	style.border_color = fighter.body_color
	style.border_width_top = 6
	style.set_corner_radius_all(12)
	style.content_margin_left = 28
	style.content_margin_right = 28
	style.content_margin_top = 14
	style.content_margin_bottom = 16
	box.add_theme_stylebox_override("panel", style)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 0)
	v.mouse_filter = Control.MOUSE_FILTER_IGNORE
	box.add_child(v)

	var name_label := Label.new()
	name_label.text = "%s · %s" % [Game.player_label(pid), fighter.display_name]
	name_label.add_theme_font_size_override("font_size", 28)
	name_label.add_theme_color_override("font_color", fighter.body_color.lightened(0.25))
	v.add_child(name_label)

	var damage := Label.new()
	damage.add_theme_font_size_override("font_size", 104)
	damage.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.85))
	damage.add_theme_constant_override("outline_size", 10)
	damage.custom_minimum_size = Vector2(260, 0)
	v.add_child(damage)

	var markers := KoMarkers.new()
	markers.configure(ko_target, fighter.body_color.lightened(0.15))
	v.add_child(markers)

	panels[pid] = {"name": name_label, "damage": damage, "markers": markers, "fighter": fighter}
	if not fighter.damage_changed.is_connected(_on_damage_changed.bind(pid)):
		fighter.damage_changed.connect(_on_damage_changed.bind(pid))
	_show_damage(pid, fighter.damage_percent, false)
	return box


func _on_damage_changed(percent: float, pid: String) -> void:
	_show_damage(pid, percent, true)


func _show_damage(pid: String, percent: float, pop: bool) -> void:
	var label: Label = panels[pid]["damage"]
	label.text = "%d%%" % mini(roundi(percent), MAX_SHOWN_DAMAGE)
	label.add_theme_color_override("font_color", damage_color(percent))
	if pop:
		label.pivot_offset = label.size * 0.5
		label.scale = Vector2(1.3, 1.3)
		create_tween().tween_property(label, "scale", Vector2.ONE, 0.18)


## kos: player_id -> KOs marcados por esse jogador.
func set_kos(kos: Dictionary) -> void:
	for pid in panels:
		var markers: KoMarkers = panels[pid]["markers"]
		markers.count = mini(kos.get(pid, 0), ko_target)
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
	banner.pivot_offset = banner.size * 0.5
	banner.scale = Vector2(1.5, 1.5)
	create_tween().tween_property(banner, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	if duration > 0.0:
		var t := create_tween()
		t.tween_interval(duration)
		t.tween_callback(func() -> void:
			if id == _banner_id:
				hide_banner())


func hide_banner() -> void:
	_banner_id += 1
	banner.visible = false
