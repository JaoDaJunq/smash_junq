class_name PixelSprite
extends Node2D
## Visual do lutador em pixel art: escolhe a animação e o quadro pelo estado do
## Fighter pai. As tiras vêm de tools/importar_pixel.gd
## (game/assets/characters/<personagem>/pixel/<animacao>.png + animacoes.json).
##
## O nó fica nos pés do lutador (y = +55): espelhar, amassar e esticar acontecem
## em volta dos pés, que continuam no chão. Os golpes seguem os quadros do
## moveset: quadros de preparo durante o início, o quadro de impacto nos quadros
## ativos e o resto na recuperação.
##
## Animações intercaladas (fator 2, com quadros intermediários) funcionam sem
## mudar nada aqui: os índices "da folha original" passam por _at() e _span().
## Transições opcionais, usadas quando existem: virar, arrancar, frear, pouso.

const NATIVE := 64
const BASELINE := 59           # linha dos pés dentro do quadro de 64
const FEET_Y := Fighter.HEIGHT * 0.5
const TUMBLE_SPEED := 1100.0
const TURN_TIME := 0.12
const DASH_TIME := 0.15
const BRAKE_TIME := 0.18
const LAND_TIME := 0.15
## Comemoração: toca uma vez neste tempo e fica parada na pose final.
const VICTORY_TIME := 2.2

## Golpe do moveset -> animação.
const ATTACK_ANIM := {
	"jab": "jab", "jab2": "jab_b", "jab3": "jab_c", "ftilt": "golpe_frente", "utilt": "golpe_cima", "dtilt": "golpe_baixo",
	"nair": "aereo_neutro", "fair": "aereo_frente", "bair": "aereo_tras",
	"uair": "aereo_cima", "dair": "aereo_baixo",
	"special_neutral": "especial_neutro", "special_side": "especial_lado",
	"special_up": "especial_cima", "special_down": "especial_baixo",
}

@export_dir var folder := ""
## Ampliação do pixel (64 px nativos -> 128 px no jogo).
@export var pixel_scale := 2.0
## Coluna do quadro que fica no centro do lutador.
@export var center_x := 32.0
@export_group("Andar e correr")
## Quadros da folha original por segundo, na velocidade máxima (a intercalada
## toca o dobro). Ficam em ~45% do casamento exato com o deslocamento (o passo
## desenhado pedia ~2 ciclos por segundo andando, que no playtest 01 pareceu
## rápido e tremido). Por personagem: o Seu Capivas tem passo desenhado mais
## curto e anda mais devagar; com 5/7 ele fica na mesma proporção que o Juba com 6/9.
@export var walk_fps := 6.0
@export var run_fps := 9.0
## Quadros da tira usados no loop (vazio = todos). Serve para tirar quadros que
## fazem o corpo pular para cima e para baixo entre um e outro (tremedeira): no
## andar dos dois, os intermediários alternam a altura da cabeça a cada quadro,
## então o andar usa só os 6 quadros da folha original.
@export var walk_frames := PackedInt32Array()
@export var run_frames := PackedInt32Array()

var fighter: Fighter
var anim := ""
var frame := 0
var _sprite: Sprite2D
var _textures := {}
var _counts := {}
var _factor := {}
var _impact := {}
var _clock := 0.0
var _anim_time := 0.0
var _squash := 0.0
var _squash_v := 0.0
var _flip := -1.0        # pulo duplo com cambalhota (>= 0 = em andamento)
var _since_jump := 9.0
var _throw := 0.0        # tempo mostrando o arremesso depois de segurar
var _hit_time := 0.0
var _mood := ""
var _mood_time := 0.0
var _mood_age := 0.0
var _escape_flash := 0.0  # piscada quando o escape de combo volta a ficar disponível
var _escape_was_waiting := false     # tempo desde o começo da reação atual
var _last_state := -1
var _last_facing := 0
var _turn := 9.0         # tempo desde a última virada no chão
var _dash := 9.0         # tempo desde a arrancada
var _brake := 9.0        # tempo desde que parou de correr
var _land := 9.0         # tempo desde o pouso
var _step_phase := 0.0   # 0..1 dentro do ciclo de andar/correr
var _hang_hand := Vector2(-1, -1)  # pixel da mão que segura a quina (folha "pendurado")


