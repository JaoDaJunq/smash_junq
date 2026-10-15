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
##   ponto, pausa no impacto e volta suave (opcionalmente por uma pose "seguir"),
##   com rastro (smear) na ponta do membro que mais se move.
## - Amassa e estica com mola: pouso, pulo, arrancada, impacto do golpe e pancada.
## - Partes soltas (cauda, toalha...) presas por mola: atrasam, balançam e assentam.
## - Rosto com expressões que trocam pelo estado (bravo, grito, dor, susto...),
##   piscando de vez em quando.
## - Pouso amortecido, ar inclinado pela velocidade, cambalhota no pulo duplo
##   (opcional), giro quando é lançado longe, virada com "giro" de corpo, ginga parado.
##
## Nomes de ossos esperados (os que faltarem são ignorados):
##   tronco, cabeca, braco_frente, antebraco_frente, braco_tras, antebraco_tras,
##   coxa_frente, canela_frente, coxa_tras, canela_tras, cauda (+ extras do personagem)
##
## Opções no rig.json (todas opcionais):
##   "contato": ["canela_frente", "canela_tras"]   partes que tocam o chão (ou pe_*)
##   "escurecer_tras": 1.0                         tom dos membros de trás (0.8 = mais escuro)
##   "passada": 1.0                                amplitude do andar/correr
##   "ginga": 0                                    balanço de capoeira parado (graus)
##   "pouso": 20                                   quanto agacha ao pousar (graus)
##   "secundarios": {"cauda": {"ganho": 25, "max": 35, "balanço": 3}}  ossos com mola
##   "giro_pulo_duplo": true                       cambalhota no pulo duplo
##   "cor_rastro": [1, 0.95, 0.8]                  cor do rastro dos golpes
##   "expressoes": {"neutro": {...}, "piscar", "bravo", "grito", "dor", "nocaute",
##                  "susto", "vitoria"}           rostos (tools/alinhar_cabecas.gd)
##   golpes.<id>.seguir                            pose entre o golpe e o repouso

const FLOOR_Y := Fighter.HEIGHT * 0.5
const TUMBLE_SPEED := 1100.0
const TRAIL_PARTS := ["antebraco_frente", "antebraco_tras", "canela_frente", "canela_tras",
	"mao_frente", "mao_tras", "pe_frente", "pe_tras"]
const TRAIL_MAX := 9

static var _hull_cache := {}  # caminho da imagem -> contorno convexo

@export_file("*.json") var rig_path := ""
## Suavização entre poses (maior = troca mais rápida).
@export var blend_speed := 22.0
## Conferência: força uma pose pelo nome (ex.: "dor", "golpe:frente:golpe"). Vazio = automático.
var debug_pose := ""
## Expressão do rosto mostrada agora ("" se o boneco não tem expressões).
var expression := ""

