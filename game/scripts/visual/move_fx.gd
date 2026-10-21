class_name MoveFx
extends Node
## Efeitos de suporte dos golpes (design/efeitos-especiais.md, rodada 8).
## Fica como filho do lutador e observa: golpe começando (quadro de impacto),
## acerto, estados (descanso, cochilo), mudanças de posição. Cada personagem tem
## uma tabela em RULES; o efeito só aparece se a folha fx_<nome>.png existir.
##   regra: {"on": "impact"|"active"|"hit"|"rest"|"move_start", "move": id,
##           "fx": nome, "at": "feet"|"front"|"target"|"head"|"center"|"behind",
##           "every": quadros (só "active"), "time": s, "char": pasta}

const RULES := {
	"juba": [
		{"on": "active", "move": "special_side", "fx": "fx_poeira_folhas", "at": "feet", "every": 4, "time": 0.4},
		{"on": "hit", "move": "special_down", "fx": "fx_ginga", "at": "target", "time": 0.45},
	],
	"seu_capivas": [
		{"on": "impact", "move": "special_down", "fx": "fx_tchibum", "at": "feet", "time": 0.55},
		{"on": "charging", "move": "special_neutral", "fx": "fx_bufada", "at": "front", "every": 18, "time": 0.4},
		{"on": "rest", "fx": "fx_boia", "at": "feet", "time": 0.0},
	],
	"maracaja": [
		{"on": "hit", "move": "special_side", "fx": "fx_garra", "at": "target", "time": 0.35},
		{"on": "hold_tick", "move": "special_side", "fx": "fx_garra", "at": "target", "every": 14, "time": 0.35},
		{"on": "during", "move": "special_down", "fx": "fx_sono", "at": "head", "every": 20, "time": 0.6},
		{"on": "cling_start", "fx": "fx_reboco", "at": "wall", "time": 0.4},
	],
	"tatu_peba": [
		{"on": "frame", "move": "special_down", "frame": 2, "fx": "fx_terra", "at": "feet", "time": 0.45},
		{"on": "frame", "move": "special_down", "frame": 12, "fx": "fx_montinho", "at": "feet", "time": 0.35},
		{"on": "impact", "move": "special_down", "fx": "fx_terra", "at": "feet", "time": 0.5},
		{"on": "impact", "move": "special_up", "fx": "fx_lufada", "at": "below", "time": 0.5, "px": 3.0},
		{"on": "shell", "fx": "fx_faisca", "at": "behind", "time": 0.3},
	],
	"sucuri": [
		{"on": "hypno", "fx": "fx_hipnose", "at": "target_head", "time": 0.7},
		{"on": "hold_tick", "move": "special_down", "fx": "fx_aperto", "at": "front", "every": 10, "time": 0.35},
	],
}

var fighter: Fighter
var who := ""
var _tex := {}
var _last_attack := ""
var _resting_fx: Node2D
var _was_cling := false
var _hold_t := 0


static func attach(f: Fighter, char_id: String) -> MoveFx:
	var m := MoveFx.new()
	m.fighter = f
	m.who = char_id
	m.name = "MoveFx"
	f.add_child(m)
	return m


func _ready() -> void:
	for r in RULES.get(who, []):
		var path := "res://assets/characters/%s/pixel/%s.png" % [r.get("char", who), r["fx"]]
		if ResourceLoader.exists(path):
			_tex[r["fx"]] = load(path)
	if fighter != null:
		fighter.hit_taken.connect(_on_hit_taken)


