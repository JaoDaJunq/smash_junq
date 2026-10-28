class_name Espeto
extends Fighter
## Espeto: ouriço-cacheiro roqueiro de garagem (design/personagens/ourico.md,
## design/proposta-rodada11.md). Roedores · Forte.
## Mecânica própria: ESPINHOS. Enquanto está "arrepiado" (especial baixo, 1,5 s),
## quem o acerta com golpe corpo a corpo toma PRICK_DAMAGE de volta; em troca, ele
## anda mais devagar (SPIKY_SLOW).
## Especiais:
##  - neutro "Power chord": o acorde solta 3 espinhos em leque (projéteis curtos).
##  - lado "Stage dive": pula como em show e cai rolando como bola de espinhos; quica
##    uma vez no chão antes de parar.
##  - cima "Microfonia": a guitarra estoura e o joga para o alto (recuperação).
##  - baixo "Arrepiar": eriça os espinhos (mecânica acima).

const SPIKY_TIME := 1.5
const SPIKY_SLOW := 0.65
const PRICK_DAMAGE := 3.0
const SPINE_SPEED := 950.0
const SPINE_LIFE := 0.3
const SPINE_FAN := [-20.0, 0.0, 20.0]
const DIVE_VELOCITY := Vector2(660.0, -560.0)
const BOUNCE_VELOCITY := 420.0
const MIC_RISE := 1100.0
const SPINE_SHEET := "res://assets/characters/ourico/pixel/espinho.png"

var _spiky := 0.0
var _bounces := 0
var _base_speeds := Vector3.ZERO
var _spine_data: AttackData
var _ring: Node2D


func _ready() -> void:
	super()
	_base_speeds = Vector3(walk_speed, run_speed, air_speed)
	_spine_data = AttackData.new()
	_spine_data.id = "espinho"
	_spine_data.damage = 2.5
	_spine_data.hitbox_radius = 12.0
	_spine_data.angle = 30.0
	_spine_data.base_knockback = 190.0
	_spine_data.knockback_growth = 3.0
	_ring = SpikeRing.new()
	add_child(_ring)
	move_child(_ring, 0)   # desenha antes do sprite (atrás dele), mas na frente do cenário


func _physics_process(delta: float) -> void:
	if _spiky > 0.0:
		_spiky = maxf(0.0, _spiky - delta)
		if _spiky == 0.0:
			_restore_speed()
		else:
			walk_speed = _base_speeds.x * SPIKY_SLOW
			run_speed = _base_speeds.y * SPIKY_SLOW
			air_speed = _base_speeds.z * SPIKY_SLOW
	super(delta)
	_ring.queue_redraw()


func is_spiky() -> bool:
	return _spiky > 0.0


func _restore_speed() -> void:
	walk_speed = _base_speeds.x
	run_speed = _base_speeds.y
	air_speed = _base_speeds.z


## Quem bate nele arrepiado com golpe corpo a corpo toma de volta (inclusive no escudo).
func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	var melee := false
	var f := attacker as Fighter
	if f != null and f.attack != null and (f.attack == data or (data.id != "" and f.attack.id == data.id)):
		melee = true
	var ok := super(attacker, data, direction_sign)
	if _spiky > 0.0 and melee and (ok or state == State.SHIELD):
		f.add_damage(PRICK_DAMAGE)
		if move_fx != null:
			move_fx.event("espeto", f)
	return ok


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				_power_chord()
		"special_side":
			if frame == 1:
				_bounces = 1
			if frame == attack.startup:
				velocity = Vector2(DIVE_VELOCITY.x * facing, DIVE_VELOCITY.y)
				_attack_in_air = true
				jumped.emit(not is_on_floor())
		"special_up":
			if frame == attack.startup:
				velocity.y = -MIC_RISE
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if frame == attack.startup:
				_spiky = SPIKY_TIME


func _power_chord() -> void:
	var scene := load("res://scenes/combat/projectile.tscn") as PackedScene
	var from := global_position + Vector2(facing * 52.0, -22.0)
	for deg in SPINE_FAN:
		var dir := Vector2.from_angle(deg_to_rad(deg))
		var p := Projectile.spawn(scene, self, _spine_data, from, Vector2(dir.x * facing, dir.y) * SPINE_SPEED, SPINE_LIFE)
		if ResourceLoader.exists(SPINE_SHEET):
			p.set_sprite(load(SPINE_SHEET), 2.0)
		p.spin_fps = 1.0
		# o desenho olha para a direita; no leque, inclina junto com o voo
		p.rotation = atan2(p.velocity.y, absf(p.velocity.x)) * (1.0 if p.velocity.x >= 0.0 else -1.0)


## No stage dive, o primeiro pouso quica (uma vez); o segundo encerra o golpe.
func _land_during_attack() -> void:
	if attack_id == "special_side" and _bounces > 0 and attack_frame > attack.startup:
		_bounces -= 1
		velocity.y = -BOUNCE_VELOCITY
		velocity.x *= 0.7
		if move_fx != null:
			move_fx.play_at("fx_poof", global_position + Vector2(0, 50), 2.0, 0.3, "poof")
		return
	super()


func respawn() -> void:
	super()
	_spiky = 0.0
	_restore_speed()


## Anel de espinhos em volta dele enquanto arrepiado: folha fx_espinhos_arrepiados
## (1º quadro = espinhos saindo, depois loop nos quadros 2-4), centrada no corpo.
class SpikeRing:
	extends Node2D

	const SHEET := "res://assets/characters/ourico/pixel/fx_espinhos_arrepiados.png"
	var _tex: Texture2D
	var _n := 4

	func _ready() -> void:
		if ResourceLoader.exists(SHEET):
			_tex = load(SHEET)
			_n = Projectile.strip_frames(_tex)
		texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

	func _draw() -> void:
		var e := get_parent() as Espeto
		if e == null or not e.is_spiky() or _tex == null:
			return
		var t := e._spiky
		var w := float(_tex.get_width()) / float(_n)
		var h := float(_tex.get_height())
		var i := 0 if t < 0.12 else 1 + int(t * 10.0) % maxi(1, _n - 1)
		var size := Vector2(w, h) * 3.0   # o anel da folha é menor que o corpo: ampliado para os espinhos saírem em volta
		draw_texture_rect_region(_tex, Rect2(Vector2(-size.x * 0.5, -size.y * 0.5 - 6.0), size), Rect2(i * w, 0, w, h))
