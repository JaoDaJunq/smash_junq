class_name CutoutRig
extends Node2D
## Boneco de recorte (cutout) de um lutador: monta as partes do rig.json como
## Sprite2D e, a cada quadro, escolhe a pose pelo estado do Fighter pai.
##
## O que deixa o movimento solto:
## - Pés no chão: no chão, o boneco sobe ou desce até o ponto mais baixo das
##   canelas encostar na base do lutador. Joelho dobrado abaixa o corpo sozinho.
## - Passada: andar e correr com contato, passagem e impulso, no ritmo da velocidade.
## - Golpes em 4 tempos: preparo com aceleração, impacto passando um pouco do
##   ponto, pausa no impacto e volta suave (opcionalmente por uma pose "seguir").
## - Partes soltas (cauda, toalha...) presas por mola: atrasam, balançam e assentam.
## - Pouso amortecido, ar com subida e queda misturadas pela velocidade, cambalhota
##   no pulo duplo (opcional) e giro quando é lançado longe.
##
## Nomes de ossos esperados (os que faltarem são ignorados):
##   tronco, cabeca, braco_frente, antebraco_frente, braco_tras, antebraco_tras,
##   coxa_frente, canela_frente, coxa_tras, canela_tras, cauda (+ extras do personagem)
##
## Opções no rig.json (todas opcionais):
##   "contato": ["canela_frente", "canela_tras"]   partes que tocam o chão
##   "passada": 1.0                                amplitude do andar/correr
##   "secundarios": {"cauda": {"ganho": 25, "max": 35, "balanço": 3}}  ossos com mola
##   "giro_pulo_duplo": true                       cambalhota no pulo duplo
##   golpes.<id>.seguir                            pose entre o golpe e o repouso

const FLOOR_Y := Fighter.HEIGHT * 0.5
const TUMBLE_SPEED := 1100.0

@export_file("*.json") var rig_path := ""
## Suavização entre poses (maior = troca mais rápida).
@export var blend_speed := 22.0
## Conferência: força uma pose pelo nome (ex.: "dor", "golpe:frente:golpe"). Vazio = automático.
var debug_pose := ""

var rig := {}
var fighter: Fighter
var _sprites := {}
var _current := {}
var _clock := 0.0
var _cycle := 0.0
var _hulls := {}        # parte de contato -> contorno convexo (pixels da textura)
var _ground_w := 0.0    # 0 = no ar (quadril fixo), 1 = pés plantados
var _land := 0.0        # amortecimento do pouso (1 -> 0)
var _flip := -1.0       # progresso da cambalhota do pulo duplo (<0 = parado)
var _springs := {}      # osso -> [ângulo, velocidade]


func _ready() -> void:
	rig = CutoutRigMath.load_rig(rig_path)
	if rig.is_empty():
		push_warning("Rig não encontrado: " + rig_path)
		return
	fighter = get_parent() as Fighter
	if fighter != null:
		fighter.has_art = true
		fighter.landed.connect(_on_landed)
		fighter.jumped.connect(_on_jumped)
	var dir := rig_path.get_base_dir()
	var contact: Array = rig.get("contato", ["canela_frente", "canela_tras"])
	for name in CutoutRigMath.draw_order(rig["partes"]):
		var p: Dictionary = rig["partes"][name]
		var s := Sprite2D.new()
		s.name = name
		s.texture = load(dir.path_join(p["arquivo"]))
		if p.has("apagar"):
			s.texture = ImageTexture.create_from_image(CutoutRigMath.erase_circles(s.texture.get_image(), p))
		s.centered = false
		# A ordem dos filhos (já ordenados por "z") define quem fica na frente.
		# Não usar z_index: valores negativos jogariam a parte para trás do cenário.
		var region := CutoutRigMath.region_in_crop(p)
		if region.size != Vector2.ZERO:
			s.region_enabled = true
			s.region_rect = region
		add_child(s)
		_sprites[name] = s
		if name in contact:
			var img := s.texture.get_image()
			if region.size != Vector2.ZERO:
				img = img.get_region(Rect2i(region))
			_hulls[name] = CutoutRigMath.opaque_hull(img)
	for bone in _secondaries():
		_springs[bone] = [0.0, 0.0]
	_apply({}, 0.0)