func _physics_process(_delta: float) -> void:
	if fighter == null or not fighter.has_art or _tex.is_empty():
		return
	var a := fighter.attack
	var id := fighter.attack_id if a != null else ""
	var f := fighter.attack_frame
	for r in RULES[who]:
		if not _tex.has(r["fx"]):
			continue
		match r["on"]:
			"impact":
				if id == r["move"] and f == a.startup:
					_spawn(r)
			"frame":
				if id == r["move"] and f == int(r["frame"]):
					_spawn(r)
			"active":
				if id == r["move"] and a.is_active(f) and f % int(r["every"]) == 0:
					_spawn(r)
			"during":   # o golpe inteiro (ex.: cochilo, que é todo antes da parte ativa)
				if id == r["move"] and f % int(r["every"]) == 2:
					_spawn(r)
			"charging":
				if id == r["move"] and fighter.has_method("charge_ratio") and fighter.charge_ratio() >= 0.0 and f % 2 == 0:
					_hold_t += 1
					if _hold_t % int(r["every"]) == 1:
						_spawn(r)
			"hold_tick":
				if id == r["move"] and fighter.holding != null:
					_hold_t += 1
					if _hold_t % int(r["every"]) == 0:
						_spawn(r, fighter.holding)
			"rest":
				_update_rest(r)
			"cling_start":
				var c: bool = fighter.has_method("is_clinging") and fighter.is_clinging()
				if c and not _was_cling:
					_spawn(r)
				_was_cling = c
	if id != _last_attack:
		_hold_t = 0
	_last_attack = id


## Acertos (gancho chamado pelo Fighter) e golpes que outros sofrem.
func on_hit_landed(target: Fighter, move_id: String) -> void:
	for r in RULES.get(who, []):
		if r["on"] == "hit" and r["move"] == move_id and _tex.has(r["fx"]):
			_spawn(r, target)


func on_hypnotized(target: Fighter) -> void:
	for r in RULES.get(who, []):
		if r["on"] == "hypno" and _tex.has(r["fx"]):
			var fx := _spawn(r, target)
			if fx != null:
				fx.set_meta("follow", target)


func on_shell_block() -> void:
	for r in RULES.get(who, []):
		if r["on"] == "shell" and _tex.has(r["fx"]):
			_spawn(r)


func _on_hit_taken(_a: Node2D, _d: AttackData, _l: Vector2) -> void:
	pass


func _update_rest(r: Dictionary) -> void:
	var resting := fighter.state == Fighter.State.RESPAWN
	if resting and _resting_fx == null:
		_resting_fx = _spawn(r)
	elif not resting and _resting_fx != null:
		if is_instance_valid(_resting_fx):
			_resting_fx.queue_free()
		_resting_fx = null
	if _resting_fx != null and is_instance_valid(_resting_fx):
		_resting_fx.global_position = _pos("feet", null)
		(_resting_fx as PixelFx).duration = 999.0


func _pos(at: String, target: Fighter) -> Vector2:
	var f := fighter
	var half := Fighter.HEIGHT * 0.5
	match at:
		# folhas de chão têm a base na linha ~58 do quadro de 64 (2x): centro 56 px acima dos pés
		"feet": return f.global_position + Vector2(0, half - 56)
		"front": return f.global_position + Vector2(f.facing * 50.0, -30)
		"behind": return f.global_position + Vector2(-f.facing * 30.0, -20)
		"head": return f.global_position + Vector2(f.facing * 20.0, -half - 10)
		"below": return f.global_position + Vector2(0, half - 10)
		"wall": return f.global_position + Vector2(f.facing * Fighter.RADIUS, -10)
		"target":
			if target != null:
				return target.global_position + Vector2(0, -20)
		"target_head":
			if target != null:
				return target.global_position + Vector2(0, -half - 24)
	return f.global_position


func _spawn(r: Dictionary, target: Fighter = null) -> PixelFx:
	var fx := PixelFx.spawn(fighter.get_parent(), _tex[r["fx"]], _pos(r["at"], target), maxf(float(r.get("time", 0.4)), 0.05), float(r.get("px", 2.0)))
	if r["at"] in ["below", "behind"] or r["fx"] == "fx_boia":
		fx.z_index = -1   # atrás do lutador
	else:
		fx.z_index = 5
	if fighter.facing < 0:
		fx.scale.x = -1.0
	return fx


func _process(_delta: float) -> void:
	# Efeitos que seguem o alvo (espiral da hipnose em cima da cabeça).
	for n in fighter.get_parent().get_children():
		if n is PixelFx and n.has_meta("follow"):
			var t = n.get_meta("follow")
			if is_instance_valid(t):
				n.global_position = (t as Fighter).global_position + Vector2(0, -Fighter.HEIGHT * 0.5 - 24)
