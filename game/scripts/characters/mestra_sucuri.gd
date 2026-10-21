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
const TAIL_START := Vector2(40, 12)  # onde a cauda sai do rabo enrolado (virada para a direita)
const TAIL_OUT := 6                  # quadros para a cauda esticar até o alvo
const TAIL_BACK := 10                # quadros para recolher
var _hidden_foe: Fighter
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
	_tail.joint_mode = Line2D.LINE_JOINT_ROUND
	var taper := Curve.new()
	taper.add_point(Vector2(0.0, 1.0))
	taper.add_point(Vector2(0.7, 0.85))
	taper.add_point(Vector2(1.0, 0.6))
	_tail.width_curve = taper
	add_child(_tail)
	_tail_tip = Sprite2D.new()
	_tail_tip.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_tail_tip.scale = Vector2(1.1, 1.1)
	_tail_tip.visible = false
	add_child(_tail_tip)
	if ResourceLoader.exists(LACO_PATH):
		var img: Image = (load(LACO_PATH) as Texture2D).get_image()
		img.convert(Image.FORMAT_RGBA8)
		var seg := img.get_region(img.get_region(Rect2i(0, 0, 64, 64)).get_used_rect())
		var tip_rect := img.get_region(Rect2i(64, 0, 64, 64)).get_used_rect()
		var tip := img.get_region(Rect2i(tip_rect.position + Vector2i(64, 0), tip_rect.size))
		for im in [seg, tip]:
			for y in im.get_height():
				for x in im.get_width():
					var c: Color = im.get_pixel(x, y)
					if c.r > 0.7 and c.b > 0.7 and c.g < 0.45:   # franja magenta
						im.set_pixel(x, y, Color(0, 0, 0, 0))
		# Line2D estica a textura ao longo da linha: altura da textura = grossura.
		seg = seg.get_region(Rect2i(1, 0, seg.get_width() - 2, seg.get_height()))
		_tail.texture = ImageTexture.create_from_image(seg)
		_tail.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		_tail.width = seg.get_height() * 1.6
		_tail.default_color = Color.WHITE
		_tail_tip.texture = ImageTexture.create_from_image(tip)


func _process(_delta: float) -> void:
	_update_tail()
	# Abraço: o adversário fica escondido dentro da espiral (folha abraco.png).
	var wrapping := attack_id == "special_down" and holding != null and has_art
	if wrapping and _hidden_foe == null:
		_hidden_foe = holding
		_hidden_foe.visible = false
	elif not wrapping and _hidden_foe != null:
		if is_instance_valid(_hidden_foe):
			_hidden_foe.visible = true
		_hidden_foe = null


## Folha especial para o abraço (o sprite pergunta antes de escolher a animação).
func anim_override() -> Array:
	if attack_id == "special_down" and holding != null:
		return ["abraco", 6.0]
	if _tail.visible:
		return ["especial_lado", -3.0]   # segura a pose do laço enquanto a cauda está fora
	return []


## Cauda do laço: sai do rabo, afina até a ponta, ondula e se estica até o alvo;
## depois recolhe (puxando quem foi laçado).
func _update_tail() -> void:
	var on := attack_id == "special_side" and attack != null and _tail.texture != null
	var ext := 0.0
	if on:
		var f := attack_frame - attack.startup
		var stop := attack.active + TAIL_BACK
		if f < 0 or f > stop:
			on = false
		elif f <= TAIL_OUT:
			ext = float(f) / TAIL_OUT
		elif f <= attack.active:
			ext = 1.0
		else:
			ext = 1.0 - float(f - attack.active) / TAIL_BACK
	_tail.visible = on and ext > 0.05
	_tail_tip.visible = _tail.visible
	if not _tail.visible:
		return
	ext = ext * ext * (3.0 - 2.0 * ext)   # suave
	var from := Vector2(TAIL_START.x * facing, TAIL_START.y)
	var target := to_local(hitbox_center(attack))
	var to := from.lerp(target, ext)
	var dir := (to - from)
	var length := dir.length()
	var normal := Vector2(-dir.y, dir.x).normalized()
	var pts := PackedVector2Array()
	var n := 14
	var phase := float(attack_frame) * 0.6
	for i in n + 1:
		var t := float(i) / n
		# arco para cima + onda que diminui até a ponta (cobra de verdade)
		var arc := sin(t * PI) * minf(length * 0.18, 26.0)
		var wave := sin(t * TAU * 1.5 - phase) * 7.0 * (1.0 - t) * ext
		pts.append(from + dir * t - normal * (arc * facing) + normal * wave)
	_tail.points = pts
	var last := pts[n] - pts[n - 1]
	_tail_tip.position = pts[n]
	_tail_tip.rotation = last.angle() if facing > 0 else last.angle() + PI
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