func _process(delta: float) -> void:
	if rig.is_empty():
		return
	_clock += delta
	var target := pose_offsets(rig, debug_pose) if debug_pose != "" else _target_pose(delta)
	if debug_pose == "" and _land > 0.0 and _planted():
		target = _crouch(target, _land * float(rig.get("pouso", 20.0)))
	_land = move_toward(_land, 0.0, delta * 5.0)
	var w := 1.0 - exp(-blend_speed * delta)
	if fighter != null and fighter.state == Fighter.State.ATTACK:
		w = 1.0 - exp(-blend_speed * 2.0 * delta)  # golpes trocam de pose mais rápido
	# Ossos que a pose nova não cita voltam para o neutro (0), em vez de ficarem presos.
	for bone in _current.keys() + target.keys():
		var from := float(_current.get(bone, 0.0))
		_current[bone] = lerpf(from, float(target.get(bone, 0.0)), w)
	var offsets := _current.duplicate()
	if debug_pose == "":
		_update_springs(delta)
		for bone in _springs:
			offsets[bone] = float(offsets.get(bone, 0.0)) + float(_springs[bone][0])
	_apply(offsets, delta)


func _apply(offsets: Dictionary, delta: float) -> void:
	var facing := fighter.facing if fighter != null else 1
	var esc: float = float(rig.get("escala", 0.15))
	var xfs := CutoutRigMath.part_transforms(rig, offsets)
	for name in _sprites:
		(_sprites[name] as Sprite2D).transform = xfs[name]
	# Altura: no ar o quadril fica fixo; no chão os pés encostam na base do lutador.
	var air_y := float(rig.get("quadril_y", 0.0)) + float(offsets.get("_sobe", 0.0))
	var planted := _planted()
	if delta <= 0.0:
		_ground_w = 1.0 if planted else 0.0
	else:
		_ground_w = lerpf(_ground_w, 1.0 if planted else 0.0, 1.0 - exp(-30.0 * delta))
	var y := air_y
	if _ground_w > 0.001 and not _hulls.is_empty():
		var ground_y := FLOOR_Y - esc * _lowest(xfs)
		y = lerpf(air_y, ground_y, _ground_w)
	rotation = _body_rotation(delta, facing)
	# Giros (cambalhota, lançado) acontecem em torno do centro do lutador, não do quadril.
	position = Vector2(0.0, y).rotated(rotation)
	scale = Vector2(esc * facing, esc)
	if fighter != null:
		var c := Color.WHITE
		if fighter.state == Fighter.State.HITSTUN and int(_clock * 20.0) % 2 == 0:
			c = Color(1.7, 1.7, 1.7)
		if fighter.invincible_time > 0.0:
			c.a = 0.45 if int(_clock * 12.0) % 2 == 0 else 0.8
		elif fighter._is_intangible():
			c.a = 0.45
		modulate = c


## Ponto mais baixo das partes de contato (coordenadas do boneco, antes da escala).
func _lowest(xfs: Dictionary) -> float:
	var lowest := -INF
	for name in _hulls:
		var xf: Transform2D = xfs[name]
		for p in _hulls[name]:
			lowest = maxf(lowest, (xf * p).y)
	return lowest


## Ponto mais baixo dos pés em coordenadas do lutador (para testes e conferência).
func lowest_contact_y() -> float:
	var lowest := -INF
	for name in _hulls:
		var xf := transform * (_sprites[name] as Sprite2D).transform
		for p in _hulls[name]:
			lowest = maxf(lowest, (xf * p).y)
	return lowest


func _planted() -> bool:
	if fighter == null or not fighter.is_on_floor():
		return false
	return fighter.state not in [Fighter.State.LEDGE, Fighter.State.HELD]


func _body_rotation(delta: float, facing: int) -> float:
	if fighter == null or delta <= 0.0:
		return 0.0
	# Cambalhota do pulo duplo
	if _flip >= 0.0:
		_flip += delta / 0.32
		if _flip >= 1.0 or fighter.is_on_floor():
			_flip = -1.0
			return 0.0
		return TAU * (1.0 - pow(1.0 - _flip, 2.0)) * facing
	# Lançado longe: gira no sentido do voo
	if fighter.state == Fighter.State.HITSTUN and not fighter.is_on_floor() and fighter.velocity.length() > TUMBLE_SPEED:
		return rotation + delta * TAU * 1.6 * signf(fighter.velocity.x if fighter.velocity.x != 0.0 else 1.0)
	return lerp_angle(rotation, 0.0, 1.0 - exp(-18.0 * delta))


func _on_landed(fall_speed: float) -> void:
	_land = clampf(fall_speed / 900.0, 0.35, 1.0)
	_flip = -1.0


func _on_jumped(in_air: bool) -> void:
	if in_air and bool(rig.get("giro_pulo_duplo", false)):
		_flip = 0.0


# --- Escolha da pose ---

