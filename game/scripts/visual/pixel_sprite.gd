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

const NATIVE := 64
const BASELINE := 59           # linha dos pés dentro do quadro de 64
const FEET_Y := Fighter.HEIGHT * 0.5
const TUMBLE_SPEED := 1100.0

## Golpe do moveset -> animação.
const ATTACK_ANIM := {
	"jab": "jab", "ftilt": "golpe_frente", "utilt": "golpe_cima", "dtilt": "golpe_baixo",
	"nair": "aereo_neutro", "fair": "aereo_frente", "bair": "aereo_tras",
	"uair": "aereo_cima", "dair": "aereo_baixo",
	"special_neutral": "especial_neutro", "special_side": "especial_lado",
	"special_up": "especial_cima", "special_down": "especial_baixo",
}
## Quadro de impacto quando a animação foge do padrão (3 quadros -> 1, 5 -> 2, 6 -> 3).
const IMPACT_OVERRIDE := {
	"seu_capivas": {"especial_neutro": 4, "especial_lado": 2, "especial_baixo": 2},
}

@export_dir var folder := ""
## Ampliação do pixel (64 px nativos -> 128 px no jogo).
@export var pixel_scale := 2.0
## Coluna do quadro que fica no centro do lutador.
@export var center_x := 32.0

var fighter: Fighter
var anim := ""
var frame := 0
var _sprite: Sprite2D
var _textures := {}
var _counts := {}
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
var _last_state := -1


func _ready() -> void:
	fighter = get_parent() as Fighter
	var meta: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(folder.path_join("animacoes.json")))
	var who := folder.trim_suffix("/").get_base_dir().get_file()
	for a in meta:
		_textures[a] = load(folder.path_join(a + ".png"))
		_counts[a] = int(meta[a])
		var n := int(meta[a])
		_impact[a] = IMPACT_OVERRIDE.get(who, {}).get(a, 1 if n <= 3 else (2 if n <= 5 else 3))
	_sprite = Sprite2D.new()
	_sprite.name = "Quadro"
	_sprite.centered = false
	_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_sprite.position = Vector2(-center_x, -(BASELINE + 1))
	add_child(_sprite)
	if fighter != null:
		fighter.has_art = true
		fighter.landed.connect(_on_landed)
		fighter.jumped.connect(_on_jumped)
		fighter.dashed.connect(func() -> void: _kick(0.06))
		fighter.hit_taken.connect(func(_a: Node2D, _d: AttackData, _l: Vector2) -> void:
			_kick(0.12)
			_hit_time = 0.0)
	position = Vector2(0, FEET_Y)
	_show("parado", 0)


func _process(delta: float) -> void:
	_clock += delta
	_anim_time += delta
	_since_jump += delta
	_hit_time += delta
	_mood_time = maxf(0.0, _mood_time - delta)
	_throw = maxf(0.0, _throw - delta)
	if fighter == null:
		return
	if fighter.state != _last_state:
		if _last_state == Fighter.State.HOLDING and fighter.state not in [Fighter.State.HITSTUN, Fighter.State.HELD]:
			_throw = 0.25
		_last_state = fighter.state
		_anim_time = 0.0
	var pick := _pick()
	_show(pick[0], pick[1])
	_update_squash(delta)
	var facing := fighter.facing
	scale = Vector2(pixel_scale * facing * (1.0 + _squash), pixel_scale * (1.0 - _squash))
	var c := Color.WHITE
	if fighter.state == Fighter.State.HITSTUN and int(_clock * 20.0) % 2 == 0:
		c = Color(1.7, 1.7, 1.7)
	if fighter.invincible_time > 0.0:
		c.a = 0.45 if int(_clock * 12.0) % 2 == 0 else 0.8
	elif fighter._is_intangible():
		c.a = 0.45
	modulate = c


## Força uma reação por um tempo (ex.: "vitoria" ao fazer KO ou ganhar a partida).
func set_mood(face: String, seconds := 1.5) -> void:
	_mood = face
	_mood_time = seconds


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


func _loop(a: String, fps: float, frames: Array = []) -> Array:
	var list: Array = frames if not frames.is_empty() else range(int(_counts.get(a, 1)))
	return [a, list[int(_anim_time * fps) % list.size()]]


# --- Escolha da animação ---

func _pick() -> Array:
	var S := Fighter.State
	match fighter.state:
		S.IDLE:
			if _mood == "vitoria" and _mood_time > 0.0 and has_anim("vitoria"):
				return _loop("vitoria", 8.0)
			if _throw > 0.0 and has_anim("agarrar"):
				return ["agarrar", 2]
			return _loop("parado", 6.0)
		S.WALK:
			var pace := clampf(absf(fighter.velocity.x) / maxf(1.0, fighter.walk_speed), 0.5, 1.3)
			return [ "andar", int(_clock * 10.0 * pace) % int(_counts.get("andar", 1))]
		S.RUN:
			return ["correr", int(_clock * 13.0) % int(_counts.get("correr", 1))]
		S.AIR, S.RESPAWN:
			return _air()
		S.LAG:
			return ["pulo", 5]
		S.ATTACK:
			return _attack()
		S.HITSTUN, S.HELD:
			var n := int(_counts.get("dor", 1))
			var tumbling := fighter.state == S.HITSTUN and not fighter.is_on_floor() and fighter.velocity.length() > TUMBLE_SPEED
			if tumbling:
				return _loop("dor", 10.0, [n - 2, n - 1] if n >= 4 else [n - 1])
			return ["dor", 0 if _hit_time < 0.12 or n < 4 else 1]
		S.LEDGE:
			return _loop("borda", 3.0, [0, 1])
		S.SHIELD:
			return _loop("defesa_esquiva", 8.0, [0, 1])
		S.SHIELD_BREAK:
			if has_anim("tonto"):
				return _loop("tonto", 6.0)
			return _loop("tonto_pulo_duplo", 5.0, [0, 1])
		S.DODGE:
			var t := clampf(_anim_time / (fighter.roll_frames / 60.0), 0.0, 0.999)
			return ["defesa_esquiva", 2 + int(t * 4.0)]
		S.GRAB:
			return ["agarrar", 0]
		S.HOLDING:
			return ["agarrar", 1]
	return _loop("parado", 6.0)


func _air() -> Array:
	# Pulo duplo do Juba: cambalhota da folha tonto_pulo_duplo (quadros 3 a 6)
	if _flip >= 0.0:
		_flip += get_process_delta_time() / 0.3
		if _flip < 1.0 and has_anim("tonto_pulo_duplo"):
			return ["tonto_pulo_duplo", 2 + int(_flip * 4.0)]
		_flip = -1.0
	if fighter.state == Fighter.State.RESPAWN:
		return ["pulo", 3]
	var vy := fighter.velocity.y
	if _since_jump < 0.08:
		return ["pulo", 1]
	if vy < -250.0:
		return ["pulo", 2]
	if vy < 150.0:
		return ["pulo", 3]
	return ["pulo", 4]


## Golpe: quadros de preparo ao longo do início, o de impacto nos ativos e os
## seguintes ao longo da recuperação.
func _attack() -> Array:
	var data := fighter.attack
	var a: String = ATTACK_ANIM.get(fighter.attack_id, "golpe_frente")
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
	_kick(0.05 + 0.1 * clampf(fall_speed / 900.0, 0.0, 1.0))


func _on_jumped(in_air: bool) -> void:
	_since_jump = 0.0
	_kick(-0.08 if not in_air else -0.05)
	if in_air and has_anim("tonto_pulo_duplo"):
		_flip = 0.0
