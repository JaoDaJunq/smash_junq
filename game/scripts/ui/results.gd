class_name ResultsScreen
extends MenuScreen
## Tela de resultado: vencedor, KOs de cada jogador, Revanche e Menu.

signal rematch_requested

const INPUT_LOCK := 0.6

var title_label: Label
var kos_label: Label
var detail_label: Label


func _ready() -> void:
	var col := build_column("", "", true)
	title_label = make_label("", 64, ACCENT)
	col.add_child(title_label)
	detail_label = make_label("", 28, Color(0.8, 0.85, 0.95))
	col.add_child(detail_label)
	kos_label = make_label("", 36)
	col.add_child(kos_label)
	var gap := Control.new()
	gap.custom_minimum_size = Vector2(0, 20)
	col.add_child(gap)
	add_button(col, "Revanche", func() -> void: rematch_requested.emit())
	add_button(col, "Menu", func() -> void: Game.go_menu())
	visible = false


## result: winner (id), winner_name, winner_character, kos {p1, p2}, labels {p1, p2}.
func show_result(result: Dictionary) -> void:
	var winner: String = result["winner"]
	title_label.text = "%s venceu!" % result["labels"][winner]
	title_label.add_theme_color_override("font_color", Game.PLAYER_COLORS[winner])
	detail_label.text = "com %s" % result["characters"][winner]
	var kos: Dictionary = result["kos"]
	var labels: Dictionary = result["labels"]
	kos_label.text = "%s  %d   x   %d  %s" % [labels["p1"], kos["p1"], kos["p2"], labels["p2"]]
	visible = true
	# Trava curta para os botões não serem apertados sem querer por quem ainda joga
	for b in buttons:
		b.disabled = true
	await get_tree().create_timer(INPUT_LOCK).timeout
	if not visible:
		return
	for b in buttons:
		b.disabled = false
	focus_first()