func _ready() -> void:
	fighter = get_parent() as Fighter
	var meta: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(folder.path_join("animacoes.json")))
	for a in meta:
		_textures[a] = load(folder.path_join(a + ".png"))
		var m = meta[a]
		if typeof(m) == TYPE_DICTIONARY:
			_counts[a] = int(m["quadros"])
			_factor[a] = int(m.get("fator", 1))
			_impact[a] = int(m.get("impacto", 0))
		else:  # formato antigo: só a contagem
			_counts[a] = int(m)
			_factor[a] = 1
			_impact[a] = 1 if int(m) <= 3 else (2 if int(m) <= 5 else 3)
	# Folhas largas (quadros > 64 px, corpo nos 64 da esquerda): tools/importar_largo.py
	var wide_path := folder.path_join("largos.json")
	if FileAccess.file_exists(wide_path):
		var wide: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(wide_path))
		for a in wide:
			_textures[a] = load(folder.path_join(a + ".png"))
			_counts[a] = int(wide[a]["quadros"])
			# "visivel": mostra só os N px da esquerda de cada quadro (encurta fita/laço sem redesenhar)
			if wide[a].has("visivel"):
				_textures[a] = _crop_frames(_textures[a], _counts[a], int(wide[a]["visivel"]))
			_factor[a] = 1
			_impact[a] = 1
	_sprite = Sprite2D.new()
	_sprite.name = "Quadro"
	_sprite.centered = false
	# Filtro linear + shader de pixel nítido: blocos retos em qualquer zoom da câmera.
	_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	var mat := ShaderMaterial.new()
	mat.shader = preload("res://shaders/pixel_nitido.gdshader")
	_sprite.material = mat
	_sprite.position = Vector2(-center_x, -(BASELINE + 1))
	add_child(_sprite)
	if fighter != null:
		fighter.has_art = true
		_last_facing = fighter.facing
		fighter.landed.connect(_on_landed)
		fighter.jumped.connect(_on_jumped)
		fighter.dashed.connect(func() -> void:
			_kick(0.06)
			_dash = 0.0)
		fighter.hit_taken.connect(func(_a: Node2D, _d: AttackData, _l: Vector2) -> void:
			_kick(0.12)
			_hit_time = 0.0)
	position = Vector2(0, FEET_Y)
	if _textures.has("pendurado"):
		_hang_hand = _top_pixel(_textures["pendurado"])
	_show("parado", 0)