var rig := {}
var fighter: Fighter
var _sprites := {}
var _current := {}
var _clock := 0.0
var _cycle := 0.0
var _hulls := {}        # parte de contato -> contorno convexo (pixels da textura)
var _tips := {}         # parte -> ponta (pixels da textura), para o rastro
var _faces := {}        # expressão -> textura
var _ground_w := 0.0    # 0 = no ar (quadril fixo), 1 = pés plantados
var _land := 0.0        # amortecimento do pouso (1 -> 0)
var _flip := -1.0       # progresso da cambalhota do pulo duplo (<0 = parado)
var _springs := {}      # osso -> [ângulo, velocidade]
var _squash := 0.0      # >0 amassa (largo e baixo), <0 estica
var _squash_v := 0.0
var _turn := 0.0        # virada de lado (1 -> 0)
var _dash := 0.0        # arrancada (1 -> 0)
var _recoil := 0.0      # tranco de pancada (1 -> 0)
var _last_facing := 0
var _last_phase := ""
var _blink := 2.5       # segundos até a próxima piscada (negativo = piscando)
var _mood := ""
var _mood_time := 0.0
var _trail: Line2D
var _trail_part := ""
var _trail_pts: Array[Vector2] = []
var _attack_seen := -1


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
		fighter.dashed.connect(_on_dashed)
		fighter.hit_taken.connect(_on_hit)
		_last_facing = fighter.facing
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
		# Membros de trás um pouco mais escuros: dá profundidade.
		if name.ends_with("_tras"):
			var k := float(rig.get("escurecer_tras", 1.0))
			s.self_modulate = Color(k, k, k)
		add_child(s)
		_sprites[name] = s
		if name in contact or name in TRAIL_PARTS:
			var hull := _hull_of(dir.path_join(p["arquivo"]) + str(p.get("apagar", "")) + str(region), s.texture, region)
			if name in contact:
				_hulls[name] = hull
			if name in TRAIL_PARTS:
				_tips[name] = _far_point(hull, p, region)
	for face in rig.get("expressoes", {}):
		_faces[face] = load(dir.path_join(rig["expressoes"][face]["arquivo"]))
	if not _faces.is_empty():
		_set_expression(_faces.keys()[0])
	for bone in _secondaries():
		_springs[bone] = [0.0, 0.0]
	_trail = Line2D.new()
	_trail.name = "Rastro"
	_trail.top_level = true  # pontos em coordenadas do mundo
	_trail.width = 20.0
	_trail.joint_mode = Line2D.LINE_JOINT_ROUND
	_trail.begin_cap_mode = Line2D.LINE_CAP_ROUND
	_trail.end_cap_mode = Line2D.LINE_CAP_ROUND
	var taper := Curve.new()
	taper.add_point(Vector2(0, 0))
	taper.add_point(Vector2(1, 1))
	_trail.width_curve = taper
	var col: Array = rig.get("cor_rastro", [1.0, 0.96, 0.82])
	var grad := Gradient.new()
	grad.set_color(0, Color(col[0], col[1], col[2], 0.0))
	grad.set_color(1, Color(col[0], col[1], col[2], 0.85))
	_trail.gradient = grad
	add_child(_trail)
	_apply({}, 0.0)


## Contorno convexo de uma textura, guardado para não recalcular (é lento).
static func _hull_of(key: String, tex: Texture2D, region: Rect2) -> PackedVector2Array:
	if not _hull_cache.has(key):
		var img := tex.get_image()
		if region.size != Vector2.ZERO:
			img = img.get_region(Rect2i(region))
		_hull_cache[key] = CutoutRigMath.opaque_hull(img, 3)
	return _hull_cache[key]


## Ponto do contorno mais distante do pivô na direção do osso (mão, pé).
static func _far_point(hull: PackedVector2Array, p: Dictionary, region: Rect2) -> Vector2:
	var top_left := Vector2(p["origem"][0], p["origem"][1])
	if region.size != Vector2.ZERO:
		top_left += region.position
	var pivot := Vector2(p["pivo"][0], p["pivo"][1]) - top_left
	var dir := (Vector2(p["ponta"][0], p["ponta"][1]) - Vector2(p["pivo"][0], p["pivo"][1])).normalized()
	var best := pivot
	var best_d := -INF
	for q in hull:
		var d := (q - pivot).dot(dir)
		if d > best_d:
			best_d = d
			best = q
	return best


func _process(delta: float) -> void:
	if rig.is_empty():
		return
	_clock += delta
	var target := pose_offsets(rig, debug_pose) if debug_pose != "" else _target_pose(delta)
	if debug_pose == "":
		target = _accents(target, delta)
		target = _level_feet(target)
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
		_update_squash(delta)
		_update_face(delta)
	_apply(offsets, delta)
	if debug_pose == "":
		_update_trail()


