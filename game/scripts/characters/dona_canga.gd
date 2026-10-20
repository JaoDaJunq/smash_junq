class_name DonaCanga
extends Fighter
## Dona Canga: arara-canga baiana da escola de samba (design/personagens/arara_canga.md).
## Pesada que dança, com um pulo extra no ar (ave). Especiais:
##  - neutro "Pandeiro": arremessa o pandeiro, que vai e volta (bumerangue).
##  - lado "Desfile": avança girando, acertando várias vezes.
##  - cima "Voo de alegoria": bate as asas e sobe; depois cai planando devagar.
##  - baixo "Paradinha da bateria": bate o salto e uma onda empurra quem está perto.
## Mecânica própria "No ritmo": a bateria marca um tempo a cada BEAT segundos; o
## golpe que começa a acertar perto da batida tira +20% de dano (beat_flash pisca).

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PANDEIRO_PATH := "res://assets/characters/arara_canga/pixel/pandeiro.png"
const BEAT := 0.6
const BEAT_WINDOW := 0.12
const BEAT_BONUS := 1.2
const FLAP_SPEED := 1150.0
const GLIDE_FALL := 260.0
const SPIN_SPEED := 520.0

@export var pandeiro_speed := 820.0
@export var pandeiro_return := 0.45

var beat_flash := 0.0
var _beat_clock := 0.0
var _gliding := false


func _physics_process(delta: float) -> void:
	_beat_clock = fmod(_beat_clock + delta, BEAT)
	beat_flash = maxf(beat_flash - delta, 0.0)
	super._physics_process(delta)
	if _gliding:
		if is_on_floor() or state != State.AIR:
			_gliding = false
		elif velocity.y > GLIDE_FALL:
			velocity.y = GLIDE_FALL


## Perto de uma batida da bateria?
func on_beat() -> bool:
	return _beat_clock <= BEAT_WINDOW or _beat_clock >= BEAT - BEAT_WINDOW


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == attack.startup and attack.active > 0 and on_beat():
		var scaled := attack.duplicate() as AttackData
		scaled.damage *= BEAT_BONUS
		attack = scaled
		beat_flash = 0.3
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				var p := Projectile.spawn(PROJECTILE, self, attack, hitbox_center(attack), Vector2(pandeiro_speed * facing, 0.0), 1.6)
				p.return_after = pandeiro_return
				if has_art and ResourceLoader.exists(PANDEIRO_PATH):
					p.set_sprite(load(PANDEIRO_PATH))
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity.x = SPIN_SPEED * facing
				if frame % 6 == 0:
					_hit_targets.clear()   # o giro acerta de novo a cada volta
		"special_up":
			if frame == attack.startup:
				velocity.y = -FLAP_SPEED
				_attack_in_air = true
				jumped.emit(true)


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_up":
		_gliding = true
