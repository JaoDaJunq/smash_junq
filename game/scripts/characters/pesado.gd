class_name Pesado
extends Fighter
## Personagem temporário "Pesado" (ver design/gdd.md, Personagens temporários).
## Lento e pesado, golpes que lançam longe. Especiais:
##  - neutro: pancada carregável (segurar Especial carrega, soltar bate)
##  - lateral: agarrão (pega quem está à frente, no chão ou no ar, e arremessa)
##  - para cima: pulo alto com golpe no topo (recuperação; depois fica sem pulo)
##  - para baixo: pisão que lança quem está perto (no ar, despenca e bate ao pousar)

## Arremesso do agarrão lateral (recurso na cena; ver pesado.tscn).
@export var command_throw_data: AttackData

## Quadros máximos de carga da pancada (depois disso ela sai sozinha).
const MAX_CHARGE := 60
## Bônus no pico da carga: dano e lançamento (fração a mais sobre o golpe sem carga).
const CHARGE_DAMAGE_BONUS := 1.0
const CHARGE_KNOCKBACK_BONUS := 0.6
const CHARGE_RADIUS_BONUS := 0.3
## Agarrão: quadros segurando o alvo antes de arremessar.
const HOLD_FRAMES := 16
## Especial para cima: quadros de preparo no chão e velocidade do pulo.
const UP_WINDUP := 8
const UP_RISE := 1300.0
## Especial para baixo no ar: quadros parado antes de despencar.
const DIVE_WINDUP := 10

var _charging := false
var _charge := 0
var _command_grab_timer := 0
var _diving := false


func start_special(kind: String) -> void:
	super(kind)
	if kind == "neutral" and attack_id == "special_neutral":
		_charging = true
		_charge = 0


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral": _charge_step(frame)
		"special_side": _grab_step(frame)
		"special_up": _up_step(frame)
		"special_down": _down_step(frame)


func _on_attack_end(move_id: String) -> void:
	match move_id:
		"special_neutral":
			_charging = false
			_charge = 0
		"special_side":
			if holding != null:
				_throw()  # golpe cortado (ex.: pousou) com alguém preso: arremessa já
		"special_down":
			var impact := _diving and is_on_floor()
			_diving = false
			if impact and moveset != null:
				_pound_hit(moveset.special_down)  # pousou do mergulho: onda de impacto


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	_charging = false
	_charge = 0
	_diving = false
	return super(attacker, data, direction_sign)


# --- Pancada carregável ---

func _charge_step(frame: int) -> void:
	if not _charging or frame < attack.startup:
		return
	if controls.pressed("special") and _charge < MAX_CHARGE:
		_charge += 1
		attack_frame = attack.startup - 1  # fica no quadro de carga
		return
	_charging = false
	if _charge > 0:
		var ratio := float(_charge) / MAX_CHARGE
		var scaled := attack.duplicate() as AttackData
		scaled.damage *= 1.0 + CHARGE_DAMAGE_BONUS * ratio
		scaled.base_knockback *= 1.0 + CHARGE_KNOCKBACK_BONUS * ratio
		scaled.knockback_growth *= 1.0 + CHARGE_KNOCKBACK_BONUS * ratio
		scaled.hitbox_radius *= 1.0 + CHARGE_RADIUS_BONUS * ratio
		attack = scaled


# --- Agarrão lateral ---

func _grab_step(frame: int) -> void:
	if holding != null:
		attack_frame = attack.startup + attack.active + 1  # congela logo depois dos quadros ativos
		_command_grab_timer += 1
		if _command_grab_timer >= HOLD_FRAMES:
			_throw()
		return
	if not attack.is_active(frame):
		return
	var center := hitbox_center(attack)
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == self or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(center, attack.hitbox_radius, target.hurtbox()):
			hold(target)  # a caixa do golpe não machuca: o dano vem no arremesso
			_command_grab_timer = 0
			return


func _throw() -> void:
	var data := command_throw_data if command_throw_data != null else moveset.special_side
	throw_held(data, facing)


# --- Pulo alto ---

func _up_step(frame: int) -> void:
	if frame < UP_WINDUP:
		if _attack_in_air:
			velocity.y = 0.0  # no ar, agacha parado
	elif frame == UP_WINDUP:
		velocity.y = -UP_RISE
		_attack_in_air = true  # sai do chão com física de ar


# --- Pisão ---

func _down_step(frame: int) -> void:
	if not _attack_in_air:
		return  # no chão é o golpe normal (ver _check_hits)
	if _diving:
		fast_falling = true
		attack_frame = attack.startup  # segue despencando até pousar
		return
	if frame < DIVE_WINDUP:
		velocity.y = 0.0
	else:
		_diving = true
		fast_falling = true
		attack_frame = attack.startup


func _check_hits() -> void:
	if attack_id == "special_down":
		_pound_hit(attack)
	else:
		super()


## Onda do pisão: lança cada alvo para longe de quem pisou, na frente ou atrás.
func _pound_hit(data: AttackData) -> void:
	var center := hitbox_center(data)
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == self or target in _hit_targets or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(center, data.hitbox_radius, target.hurtbox()):
			_hit_targets.append(target)
			var side := signi(target.global_position.x - global_position.x)
			target.receive_hit(self, data, side if side != 0 else facing)


# --- Visual ---

func _draw() -> void:
	super()
	if _charging and _charge > 0 and not has_art:  # barra de carga provisória (greybox)
		var ratio := float(_charge) / MAX_CHARGE
		var width := RADIUS * 2.0
		var top := -HEIGHT * 0.5 - 44.0
		draw_rect(Rect2(-width * 0.5, top, width, 8.0), Color(0, 0, 0, 0.6))
		draw_rect(Rect2(-width * 0.5, top, width * ratio, 8.0), Color.ORANGE.lerp(Color.RED, ratio))