func _target_pose(delta: float) -> Dictionary:
	if fighter == null:
		return pose_offsets(rig, "parado")
	var S := Fighter.State
	match fighter.state:
		S.WALK, S.RUN:
			var running := fighter.state == S.RUN
			var ref_speed := fighter.run_speed if running else fighter.walk_speed
			var pace := clampf(absf(fighter.velocity.x) / maxf(1.0, ref_speed), 0.45, 1.3)
			_cycle += delta * (14.0 if running else 8.5) * pace
			return _locomotion(running)
		S.AIR, S.RESPAWN:
			if fighter.state == S.RESPAWN:
				return _breathe(pose_offsets(rig, "pulo"), 2.0)
			# Mistura subida e queda pela velocidade vertical
			var t := smoothstep(-350.0, 450.0, fighter.velocity.y)
			return _mix(pose_offsets(rig, "pulo"), pose_offsets(rig, "queda"), t)
		S.ATTACK:
			return _attack_pose()
		S.HITSTUN, S.HELD:
			return _shake(pose_offsets(rig, "dor"), 4.0)
		S.LEDGE:
			return _breathe(pose_offsets(rig, "borda"), 2.5)
		S.SHIELD:
			return _breathe(pose_offsets(rig, "defesa"), 1.5)
		S.SHIELD_BREAK:
			return _breathe(pose_offsets(rig, "tonto"), 4.0)
		S.DODGE:
			return pose_offsets(rig, "esquiva")
		S.GRAB, S.HOLDING:
			return _breathe(pose_offsets(rig, "agarrar"), 1.5)
		S.LAG:
			return pose_offsets(rig, "agachar")
	return _breathe(pose_offsets(rig, "parado"), 2.0)


## Respiração: tronco e cabeça balançam devagar e os joelhos dobram de leve,
## o que faz o corpo subir e descer com os pés parados no chão.
func _breathe(base: Dictionary, amount: float) -> Dictionary:
	var s := sin(_clock * 3.0)
	var out := _crouch(base, (s * 0.5 + 0.5) * amount * 1.5)
	out["tronco"] = float(out.get("tronco", 0.0)) + s * amount * 0.5
	out["cabeca"] = float(out.get("cabeca", 0.0)) - s * amount * 0.8
	out["braco_frente"] = float(out.get("braco_frente", 0.0)) + s * amount * 0.6
	out["braco_tras"] = float(out.get("braco_tras", 0.0)) + s * amount * 0.4
	out["_sobe"] = float(out.get("_sobe", 0.0)) + s * amount * 0.8
	return out


## Tremida rápida (levando golpe).
func _shake(base: Dictionary, amount: float) -> Dictionary:
	var out := base.duplicate()
	var s := sin(_clock * 55.0)
	out["tronco"] = float(out.get("tronco", 0.0)) + s * amount * 0.5
	out["cabeca"] = float(out.get("cabeca", 0.0)) + s * amount
	return out


## Agacha: coxas para a frente e canelas para trás, sem tirar os pés do lugar.
static func _crouch(base: Dictionary, amount: float) -> Dictionary:
	var out := base.duplicate()
	for side in ["frente", "tras"]:
		out["coxa_" + side] = float(out.get("coxa_" + side, 0.0)) - amount
		out["canela_" + side] = float(out.get("canela_" + side, 0.0)) + amount * 2.0
	out["tronco"] = float(out.get("tronco", 0.0)) + amount * 0.35
	return out


## Passada: cada perna faz contato (esticada à frente), apoio (corpo passa por
## cima), impulso (esticada atrás) e balanço (joelho dobra e passa à frente).
## Os braços vão ao contrário das pernas. As coxas descontam a inclinação do
## tronco (as pernas são filhas dele) para os pés continuarem embaixo do corpo.
func _locomotion(running: bool) -> Dictionary:
	var out := pose_offsets(rig, "correr" if running else "andar").duplicate()
	var k := float(rig.get("passada", 1.0))
	var thigh_amp := (36.0 if running else 24.0) * k
	var knee_amp := (95.0 if running else 55.0) * k
	var arm_amp := (40.0 if running else 22.0) * k
	var lean := float(out.get("tronco", 0.0)) + sin(_cycle * 2.0) * (2.5 if running else 1.5)
	out["tronco"] = lean
	out["cabeca"] = float(out.get("cabeca", 0.0)) - sin(_cycle * 2.0) * 2.0
	for side in ["frente", "tras"]:
		var q := _cycle + (0.0 if side == "frente" else PI)
		var thigh := -sin(q) * thigh_amp
		# joelho dobra no balanço (perna indo para a frente), quase reto no apoio
		var swing := maxf(0.0, cos(q - 0.35))
		var knee := swing * swing * knee_amp + (12.0 if running else 6.0)
		if running:
			thigh -= 12.0  # corrida leva os joelhos mais à frente
		out["coxa_" + side] = float(out.get("coxa_" + side, 0.0)) * 0.3 + thigh - lean
		out["canela_" + side] = float(out.get("canela_" + side, 0.0)) * 0.3 + knee
		var arm_q := q + PI  # braço do mesmo lado vai ao contrário da perna
		var arm_name: String = "braco_" + side
		out[arm_name] = float(out.get(arm_name, 0.0)) * 0.5 - sin(arm_q) * arm_amp - lean
		var fore := -(25.0 if running else 12.0) - maxf(0.0, sin(arm_q)) * (40.0 if running else 18.0)
		out["antebraco_" + side] = fore
	return out


