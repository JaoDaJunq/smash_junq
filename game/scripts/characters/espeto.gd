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
	_ring.z_index = -1
	add_child(_ring)


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


## Anel de espinhos que aparece em volta dele enquanto arrepiado.
class SpikeRing:
	extends Node2D

	func _draw() -> void:
		var e := get_parent() as Espeto
		if e == null or not e.is_spiky():
			return
		var t := e._spiky
		var fade := clampf(t / 0.3, 0.0, 1.0)
		var n := 18
		for i in n:
			var a := i * TAU / n + 0.2
			var d := Vector2(cos(a), sin(a))
			var base := Vector2(d.x * 30.0, d.y * 40.0 - 6.0)
			var tip := Vector2(d.x * 50.0, d.y * 60.0 - 6.0)
			var side := Vector2(-d.y, d.x) * 6.0
			var tri := PackedVector2Array([base + side, tip, base - side])
			draw_colored_polygon(tri, Color(0.165, 0.059, 0.071, fade))
			var inner := PackedVector2Array([base + side * 0.55, base.lerp(tip, 0.82), base - side * 0.55])
			draw_colored_polygon(inner, Color(0.96, 0.82, 0.3, fade))