## Pés (se o boneco tiver): a sola fica paralela ao chão quando está apoiado,
## descontando a inclinação do tronco, da coxa e da canela. No ar, pendem um pouco.
func _level_feet(target: Dictionary) -> Dictionary:
	var k := 1.0 if _planted() else 0.5
	for side in ["frente", "tras"]:
		var foot: String = "pe_" + side
		if not _sprites.has(foot) or target.has(foot):
			continue
		var lean := float(target.get("tronco", 0.0)) + float(target.get("coxa_" + side, 0.0)) + float(target.get("canela_" + side, 0.0))
		target[foot] = -lean * k
	return target


## Acentos por cima da pose: pouso, arrancada e tranco de pancada.
func _accents(target: Dictionary, delta: float) -> Dictionary:
	var out := target
	if _land > 0.0 and _planted():
		out = _crouch(out, _land * float(rig.get("pouso", 20.0)))
	if _dash > 0.0:
		out = _crouch(out, _dash * 10.0)
		out["tronco"] = float(out.get("tronco", 0.0)) + _dash * 12.0
	if _recoil > 0.0:
		out["tronco"] = float(out.get("tronco", 0.0)) - _recoil * 18.0
		out["cabeca"] = float(out.get("cabeca", 0.0)) - _recoil * 14.0
	_land = move_toward(_land, 0.0, delta * 5.0)
	_dash = move_toward(_dash, 0.0, delta * 4.0)
	_recoil = move_toward(_recoil, 0.0, delta * 3.0)
	_turn = move_toward(_turn, 0.0, delta * 8.0)
	_mood_time = maxf(0.0, _mood_time - delta)
	return out


func _apply(offsets: Dictionary, delta: float) -> void:
	var facing := fighter.facing if fighter != null else 1
	if facing != _last_facing and delta > 0.0:
		_turn = 1.0
	_last_facing = facing
	var esc: float = float(rig.get("escala", 0.15))
	var variants := {}
	if expression != "":
		variants["cabeca"] = rig["expressoes"][expression]
	var xfs := CutoutRigMath.part_transforms(rig, offsets, variants)
	for name in _sprites:
		(_sprites[name] as Sprite2D).transform = xfs[name]
	# Amassar/esticar mantém o volume; a virada estreita o corpo por um instante.
	var sx := (1.0 + _squash) * (1.0 - 0.2 * _turn)
	var sy := 1.0 - _squash
	if debug_pose != "":
		sx = 1.0
		sy = 1.0
	# Altura: no ar o quadril fica fixo; no chão os pés encostam na base do lutador.
	var air_y := float(rig.get("quadril_y", 0.0)) + float(offsets.get("_sobe", 0.0))
	var planted := _planted()
	if delta <= 0.0:
		_ground_w = 1.0 if planted else 0.0
	else:
		_ground_w = lerpf(_ground_w, 1.0 if planted else 0.0, 1.0 - exp(-30.0 * delta))
	var y := air_y
	if _ground_w > 0.001 and not _hulls.is_empty():
		var ground_y := FLOOR_Y - esc * sy * _lowest(xfs)
		y = lerpf(air_y, ground_y, _ground_w)
	rotation = _body_rotation(delta, facing)
	# Giros (cambalhota, lançado) acontecem em torno do centro do lutador, não do quadril.
	position = Vector2(0.0, y).rotated(rotation)
	scale = Vector2(esc * facing * sx, esc * sy)
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
	if _tumbling():
		return rotation + delta * TAU * 1.6 * signf(fighter.velocity.x if fighter.velocity.x != 0.0 else 1.0)
	return lerp_angle(rotation, 0.0, 1.0 - exp(-18.0 * delta))


func _tumbling() -> bool:
	return fighter.state == Fighter.State.HITSTUN and not fighter.is_on_floor() and fighter.velocity.length() > TUMBLE_SPEED


# --- Amassar e esticar ---

func _kick_squash(amount: float) -> void:
	_squash_v += amount * 14.0


