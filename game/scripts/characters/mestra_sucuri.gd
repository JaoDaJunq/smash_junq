class_name MestraSucuri
extends Fighter
## Mestra Sucuri: sucuri-verde mestra de jiu-jitsu (design/personagens/sucuri.md).
## Forte dos agarrões: segura o dobro do tempo e cada aperto (Ataque) tira mais.
## Especiais:
##  - neutro "Hipnose": quem estiver perto e à frente fica parado um instante.
##  - lado "Laço de cauda": laça de longe, puxa para perto e emenda no agarrão.
##  - cima "Mola": enrola e se solta para cima (recuperação).
##  - baixo "Abraço de sucuri": vira uma espiral; quem encostar fica preso,
##    é apertado e arremessado (armadilha).

@export var lasso_throw_data: AttackData

const HYPNO_RANGE := 220.0
const HYPNO_TIME := 0.7
const SPRING_SPEED := 1250.0
const SQUEEZE_HOLD := 40
const SQUEEZE_DAMAGE := 2.5


var _squeeze_timer := 0
## Cauda esticada do laço: desenhada pelo jogo (o sprite do golpe é compacto e
## não pode atravessar o quadro de 64). Folha laco_cauda.png: 1 = trecho que se
## repete, 2 = ponta em laço.
const LACO_PATH := "res://assets/characters/sucuri/pixel/laco_cauda.png"
const TAIL_START := Vector2(26, 8)   # onde a cauda sai do corpo (relativo, virado para a direita)
var _tail: Line2D
var _tail_tip: Sprite2D


func _ready() -> void:
	super._ready()
	_tail = Line2D.new()
	_tail.width = 20.0
	_tail.texture_mode = Line2D.LINE_TEXTURE_TILE
	_tail.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_tail.default_color = Color(0.42, 0.48, 0.18)
	_tail.visible = false
	_tail.z_index = -1
	add_child(_tail)
	_tail_tip = Sprite2D.new()
	_tail_tip.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_tail_tip.scale = Vector2(2, 2)
	_tail_tip.visible = false
	add_child(_tail_tip)
	if ResourceLoader.exists(LACO_PATH):
		var sheet: Texture2D = load(LACO_PATH)
		var seg := AtlasTexture.new()
		seg.atlas = sheet
		seg.region = Rect2(0, 0, 64, 64)
		var img := sheet.get_image()
		var used := img.get_region(Rect2i(0, 0, 64, 64)).get_used_rect()
		seg.region = Rect2(used)
		_tail.texture = seg
		_tail.width = used.size.y * 2.0
		_tail.default_color = Color.WHITE
		var tip := AtlasTexture.new()
		tip.atlas = sheet
		tip.region = Rect2(img.get_region(Rect2i(64, 0, 64, 64)).get_used_rect().position + Vector2i(64, 0), img.get_region(Rect2i(64, 0, 64, 64)).get_used_rect().size)
		_tail_tip.texture = tip


func _process(_delta: float) -> void:
	var show := attack_id == "special_side" and attack != null and attack.is_active(attack_frame)
	_tail.visible = show and _tail.texture != null
	_tail_tip.visible = _tail.visible
	if not _tail.visible:
		return
	var from := Vector2(TAIL_START.x * facing, TAIL_START.y)
	var to := to_local(hitbox_center(attack))
	_tail.points = PackedVector2Array([from, to])
	_tail_tip.position = to
	_tail_tip.flip_h = facing < 0


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				_hypnotize()
		"special_side":
			if holding != null:
				# Puxa o laçado para perto e passa para o agarrão normal.
				var target := holding
				release_hold()
				attack_frame = attack.total_frames()
				_pull_into_grab(target)
				return
			_catch_in_hitbox()
		"special_up":
			if frame == attack.startup:
				velocity.y = -SPRING_SPEED
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if holding != null:
				attack_frame = attack.startup + 1
				velocity = Vector2.ZERO
				_squeeze_timer += 1
				if _squeeze_timer % 10 == 0:
					holding.add_damage(SQUEEZE_DAMAGE)
				if _squeeze_timer >= SQUEEZE_HOLD:
					throw_held(lasso_throw_data if lasso_throw_data != null else attack, facing)
					attack_frame = attack.startup + attack.active + 1
				return
			if attack.is_active(frame):
				if _catch_in_hitbox():
					_squeeze_timer = 0


## Prende o primeiro lutador dentro da caixa do golpe (sem dano; o dano vem depois).
func _catch_in_hitbox() -> bool:
	if not attack.is_active(attack_frame):
		return false
	var center := hitbox_center(attack)
	for f in get_tree().get_nodes_in_group("fighters"):
		var target := f as Fighter
		if target == self or not target.can_be_hit():
			continue
		if Combat.circle_hits_rect(center, attack.hitbox_radius, target.hurtbox()):
			hold(target)
			return true
	return false


func _pull_into_grab(target: Fighter) -> void:
	if target == null or not is_instance_valid(target):
		return
	target.global_position = global_position + Vector2(facing * (RADIUS * 2.0 + 10.0), 0)
	_start_grab_hold(target)


## Entra no agarrão normal segurando o alvo (arremessos e apertos do Fighter).
func _start_grab_hold(target: Fighter) -> void:
	_end_attack()
	hold(target)
	state = State.HOLDING
	_grab_timer = minf(grab_hold_base + target.damage_percent * 0.01, 4.0)
	_pummel_cooldown = 0


func _hypnotize() -> void:
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		var d := foe.global_position - global_position
		if absf(d.x) <= HYPNO_RANGE and absf(d.y) < 90.0 and signf(d.x) == float(facing):
			foe.hypnotize(HYPNO_TIME)


func _check_hits() -> void:
	if attack_id in ["special_side", "special_down"]:
		return   # laço e abraço não machucam ao encostar: prendem
	super._check_hits()


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_down" and holding != null:
		throw_held(lasso_throw_data if lasso_throw_data != null else moveset.special_down, facing)