func _process(delta: float) -> void:
	_clock += delta
	_anim_time += delta * (fighter.slow_now if fighter != null else 1.0)   # lento: loops também
	_since_jump += delta
	_hit_time += delta
	_turn += delta
	_dash += delta
	_brake += delta
	_land += delta
	_mood_time = maxf(0.0, _mood_time - delta)
	_mood_age += delta
	_escape_flash = maxf(0.0, _escape_flash - delta)
	if fighter != null:
		var waiting := fighter._escape_wait > 0.0
		if _escape_was_waiting and not waiting:
			_escape_flash = 0.18
		_escape_was_waiting = waiting
	_throw = maxf(0.0, _throw - delta)
	if fighter == null:
		return
	var S := Fighter.State
	if fighter.state != _last_state:
		if _last_state == S.HOLDING and fighter.state not in [S.HITSTUN, S.HELD]:
			_throw = 0.25
		if _last_state == S.RUN and fighter.state in [S.IDLE, S.WALK]:
			_brake = 0.0
		_last_state = fighter.state
		_anim_time = 0.0
	if fighter.facing != _last_facing:
		_last_facing = fighter.facing
		if fighter.state in [S.IDLE, S.WALK, S.RUN]:
			_turn = 0.0
	var pick := _pick()
	_show(pick[0], pick[1])
	_update_squash(delta)
	scale = Vector2(pixel_scale * fighter.facing * (1.0 + _squash), pixel_scale * (1.0 - _squash))
	var c := Color.WHITE
	if fighter.state == S.HITSTUN and int(_clock * 20.0) % 2 == 0:
		c = Color(1.7, 1.7, 1.7)
	if fighter.invincible_time > 0.0:
		c.a = 0.45 if int(_clock * 12.0) % 2 == 0 else 0.8
	elif fighter._is_intangible():
		c.a = 0.45
	if _escape_flash > 0.0:
		c = Color(1.6, 1.6, 2.0, c.a)
	# Carga: treme cada vez mais e brilha; na carga cheia pisca branco.
	var charge := fighter.charge_ratio()
	_sprite.position = Vector2(-center_x, -(BASELINE + 1))
	if anim == "pendurado" and _hang_hand.x >= 0.0 and fighter._ledge != null:
		# A mão do desenho fica exatamente na quina da plataforma.
		_sprite.position = to_local(fighter._ledge.global_position) - _hang_hand
	if charge >= 0.0:
		var amp := 0.3 + 1.2 * charge
		_sprite.position.x += amp * sin(_clock * 70.0)
		var glow := 1.0 + 0.45 * charge * (0.6 + 0.4 * sin(_clock * (10.0 + 20.0 * charge)))
		c = Color(glow, glow * 0.95, glow * 0.8, c.a)
		if charge >= 1.0 and int(_clock * 16.0) % 2 == 0:
			c = Color(2.2, 2.2, 2.2, c.a)
	modulate = c


func a_charge() -> String:
	return ATTACK_ANIM["special_neutral"]


## Força uma reação por um tempo (ex.: "vitoria" ao fazer KO ou ganhar a partida).
func set_mood(face: String, seconds := 1.5) -> void:
	_mood = face
	_mood_time = seconds
	_mood_age = 0.0


## Pixel opaco mais alto do 1º quadro (a ponta dos dedos de quem está pendurado).
func _top_pixel(tex: Texture2D) -> Vector2:
	var img := tex.get_image()
	var fw := img.get_width() / maxi(1, int(_counts.get("pendurado", 1)))
	for y in NATIVE:
		for x in fw:
			if img.get_pixel(x, y).a > 0.5:
				return Vector2(x + 0.5, y)
	return Vector2(-1, -1)


func has_anim(a: String) -> bool:
	return _counts.has(a)


func _show(a: String, f: int) -> void:
	if not _counts.has(a):
		a = "parado"
	f = clampi(f, 0, int(_counts[a]) - 1)
	if a != anim:
		anim = a
		_sprite.texture = _textures[a]
		_sprite.hframes = int(_counts[a])
	frame = f
	_sprite.frame = f


static func _crop_frames(tex: Texture2D, count: int, keep: int) -> Texture2D:
	var img := tex.get_image()
	if img.is_compressed():
		img.decompress()
	var fw := img.get_width() / count
	keep = mini(keep, fw)
	var out := Image.create(keep * count, img.get_height(), false, img.get_format())
	for i in count:
		out.blit_rect(img, Rect2i(i * fw, 0, keep, img.get_height()), Vector2i(i * keep, 0))
	return ImageTexture.create_from_image(out)


## Índice na tira de um quadro da folha original (conta os intermediários).
func _at(a: String, i: int) -> int:
	return mini(i * int(_factor.get(a, 1)), int(_counts.get(a, 1)) - 1)


## Quadros da folha original de a até b, com os intermediários entre eles.
func _span(a: String, from: int, to: int) -> Array:
	return range(_at(a, from), _at(a, to) + 1)


## Loop no ritmo da folha original (intercalada toca o dobro de quadros por segundo).
func _loop(a: String, fps: float, frames: Array = []) -> Array:
	var list: Array = frames if not frames.is_empty() else range(int(_counts.get(a, 1)))
	return [a, list[int(_anim_time * fps * float(_factor.get(a, 1))) % list.size()]]