func _update_squash(delta: float) -> void:
	if delta <= 0.0:
		return
	# Mola pouco amortecida: dá um "boing" e assenta.
	var acc := -320.0 * _squash - 16.0 * _squash_v
	_squash_v += acc * delta
	_squash = clampf(_squash + _squash_v * delta, -0.22, 0.22)
	# Golpe: estica no impacto
	if fighter != null and fighter.state == Fighter.State.ATTACK and fighter.attack != null:
		var phase := _attack_phase()
		if phase != _last_phase and phase == "ativo":
			_kick_squash(-0.10)
		_last_phase = phase
	else:
		_last_phase = ""


func _attack_phase() -> String:
	var f := fighter.attack_frame
	if f <= fighter.attack.startup:
		return "preparo"
	if f <= fighter.attack.startup + fighter.attack.active:
		return "ativo"
	return "volta"


func _on_landed(fall_speed: float) -> void:
	_land = clampf(fall_speed / 900.0, 0.35, 1.0)
	_flip = -1.0
	_kick_squash(0.06 + 0.12 * _land)


func _on_jumped(in_air: bool) -> void:
	_kick_squash(-0.10 if not in_air else -0.06)
	if in_air and bool(rig.get("giro_pulo_duplo", false)):
		_flip = 0.0


func _on_dashed() -> void:
	_dash = 1.0
	_kick_squash(0.06)


func _on_hit(_attacker: Node2D, _data: AttackData, launch: Vector2) -> void:
	_recoil = clampf(launch.length() / 900.0, 0.4, 1.0)
	_kick_squash(0.12)


# --- Rosto ---

## Força uma expressão por um tempo (ex.: "vitoria" ao fazer um KO).
func set_mood(face: String, seconds := 1.5) -> void:
	_mood = face
	_mood_time = seconds


func _set_expression(face: String) -> void:
	if not _faces.has(face) or face == expression:
		return
	expression = face
	var s := _sprites.get("cabeca") as Sprite2D
	if s != null:
		s.texture = _faces[face]
		s.region_enabled = false


func _update_face(delta: float) -> void:
	if _faces.is_empty():
		return
	_blink -= delta
	if _blink < -0.13:
		_blink = randf_range(2.0, 4.5)
	_set_expression(_pick_face())


func _pick_face() -> String:
	if _mood_time > 0.0 and _faces.has(_mood):
		return _mood
	if fighter == null:
		return "neutro"
	var S := Fighter.State
	match fighter.state:
		S.ATTACK:
			if fighter.attack != null:
				var phase := _attack_phase()
				if phase == "ativo" or (phase == "volta" and fighter.attack_frame <= fighter.attack.startup + fighter.attack.active + 4):
					return "grito"
			return "bravo"
		S.HITSTUN, S.HELD:
			return "nocaute" if _tumbling() else "dor"
		S.SHIELD_BREAK:
			return "nocaute"
		S.LEDGE:
			return "susto"
		S.SHIELD, S.GRAB, S.HOLDING:
			return "bravo"
		S.RUN:
			if _dash > 0.3:
				return "bravo"
	return "piscar" if _blink < 0.0 else "neutro"


# --- Rastro dos golpes ---

## Escolhe a mão ou o pé que mais anda entre o preparo e o golpe e desenha um
## rastro atrás dele durante os quadros ativos.
func _update_trail() -> void:
	if _trail == null or fighter == null:
		return
	var attacking := fighter.state == Fighter.State.ATTACK and fighter.attack != null
	if attacking and fighter.attack_frame < _attack_seen:
		_attack_seen = -1  # golpe novo
	if attacking and _attack_seen < 0:
		_trail_part = _pick_trail_part()
		_trail_pts.clear()
	if attacking:
		_attack_seen = fighter.attack_frame
	var f := fighter.attack_frame
	var live := attacking and _trail_part != "" \
		and f >= fighter.attack.startup - 1 and f <= fighter.attack.startup + fighter.attack.active + 1
	if live:
		var s := _sprites[_trail_part] as Sprite2D
		_trail_pts.append(s.global_transform * _tips[_trail_part])
		while _trail_pts.size() > TRAIL_MAX:
			_trail_pts.pop_front()
	elif not _trail_pts.is_empty():
		_trail_pts.pop_front()
		if _trail_pts.size() > 0:
			_trail_pts.pop_front()
	if not attacking:
		_attack_seen = -1
	_trail.points = _smooth(_trail_pts)
	_trail.width = 20.0 * absf(global_scale.y) / maxf(0.001, float(rig.get("escala", 0.15)))


