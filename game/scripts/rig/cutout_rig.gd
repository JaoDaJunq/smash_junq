class_name CutoutRig
extends Node2D
## Boneco de recorte (cutout) de um lutador: monta as partes do rig.json como
## Sprite2D e, a cada quadro, escolhe a pose pelo estado do Fighter pai. Andar e
## correr são gerados por código; golpes, reações e demais poses vêm do rig.json.
## Os golpes seguem os quadros do moveset: preparo no início, golpe nos quadros
## ativos e volta ao normal na recuperação.
##
## Nomes de ossos esperados (os que faltarem são ignorados):
##   tronco, cabeca, braco_frente, antebraco_frente, braco_tras, antebraco_tras,
##   coxa_frente, canela_frente, coxa_tras, canela_tras, cauda (+ extras do personagem)

@export_file("*.json") var rig_path := ""
## Suavização entre poses (maior = troca mais rápida).
@export var blend_speed := 22.0

var rig := {}
var fighter: Fighter
var _sprites := {}
var _current := {}
var _clock := 0.0
var _cycle := 0.0


func _ready() -> void:
	rig = CutoutRigMath.load_rig(rig_path)
	if rig.is_empty():
		push_warning("Rig não encontrado: " + rig_path)
		return
	fighter = get_parent() as Fighter
	if fighter != null:
		fighter.has_art = true
	var dir := rig_path.get_base_dir()
	for name in CutoutRigMath.draw_order(rig["partes"]):
		var p: Dictionary = rig["partes"][name]
		var s := Sprite2D.new()
		s.name = name
		s.texture = load(dir.path_join(p["arquivo"]))
		s.centered = false
		s.z_index = int(p.get("z", 0))
		var region := CutoutRigMath.region_in_crop(p)
		if region.size != Vector2.ZERO:
			s.region_enabled = true
			s.region_rect = region
		add_child(s)
		_sprites[name] = s
	_apply({})


func _process(delta: float) -> void:
	if rig.is_empty():
		return
	_clock += delta
	var target := _target_pose(delta)
	var w := 1.0 - exp(-blend_speed * delta)
	if fighter != null and fighter.state == Fighter.State.ATTACK:
		w = 1.0 - exp(-blend_speed * 2.0 * delta)  # golpes trocam de pose mais rápido
	for bone in _all_bones(target):
		var from := float(_current.get(bone, 0.0))
		_current[bone] = lerpf(from, float(target.get(bone, 0.0)), w)
	_apply(_current)


func _apply(offsets: Dictionary) -> void:
	var facing := fighter.facing if fighter != null else 1
	var esc: float = float(rig.get("escala", 0.15))
	position = Vector2(0.0, float(rig.get("quadril_y", 0.0)) + float(offsets.get("_sobe", 0.0)))
	scale = Vector2(esc * facing, esc)
	var xfs := CutoutRigMath.part_transforms(rig, offsets)
	for name in _sprites:
		(_sprites[name] as Sprite2D).transform = xfs[name]
	if fighter != null:
		var c := Color.WHITE
		if fighter.state == Fighter.State.HITSTUN and int(_clock * 20.0) % 2 == 0:
			c = Color(1.7, 1.7, 1.7)
		if fighter.invincible_time > 0.0:
			c.a = 0.45 if int(_clock * 12.0) % 2 == 0 else 0.8
		elif fighter._is_intangible():
			c.a = 0.45
		modulate = c


# --- Escolha da pose ---

func _target_pose(delta: float) -> Dictionary:
	if fighter == null:
		return pose_offsets(rig, "parado")
	var S := Fighter.State
	match fighter.state:
		S.WALK, S.RUN:
			var running := fighter.state == S.RUN
			_cycle += delta * (13.0 if running else 8.0)
			return _locomotion(running)
		S.AIR, S.RESPAWN:
			if fighter.state == S.RESPAWN or fighter.velocity.y < 0.0:
				return pose_offsets(rig, "pulo")
			return pose_offsets(rig, "queda")
		S.ATTACK:
			return _attack_pose()
		S.HITSTUN, S.HELD:
			return pose_offsets(rig, "dor")
		S.LEDGE:
			return pose_offsets(rig, "borda")
		S.SHIELD:
			return pose_offsets(rig, "defesa")
		S.SHIELD_BREAK:
			return _breathe(pose_offsets(rig, "tonto"), 3.0)
		S.DODGE:
			return pose_offsets(rig, "esquiva")
		S.GRAB, S.HOLDING:
			return pose_offsets(rig, "agarrar")
		S.LAG:
			return pose_offsets(rig, "agachar")
	return _breathe(pose_offsets(rig, "parado"), 2.0)