## Ciclo de passos: a fase avança com o tempo (mais devagar quando o lutador
## anda devagar), então mudar a velocidade não faz o quadro pular. Com uma lista
## própria de quadros, o ciclo dura o mesmo tempo que com todos.
func _cycle(a: String, fps: float, frames: PackedInt32Array) -> Array:
	var n := int(_counts.get(a, 1))
	var list := Array(frames).filter(func(i: int) -> bool: return i < n)
	if list.is_empty():
		list = range(n)
	var rate := fps * float(_factor.get(a, 1)) / float(n)  # ciclos por segundo
	_step_phase = fmod(_step_phase + get_process_delta_time() * rate, 1.0)
	return [a, list[mini(list.size() - 1, int(_step_phase * list.size()))]]


## Toca a animação inteira uma vez em `time` segundos, a partir de `elapsed`.
func _once(a: String, elapsed: float, time: float) -> Array:
	var n := int(_counts.get(a, 1))
	return [a, mini(n - 1, int(elapsed / time * n))]


# --- Escolha da animação ---

func _pick() -> Array:
	var S := Fighter.State
	# Personagem com folha especial para um momento (ex.: abraço da Sucuri).
	if fighter.has_method("anim_override"):
		var o: Array = fighter.anim_override()
		if not o.is_empty() and has_anim(o[0]):
			if o.size() > 2 and o[2]:   # [animação, quadro, true] = quadro fixo
				return [o[0], mini(int(o[1]), int(_counts[o[0]]) - 1)]
			return _loop(o[0], o[1])
	var grounded := fighter.state in [S.IDLE, S.WALK, S.RUN]
	if grounded and _turn < TURN_TIME and has_anim("virar"):
		return _once("virar", _turn, TURN_TIME)
	match fighter.state:
		S.IDLE:
			if _mood == "vitoria" and _mood_time > 0.0 and has_anim("vitoria"):
				return _once("vitoria", _mood_age, VICTORY_TIME)
			if _throw > 0.0 and has_anim("agarrar"):
				return ["agarrar", _at("agarrar", 2)]
			if _brake < BRAKE_TIME and has_anim("frear"):
				return _once("frear", _brake, BRAKE_TIME)
			if _land < LAND_TIME and has_anim("pouso"):
				return _once("pouso", _land, LAND_TIME)
			return _loop("parado", 6.0)
		S.WALK:
			if _brake < BRAKE_TIME and has_anim("frear"):
				return _once("frear", _brake, BRAKE_TIME)
			var pace := clampf(absf(fighter.velocity.x) / maxf(1.0, fighter.walk_speed), 0.5, 1.0)
			return _cycle("andar", walk_fps * pace, walk_frames)
		S.RUN:
			if _dash < DASH_TIME and has_anim("arrancar"):
				return _once("arrancar", _dash, DASH_TIME)
			return _cycle("correr", run_fps, run_frames)
		S.AIR, S.RESPAWN:
			return _air()
		S.LAG:
			if has_anim("pouso"):
				return _once("pouso", _land, LAND_TIME)
			return ["pulo", _at("pulo", 5)]
		S.ATTACK:
			if fighter.charge_ratio() >= 0.0 and has_anim(a_charge()):
				# Carregando: respira entre "meditando", "enchendo a barriga" e
				# "barriga enorme", cada vez mais rápido.
				return _loop(a_charge(), 4.0 + 8.0 * fighter.charge_ratio(), _span(a_charge(), 0, 2))
			return _attack()
		S.HITSTUN, S.HELD:
			var n0 := (int(_counts.get("dor", 1)) + int(_factor.get("dor", 1)) - 1) / int(_factor.get("dor", 1))
			var tumbling := fighter.state == S.HITSTUN and not fighter.is_on_floor() and fighter.velocity.length() > TUMBLE_SPEED
			if tumbling:
				return _loop("dor", 10.0, _span("dor", n0 - 2, n0 - 1) if n0 >= 4 else [_at("dor", n0 - 1)])
			var hit: Array = _span("dor", 0, 1) if n0 >= 4 else [0]
			return ["dor", hit[mini(hit.size() - 1, int(_hit_time / 0.15 * hit.size()))]]
		S.LEDGE:
			if has_anim("pendurado"):
				return _loop("pendurado", 1.5)  # pose parada, só respirando
			return _loop("borda", 3.0, _span("borda", 0, 1))
		S.SHIELD:
			return _loop("defesa_esquiva", 8.0, _span("defesa_esquiva", 0, 1))
		S.SHIELD_BREAK:
			if has_anim("tonto"):
				return _loop("tonto", 6.0)
			return _loop("tonto_pulo_duplo", 5.0, _span("tonto_pulo_duplo", 0, 1))
		S.DODGE:
			var t := clampf(_anim_time / (fighter.roll_frames / 60.0), 0.0, 0.999)
			var roll := _span("defesa_esquiva", 2, 5)
			return ["defesa_esquiva", roll[int(t * roll.size())]]
		S.GRAB:
			return ["agarrar", 0]
		S.HOLDING:
			return ["agarrar", _at("agarrar", 1)]
	return _loop("parado", 6.0)


