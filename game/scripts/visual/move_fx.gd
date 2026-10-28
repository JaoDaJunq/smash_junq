class_name MoveFx
extends Node
## Efeitos de suporte dos golpes (design/efeitos-especiais.md, rodada 8).
## Fica como filho do lutador e observa: golpe começando (quadro de impacto),
## acerto, estados (descanso, cochilo), mudanças de posição. Cada personagem tem
## uma tabela em RULES; o efeito só aparece se a folha fx_<nome>.png existir
## (ou, com a chave "draw", um desenho por código no lugar da folha que falta).
##   regra: {"on": "impact"|"active"|"hit"|"rest"|"frame"|"during"|"proj_hit"|<evento>,
##           "move": id, "fx": nome, "at": posição (ver _pos), "every": quadros,
##           "time": s, "px": escala, "char": pasta, "ground": só no chão,
##           "follow": segue o alvo, "rot": graus, "draw": desenho reserva (CodeFx),
##           "base": linha do chão na folha (posições *feet*)}
## Eventos chamados pelos personagens com event(nome, alvo): "armor", "trave",
## "ficha", "prisao", "trap", "tail", "ko"...
## play(fx, at, alvo, px, follow, time, draw) toca qualquer efeito na hora.

const RULES := {
	"juba": [
		{"on": "active", "move": "special_side", "fx": "fx_poeira_folhas", "at": "feet", "every": 4, "time": 0.4},
		{"on": "hit", "move": "special_down", "fx": "fx_ginga", "at": "target", "time": 0.45},
	],
	"seu_capivas": [
		# tchibum (pisão) e bufada (carga) saem do pesado.gd: o pisão aéreo prende o quadro de impacto
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
	# --- Rodada 10/12: os 4 novos (design/revisao/novos_personagens.md) ---
	"tucano": [
		{"on": "active", "move": "special_side", "fx": "fx_grama_peixinho", "at": "feet_behind", "base": 52, "every": 4, "time": 0.4, "ground": true},
		{"on": "impact", "move": "special_down", "fx": "fx_bico_entalado", "at": "front_feet", "base": 46, "time": 0.45, "ground": true},
		{"on": "proj_hit", "fx": "fx_pipoca_estouro", "at": "target", "time": 0.3, "px": 1.5},
		{"on": "armor", "fx": "fx_trave_tranco", "at": "center", "time": 0.25, "px": 1.5, "draw": "tranco"},
		{"on": "trave", "fx": "fx_trave_tranco", "at": "head", "time": 0.45, "draw": "estrelas", "follow": true},
	],
	"bugio": [
		{"on": "impact", "move": "special_neutral", "fx": "fx_berro", "at": "front", "time": 0.45, "draw": "berro"},
		{"on": "impact", "move": "special_up", "fx": "fx_berro", "at": "below", "time": 0.4, "rot": 90, "draw": "berro"},
		{"on": "impact", "move": "special_down", "fx": "fx_berro", "at": "center", "time": 0.35, "px": 1.5, "draw": "berro"},
	],
	"preguica": [
		# a bolha de moleza é um nó próprio (bolha_moleza.gd), desenhado por código
		{"on": "galho", "fx": "fx_galho", "at": "hang_top", "time": 0.75, "draw": "galho"},
		{"on": "cafe", "fx": "fx_cafe", "at": "mouth", "time": 0.5, "draw": "cafe"},
		{"on": "cochilo", "fx": "fx_bolha_nariz", "at": "mouth", "time": 1.0, "follow": true, "draw": "bolha_nariz"},
		{"on": "carona", "fx": "fx_moleza", "at": "target_head", "time": 0.45, "follow": true, "draw": "zzz"},
	],
	"onca": [
		{"on": "impact", "move": "special_neutral", "fx": "fx_rugido", "at": "front", "time": 0.4, "draw": "parado_ai"},
		{"on": "ficha", "fx": "fx_carimbo", "at": "target_head", "time": 0.35, "follow": true, "draw": "carimbo"},
		{"on": "prisao", "fx": "fx_algema", "at": "target", "time": 0.5},
	],
	"cutia": [
		{"on": "frame", "move": "special_down", "frame": 6, "fx": "fx_cova", "at": "feet_front", "base": 53, "time": 0.45, "ground": true},
		{"on": "active", "move": "special_side", "fx": "fx_poeira_carrinho", "at": "feet_behind", "every": 4, "time": 0.35, "ground": true, "draw": "poeira"},
		{"on": "proj_hit", "fx": "fx_saquinho_rasga", "at": "target", "time": 0.4, "px": 3.0, "draw": "rasgo"},
	],
	"calango":[
		# poeira da corrida sai do calango.gd (a corrida segura o quadro ativo enquanto acelera)
		{"on": "tail", "fx": "fx_rabo_poof", "at": "behind", "time": 0.4, "draw": "poof"},
	],
	"jacare": [
		# o anzol e a rede são nós próprios (anzol_pesca.gd, rede_pesca.gd)
		{"on": "splash", "fx": "fx_splash_rio", "at": "front_feet", "base": 58, "time": 0.4, "ground": true},
		{"on": "dente", "fx": "fx_dente", "at": "target_head", "time": 0.9, "follow": true, "draw": "estrelas"},
	],
}

var fighter: Fighter
var who := ""
var _tex := {}
var _missing := {}
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


## Folha fx_<nome> deste personagem (carrega na primeira vez); null se não existe.
func tex(fx_name: String, char_id := "") -> Texture2D:
	if _tex.has(fx_name):
		return _tex[fx_name]
	if _missing.has(fx_name):
		return null
	var path := "res://assets/characters/%s/pixel/%s.png" % [char_id if char_id != "" else who, fx_name]
	if ResourceLoader.exists(path):
		_tex[fx_name] = load(path)
		return _tex[fx_name]
	_missing[fx_name] = true
	return null


func _usable(r: Dictionary) -> bool:
	return _tex.has(r["fx"]) or r.has("draw")


func _physics_process(_delta: float) -> void:
	var rules: Array = RULES.get(who, [])
	if fighter == null or not fighter.has_art or rules.is_empty():
		return
	var a := fighter.attack
	var id := fighter.attack_id if a != null else ""
	var f := fighter.attack_frame
	for r in rules:
		if not _usable(r):
			continue
		if r.get("ground", false) and not fighter.is_on_floor():
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
		if r["on"] == "hit" and r["move"] == move_id and _usable(r):
			_spawn(r, target)


## Acerto de projétil deste lutador (gancho do Projectile).
func on_proj_hit(target: Fighter, _p: Node2D) -> void:
	event("proj_hit", target)


## Evento com nome (ver cabeçalho): toca as regras {"on": nome}.
func event(name: String, target: Fighter = null) -> Array:
	var out := []
	if fighter == null or not fighter.has_art:
		return out
	for r in RULES.get(who, []):
		if r["on"] == name and _usable(r):
			var fx := _spawn(r, target)
			if fx != null:
				out.append(fx)
	return out


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


## Toca um efeito agora. at: nome de posição (ver _pos); target: alvo das posições
## target*/seguir; draw: desenho reserva (CodeFx) se a folha não existir.
## Retorna o nó do efeito (PixelFx ou CodeFx) ou null.
func play(fx_name: String, at := "center", target: Node2D = null, px := 2.0, follow := false, time := 0.4, draw := "") -> Node2D:
	if fighter == null or not fighter.has_art:
		return null
	var r := {"fx": fx_name, "at": at, "px": px, "time": time, "follow": follow}
	if draw != "":
		r["draw"] = draw
	tex(fx_name)
	if not _usable(r):
		return null
	return _spawn(r, target)


## Toca um efeito num ponto do mundo (ex.: castanha estourando).
func play_at(fx_name: String, where: Vector2, px := 2.0, time := 0.4, draw := "") -> Node2D:
	var fx := play(fx_name, "center", null, px, false, time, draw)
	if fx != null:
		fx.global_position = where
	return fx


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


## Deslocamento de cada posição em relação ao lutador (ou ao alvo, nas target*).
func _offset(at: String) -> Vector2:
	var f := fighter
	var half := Fighter.HEIGHT * 0.5
	match at:
		# folhas de chão têm a base na linha ~58 do quadro de 64 (2x): centro 56 px acima dos pés
		"feet": return Vector2(0, half - 56)
		"feet_front": return Vector2(f.facing * 36.0, half - 56)
		"feet_behind": return Vector2(-f.facing * 34.0, half - 56)
		"front_feet": return Vector2(f.facing * 56.0, half - 56)
		"front": return Vector2(f.facing * 50.0, -30)
		"nose": return Vector2(f.facing * 56.0, -half + 14)
		"hang_top": return Vector2(0, -half - 6)   # galho onde o pendurado segura (Seu Preguiçoso)
		"mouth": return Vector2(f.facing * 20.0, -half + 22)   # focinho curto (Seu Preguiçoso)
		"behind": return Vector2(-f.facing * 30.0, -20)
		"head": return Vector2(f.facing * 20.0, -half - 10)
		"above": return Vector2(0, -half - 30)
		"below": return Vector2(0, half - 10)
		"wall": return Vector2(f.facing * Fighter.RADIUS, -10)
		"target": return Vector2(0, -20)
		"target_head": return Vector2(0, -half - 24)
		"target_eyes": return Vector2(0, -half + 24)
		"target_feet": return Vector2(0, half - 56)
	return Vector2.ZERO


func _pos(at: String, target: Node2D) -> Vector2:
	if at.begins_with("target"):
		if target != null and is_instance_valid(target):
			return target.global_position + _offset(at)
		return fighter.global_position
	return fighter.global_position + _offset(at)


func _spawn(r: Dictionary, target: Node2D = null) -> Node2D:
	var time := maxf(float(r.get("time", 0.4)), 0.05)
	var where := _pos(r["at"], target)
	if r.has("base") and String(r["at"]).contains("feet"):
		# "base": linha do chão desenhada na folha (0..63): ela cai em cima dos pés
		where.y += 56.0 - (float(r["base"]) - 32.0) * float(r.get("px", 2.0))
	var fx: Node2D
	if _tex.has(r["fx"]):
		fx = PixelFx.spawn(fighter.get_parent(), _tex[r["fx"]], where, time, float(r.get("px", 2.0)))
	elif r.has("draw"):
		fx = CodeFx.spawn(fighter.get_parent(), String(r["draw"]), where, time, float(r.get("px", 2.0)) / 2.0)
	else:
		return null
	if r["at"] in ["below", "behind", "feet_behind"] or r["fx"] == "fx_boia":
		fx.z_index = -1   # atrás do lutador
	else:
		fx.z_index = 5
	if fighter.facing < 0:
		fx.scale.x = -1.0
	if r.has("rot"):
		fx.rotation_degrees = float(r["rot"]) * (1.0 if fighter.facing > 0 else -1.0)
	if r.get("follow", false):
		var t: Node2D = target if target != null else fighter
		fx.set_meta("follow", t)
		fx.set_meta("follow_off", _offset(r["at"]) if target != null else (where - fighter.global_position))
	return fx


func _process(_delta: float) -> void:
	# Efeitos que seguem o alvo (espiral da hipnose em cima da cabeça, carimbo).
	for n in fighter.get_parent().get_children():
		if (n is PixelFx or n is CodeFx) and n.has_meta("follow"):
			var t = n.get_meta("follow")
			if is_instance_valid(t):
				var off: Vector2 = n.get_meta("follow_off") if n.has_meta("follow_off") else Vector2(0, -Fighter.HEIGHT * 0.5 - 24)
				n.global_position = (t as Node2D).global_position + off