## Golpe em 4 tempos, seguindo os quadros do moveset:
## preparo (acelera para a pose de preparo) -> impacto (passa um pouco do ponto
## e assenta) -> pausa no golpe -> volta (pela pose "seguir", se houver).
func _attack_pose() -> Dictionary:
	var data := fighter.attack
	var id := fighter.attack_id
	var golpes: Dictionary = rig.get("golpes", {})
	var g: Dictionary = golpes.get(id, golpes.get(_family(id), {}))
	var prep: Dictionary = g.get("preparo", {})
	var hit: Dictionary = g.get("golpe", {})
	var follow: Dictionary = g.get("seguir", {})
	var rest := pose_offsets(rig, "parado")
	var f := fighter.attack_frame
	if data == null:
		return rest
	var startup := maxf(1.0, data.startup)
	var active := maxf(1.0, data.active)
	var recovery := maxf(1.0, data.recovery)
	if f <= data.startup:
		return _mix(rest, prep, ease(float(f) / startup, 0.6))
	if f <= data.startup + data.active:
		# Impacto: começa 15% além da pose do golpe e assenta nela
		var t := float(f - data.startup) / active
		return _mix(prep, hit, lerpf(1.15, 1.0, clampf(t * 2.0, 0.0, 1.0)))
	var r := float(f - data.startup - data.active) / recovery
	if r < 0.25:
		return hit  # segura o golpe um instante: dá peso
	r = (r - 0.25) / 0.75
	if not follow.is_empty():
		if r < 0.4:
			return _mix(hit, follow, smoothstep(0.0, 1.0, r / 0.4))
		return _mix(follow, rest, smoothstep(0.0, 1.0, (r - 0.4) / 0.6))
	return _mix(hit, rest, smoothstep(0.0, 1.0, r))


# --- Partes soltas com mola ---

func _secondaries() -> Dictionary:
	var out := {}
	var cfg: Dictionary = rig.get("secundarios", {"cauda": {}, "toalha": {}})
	for bone in cfg:
		if rig["partes"].has(bone):
			out[bone] = cfg[bone]
	return out


## Cada osso solto é empurrado pelo "vento" do movimento (contrário à velocidade)
## e volta por uma mola pouco amortecida, que atrasa, passa do ponto e assenta.
func _update_springs(delta: float) -> void:
	if fighter == null or delta <= 0.0:
		return
	var cfg := _secondaries()
	var wind := Vector2(-fighter.velocity.x * fighter.facing, -fighter.velocity.y) / 1000.0
	for bone in _springs:
		var c: Dictionary = cfg.get(bone, {})
		var p: Dictionary = rig["partes"][bone]
		var ang := deg_to_rad(float(p.get("repouso", 0.0)) + float(_current.get(bone, 0.0)) + float(_current.get("tronco", 0.0)))
		var d := Vector2.from_angle(ang)
		var gain := float(c.get("ganho", 25.0))
		var lim := float(c.get("max", 35.0))
		var goal := clampf(gain * d.cross(wind), -lim, lim) + sin(_clock * 2.2 + ang) * float(c.get("balanço", 3.0))
		var st: Array = _springs[bone]
		var acc := 170.0 * (goal - float(st[0])) - 11.0 * float(st[1])
		st[1] = float(st[1]) + acc * delta
		st[0] = clampf(float(st[0]) + float(st[1]) * delta, -lim * 1.5, lim * 1.5)


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


## Mistura duas poses (t pode passar de 1 para exagerar).
static func _mix(a: Dictionary, b: Dictionary, t: float) -> Dictionary:
	var out := {}
	for k in a.keys() + b.keys():
		out[k] = lerpf(float(a.get(k, 0.0)), float(b.get(k, 0.0)), t)
	return out


## Ângulos (graus) de uma pose pelo nome. "neutra" = sem nenhum ajuste.
## Golpes: "golpe:<id>:preparo", "golpe:<id>:golpe" ou "golpe:<id>:seguir".
static func pose_offsets(rig_data: Dictionary, pose_name: String) -> Dictionary:
	if pose_name.begins_with("golpe:"):
		var bits := pose_name.split(":")
		var g: Dictionary = rig_data.get("golpes", {}).get(bits[1], {})
		return g.get(bits[2] if bits.size() > 2 else "golpe", {})
	return rig_data.get("poses", {}).get(pose_name, {})