func _air() -> Array:
	# Grudado na parede (Maracajá)
	if fighter.has_method("is_clinging") and fighter.is_clinging() and has_anim("parede"):
		return _loop("parede", 3.0)
	# Pulo duplo do Juba: cambalhota da folha tonto_pulo_duplo (quadros 3 a 6)
	if _flip >= 0.0:
		_flip += get_process_delta_time() / 0.3
		if _flip < 1.0 and has_anim("tonto_pulo_duplo"):
			var spin := _span("tonto_pulo_duplo", 2, 5)
			return ["tonto_pulo_duplo", spin[int(_flip * spin.size())]]
		_flip = -1.0
	if fighter.state == Fighter.State.RESPAWN:
		# Na plataforma de volta: sentado descansando; ao sair dela, cai normalmente.
		if has_anim("descanso"):
			return _loop("descanso", 3.0)
		return ["pulo", _at("pulo", 3)]
	if _since_jump < 0.08:
		return ["pulo", _at("pulo", 1)]
	# Subida, topo e queda escolhidos pela velocidade vertical (passa pelos intermediários)
	var arc := _span("pulo", 2, 4)
	var t := clampf(inverse_lerp(-600.0, 500.0, fighter.velocity.y), 0.0, 0.999)
	return ["pulo", arc[int(t * arc.size())]]


## Golpe: quadros de preparo ao longo do início, o de impacto nos ativos e os
## seguintes ao longo da recuperação.
func _attack() -> Array:
	var data := fighter.attack
	var a: String = ATTACK_ANIM.get(fighter.attack_id, "golpe_frente")
	if not has_anim(a) and fighter.attack_id.begins_with("jab"):
		a = "jab"  # folha da sequência ainda não importada
	if data == null or not has_anim(a):
		return ["parado", 0]
	var n := int(_counts[a])
	var i := int(_impact[a])
	var f := fighter.attack_frame
	if f <= data.startup:
		return [a, mini(i - 1, int(float(f) / maxf(1.0, data.startup) * i)) if i > 0 else 0]
	if f <= data.startup + data.active:
		return [a, i]
	var r := float(f - data.startup - data.active) / maxf(1.0, data.recovery)
	return [a, mini(n - 1, i + 1 + int(r * (n - 1 - i)))]


# --- Amassar e esticar (em volta dos pés) ---

func _kick(amount: float) -> void:
	_squash_v += amount * 14.0


func _update_squash(delta: float) -> void:
	var acc := -320.0 * _squash - 16.0 * _squash_v
	_squash_v += acc * delta
	_squash = clampf(_squash + _squash_v * delta, -0.18, 0.18)


func _on_landed(fall_speed: float) -> void:
	_flip = -1.0
	_land = 0.0
	_kick(0.05 + 0.1 * clampf(fall_speed / 900.0, 0.0, 1.0))


func _on_jumped(in_air: bool) -> void:
	_since_jump = 0.0
	_kick(-0.08 if not in_air else -0.05)
	if in_air and has_anim("tonto_pulo_duplo"):
		_flip = 0.0