func _pick_trail_part() -> String:
	var golpes: Dictionary = rig.get("golpes", {})
	var g: Dictionary = golpes.get(fighter.attack_id, golpes.get(_family(fighter.attack_id), {}))
	if g.is_empty():
		return ""
	var a := CutoutRigMath.part_transforms(rig, g.get("preparo", {}))
	var b := CutoutRigMath.part_transforms(rig, g.get("golpe", {}))
	var best := ""
	var best_d := 160.0  # pixels da folha: menos que isso não merece rastro
	for name in _tips:
		var d: float = ((a[name] as Transform2D) * _tips[name]).distance_to((b[name] as Transform2D) * _tips[name])
		if d > best_d:
			best_d = d
			best = name
	return best


## Curva suave (Catmull-Rom) passando pelos pontos guardados.
static func _smooth(pts: Array[Vector2]) -> PackedVector2Array:
	var out := PackedVector2Array()
	if pts.size() < 3:
		return PackedVector2Array(pts)
	for i in pts.size() - 1:
		var p0 := pts[maxi(i - 1, 0)]
		var p1 := pts[i]
		var p2 := pts[i + 1]
		var p3 := pts[mini(i + 2, pts.size() - 1)]
		for j in 4:
			var t := j / 4.0
			var t2 := t * t
			var t3 := t2 * t
			out.append(0.5 * ((2.0 * p1) + (-p0 + p2) * t + (2.0 * p0 - 5.0 * p1 + 4.0 * p2 - p3) * t2 + (-p0 + 3.0 * p1 - 3.0 * p2 + p3) * t3))
	out.append(pts[-1])
	return out


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
			# Mistura subida e queda pela velocidade vertical; inclina para onde vai.
			var t := smoothstep(-350.0, 450.0, fighter.velocity.y)
			var air := _mix(pose_offsets(rig, "pulo"), pose_offsets(rig, "queda"), t)
			var drift := clampf(fighter.velocity.x * fighter.facing / maxf(1.0, fighter.air_speed), -1.0, 1.0)
			air["tronco"] = float(air.get("tronco", 0.0)) + drift * 9.0
			return air
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
	return _ginga(_breathe(pose_offsets(rig, "parado"), 2.0))


## Ginga parada (capoeira): passa o peso de uma perna para a outra e troca a
## guarda dos braços, devagar.
func _ginga(base: Dictionary) -> Dictionary:
	var g := float(rig.get("ginga", 0.0))
	if g <= 0.0:
		return base
	var out := base.duplicate()
	var s := sin(_clock * 1.7)
	out["coxa_frente"] = float(out.get("coxa_frente", 0.0)) + s * g * 0.6
	out["coxa_tras"] = float(out.get("coxa_tras", 0.0)) + s * g * 0.6
	out["canela_frente"] = float(out.get("canela_frente", 0.0)) + maxf(0.0, -s) * g
	out["canela_tras"] = float(out.get("canela_tras", 0.0)) + maxf(0.0, s) * g
	out["tronco"] = float(out.get("tronco", 0.0)) - s * g * 0.4
	out["braco_frente"] = float(out.get("braco_frente", 0.0)) - s * g * 1.2
	out["braco_tras"] = float(out.get("braco_tras", 0.0)) + s * g * 1.2
	out["cauda"] = float(out.get("cauda", 0.0)) + s * g * 0.8
	return out


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