## Respiração: tronco e cabeça balançam devagar.
func _breathe(base: Dictionary, amount: float) -> Dictionary:
	var out := base.duplicate()
	var s := sin(_clock * 3.0)
	out["tronco"] = float(out.get("tronco", 0.0)) + s * amount * 0.5
	out["cabeca"] = float(out.get("cabeca", 0.0)) - s * amount
	out["_sobe"] = float(out.get("_sobe", 0.0)) + s * amount * 0.8
	return out


## Andar e correr gerados por código: pernas e braços em oposição.
func _locomotion(running: bool) -> Dictionary:
	var out := pose_offsets(rig, "correr" if running else "andar").duplicate()
	var amp := 34.0 if running else 22.0
	var s := sin(_cycle)
	var add := {
		"coxa_frente": s * amp, "coxa_tras": -s * amp,
		"canela_frente": maxf(0.0, -s) * amp * 1.3, "canela_tras": maxf(0.0, s) * amp * 1.3,
		"braco_frente": -s * amp * 0.8, "braco_tras": s * amp * 0.8,
		"antebraco_frente": -10.0, "antebraco_tras": -10.0,
		"cauda": sin(_cycle * 0.5) * 8.0,
	}
	for k in add:
		out[k] = float(out.get(k, 0.0)) + add[k]
	out["_sobe"] = float(out.get("_sobe", 0.0)) - absf(cos(_cycle)) * (3.0 if running else 1.5)  # pixels do jogo
	return out


## Golpe: preparo no início, pose do golpe nos quadros ativos, volta na recuperação.
func _attack_pose() -> Dictionary:
	var data := fighter.attack
	var id := fighter.attack_id
	var golpes: Dictionary = rig.get("golpes", {})
	var g: Dictionary = golpes.get(id, golpes.get(_family(id), {}))
	var prep: Dictionary = g.get("preparo", {})
	var hit: Dictionary = g.get("golpe", {})
	var rest := pose_offsets(rig, "parado")
	var f := fighter.attack_frame
	if data == null:
		return rest
	if f <= data.startup:
		return _mix(rest, prep, float(f) / maxf(1.0, data.startup))
	if f <= data.startup + data.active:
		return hit
	return _mix(hit, rest, float(f - data.startup - data.active) / maxf(1.0, data.recovery))


## Família do golpe, usada quando o personagem não tem pose própria para ele.
static func _family(id: String) -> String:
	match id:
		"jab", "ftilt", "fair", "special_side":
			return "frente"
		"utilt", "uair", "special_up":
			return "cima"
		"dtilt", "dair", "special_down":
			return "baixo"
		"bair":
			return "tras"
		"nair":
			return "giro"
		"special_neutral":
			return "frente"
	return "frente"


static func _mix(a: Dictionary, b: Dictionary, t: float) -> Dictionary:
	var out := {}
	for k in _all_bones(a).filter(func(x): return true) + _all_bones(b):
		out[k] = lerpf(float(a.get(k, 0.0)), float(b.get(k, 0.0)), clampf(t, 0.0, 1.0))
	return out


static func _all_bones(d: Dictionary) -> Array:
	return d.keys()


## Ângulos (graus) de uma pose pelo nome. "neutra" = sem nenhum ajuste.
## Golpes: "golpe:<id>:preparo" ou "golpe:<id>:golpe" (para a ferramenta de conferência).
static func pose_offsets(rig_data: Dictionary, pose_name: String) -> Dictionary:
	if pose_name.begins_with("golpe:"):
		var bits := pose_name.split(":")
		var g: Dictionary = rig_data.get("golpes", {}).get(bits[1], {})
		return g.get(bits[2] if bits.size() > 2 else "golpe", {})
	return rig_data.get("poses", {}).get(pose_name, {})
