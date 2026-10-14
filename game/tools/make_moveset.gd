extends SceneTree
## Gera um arquivo de moveset (.tres) a partir de uma tabela de golpes.
## Serve de ponto de partida; depois os valores são ajustados direto no .tres ou no editor.
## Rodar a partir da pasta game/:
##   godot --headless --script res://tools/make_moveset.gd -- res://data/movesets/base.tres

## Campos por golpe: startup, active, recovery, landing_lag, offset, radius,
## damage, angle, base, growth, self_velocity, helpless_after.
const BASE := {
	"jab":   [2, 2, 8, 0, Vector2(42, -15), 22.0, 3.0, 35.0, 180.0, 1.5, Vector2.ZERO, false],
	"ftilt": [6, 3, 16, 0, Vector2(55, -5), 26.0, 9.0, 35.0, 320.0, 7.0, Vector2.ZERO, false],
	"utilt": [5, 4, 14, 0, Vector2(10, -70), 30.0, 7.0, 90.0, 300.0, 6.5, Vector2.ZERO, false],
	"dtilt": [5, 3, 12, 0, Vector2(50, 40), 24.0, 6.0, 15.0, 280.0, 5.5, Vector2.ZERO, false],
	"nair":  [4, 8, 12, 8, Vector2(0, 0), 44.0, 7.0, 40.0, 280.0, 5.5, Vector2.ZERO, false],
	"fair":  [6, 4, 16, 10, Vector2(50, -5), 28.0, 9.0, 40.0, 320.0, 7.0, Vector2.ZERO, false],
	"bair":  [7, 4, 15, 10, Vector2(-50, -5), 28.0, 11.0, 155.0, 340.0, 7.5, Vector2.ZERO, false],
	"uair":  [5, 4, 13, 8, Vector2(5, -70), 30.0, 8.0, 85.0, 300.0, 6.5, Vector2.ZERO, false],
	"dair":  [10, 4, 18, 14, Vector2(0, 70), 28.0, 11.0, -80.0, 280.0, 6.0, Vector2.ZERO, false],
	"special_neutral": [12, 6, 20, 10, Vector2(60, -10), 32.0, 10.0, 40.0, 340.0, 7.0, Vector2.ZERO, false],
	"special_side":    [10, 8, 20, 12, Vector2(45, -5), 30.0, 8.0, 30.0, 320.0, 6.0, Vector2(700, 0), false],
	"special_up":      [4, 12, 20, 16, Vector2(0, -50), 34.0, 6.0, 80.0, 300.0, 5.0, Vector2(0, -1050), true],
	"special_down":    [8, 6, 22, 12, Vector2(0, 40), 50.0, 9.0, 60.0, 320.0, 6.5, Vector2.ZERO, false],
}

const FIELDS := ["startup", "active", "recovery", "landing_lag", "hitbox_offset", "hitbox_radius",
	"damage", "angle", "base_knockback", "knockback_growth", "self_velocity", "helpless_after"]


func _init() -> void:
	var args := OS.get_cmdline_user_args()
	var path: String = args[0] if args.size() > 0 else "res://data/movesets/base.tres"
	var moveset := Moveset.new()
	for move_id in BASE:
		var data := AttackData.new()
		data.id = move_id
		for i in FIELDS.size():
			data.set(FIELDS[i], BASE[move_id][i])
		moveset.set(move_id, data)
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(path.get_base_dir()))
	var err := ResourceSaver.save(moveset, path)
	print("Moveset salvo em %s: %s" % [path, error_string(err)])
	quit(err)
