class_name Marianinha
extends Fighter
## Marianinha: marianinha-de-cabeça-amarela ginasta (design/personagens/marianinha.md).
## Versátil, pequena e leve, 3 pulos no ar. Especiais (rodada 8: aparelhos de ginástica):
##  - neutro "Fita rítmica": gira a fita longa à frente (vários toques, alcance
##    longo); segurando, segue girando e a fita destrói projéteis.
##  - lado "Arco": lança o arco de ginástica; no chão rola e volta para a mão, no ar
##    voa reto.
##  - cima "Cama elástica": deixa uma mini cama elástica no palco por 6 s e quica
##    nela; QUALQUER um que pisar é lançado para o alto.
##  - baixo "Magnésio": bate palma e solta pó de magnésio; quem estiver na nuvem
##    escorrega (quase sem atrito nem controle no chão).
## Mecânicas: "Quique" (cair na cabeça de alguém: dano leve e pulos de volta) e
## "Nota dos jurados": golpes DIFERENTES que acertam em sequência sobem a nota
## (7 a 10); repetir golpe baixa. Com 10, o próximo golpe tira +50% e solta confete.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PIX := "res://assets/characters/marianinha/pixel/"
const BOUNCE_SPEED := 820.0
const BOUNCE_DAMAGE := 2.0
const BOUNCE_COOLDOWN := 0.35
const RIBBON_TICK := 7
const RIBBON_MAX := 70
const HOOP_SPEED := 760.0
const MAGNESIO_RADIUS := 120.0
const MAGNESIO_SLIP := 1.6
const NOTE_MIN := 7
const NOTE_MAX := 10
const PERFECT_BONUS := 1.5

var score := NOTE_MIN          # nota dos jurados (7-10)
var _last_scored := ""
var _perfect_ready := false
var _bounce_cooldown := 0.0
var _ribbon := 0
var _cama: CamaElastica


func _physics_process(delta: float) -> void:
	_bounce_cooldown = maxf(_bounce_cooldown - delta, 0.0)
	super._physics_process(delta)
	_try_bounce()
	queue_redraw()


## Quique: pés caindo em cima da cabeça de outro lutador.
func _try_bounce() -> void:
	if _bounce_cooldown > 0.0 or velocity.y <= 50.0 or is_on_floor():
		return
	if state != State.AIR and not (state == State.ATTACK and _attack_in_air):
		return
	var feet := global_position + Vector2(0, HEIGHT * 0.5)
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		var head := foe.hurtbox()
		if feet.x >= head.position.x - 6.0 and feet.x <= head.end.x + 6.0 \
				and feet.y >= head.position.y - 6.0 and feet.y <= head.position.y + 26.0:
			foe.add_damage(BOUNCE_DAMAGE)
			velocity.y = -BOUNCE_SPEED
			jumps_left = air_jumps
			_bounce_cooldown = BOUNCE_COOLDOWN
			if state == State.ATTACK:
				_end_attack()
			state = State.AIR
			jumped.emit(true)
			return


func _fx(fx_name: String, at: Vector2, time: float) -> void:
	var path := PIX + fx_name + ".png"
	if has_art and ResourceLoader.exists(path):
		PixelFx.spawn(get_parent(), load(path), at, time)


## Folha larga da fita enquanto ela está girando (corpo + fita no mesmo desenho).
func anim_override() -> Array:
	if attack_id == "special_neutral" and attack != null and attack_frame > attack.startup:
		return ["fita", 8.0]
	return []


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == attack.startup and attack.active > 0 and attack.damage > 0.0 and _perfect_ready:
		var scaled := attack.duplicate() as AttackData
		scaled.damage *= PERFECT_BONUS
		scaled.base_knockback *= 1.2
		attack = scaled
	match move_id:
		"special_neutral":
			_ribbon_step(frame)
		"special_side":
			if frame == attack.startup + 1:   # quando a mão já soltou (quadro de impacto)
				_throw_hoop()
		"special_up":
			if frame == attack.startup:
				_place_trampoline()
		"special_down":
			if frame == attack.startup:
				_magnesio()


func _ribbon_step(frame: int) -> void:
	if frame <= attack.startup:
		_ribbon = 0
		return
	_ribbon += 1
	if controls.pressed("special") and _ribbon < RIBBON_MAX:
		attack_frame = attack.startup + 1
	if _ribbon % RIBBON_TICK == 0:
		_hit_targets.clear()
	# A fita girando destrói projéteis que encostam nela.
	var tip := hitbox_center(attack)
	var base := global_position + Vector2(facing * 30.0, tip.y - global_position.y)
	for n in get_tree().get_nodes_in_group("match_cleanup"):
		var p := n as Projectile
		if p == null or p.owner_fighter == self:
			continue
		for k in [0.3, 0.65, 1.0]:
			if p.global_position.distance_to(base.lerp(tip, k)) < attack.hitbox_radius:
				p.queue_free()
				break
	# A fita acerta ao longo dela toda, não só na ponta.
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit() or _hit_targets.has(foe):
			continue
		for k in [0.35, 0.65]:
			if Combat.circle_hits_rect(base.lerp(tip, k), attack.hitbox_radius * 0.7, foe.hurtbox()):
				_hit_targets.append(foe)
				if foe.receive_hit(self, attack, facing):
					_on_hit_landed(foe, "special_neutral")
				break


func _throw_hoop() -> void:
	var at := global_position + Vector2(facing * 40.0, 30.0 if is_on_floor() else -10.0)
	var p := Projectile.spawn(PROJECTILE, self, attack, at, Vector2(HOOP_SPEED * facing, 0.0), 1.8)
	if is_on_floor():
		p.return_after = 0.5   # rola pelo chão e volta para a mão
	if has_art and ResourceLoader.exists(PIX + "arco.png"):
		p.set_sprite(load(PIX + "arco.png"))


func _place_trampoline() -> void:
	if _cama != null and is_instance_valid(_cama):
		_cama.queue_free()
	var at := global_position + Vector2(0, HEIGHT * 0.5)
	var q := PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, 260), LAYER_STAGE)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	if not hit.is_empty():
		at = hit.position
	_cama = CamaElastica.place(self, at)
	# Ela já sai quicando (é a recuperação); no ar, a cama fica flutuando um instante embaixo.
	velocity.y = -CamaElastica.BOUNCE * 0.85
	_attack_in_air = true
	jumped.emit(true)


func _magnesio() -> void:
	var center := global_position + Vector2(facing * 50.0, 0)
	_fx("fx_magnesio", center + Vector2(0, -20), 0.7)
	for f in get_tree().get_nodes_in_group("fighters"):
		var foe := f as Fighter
		if foe == self or not foe.can_be_hit():
			continue
		if foe.global_position.distance_to(center) <= MAGNESIO_RADIUS:
			foe.slip(MAGNESIO_SLIP, facing * 260.0)


## Nota dos jurados.
func _on_hit_landed(_target: Fighter, move_id: String) -> void:
	var base := move_id.trim_suffix("_b").trim_suffix("_c")
	if _perfect_ready:
		_perfect_ready = false
		score = NOTE_MIN
		_last_scored = base
		if has_art and ResourceLoader.exists("res://assets/characters/arara_canga/pixel/fx_confete.png"):
			PixelFx.spawn(get_parent(), load("res://assets/characters/arara_canga/pixel/fx_confete.png"), global_position + Vector2(0, -80), 0.6)
		return
	if base == _last_scored:
		score = maxi(NOTE_MIN, score - 1)
	else:
		score = mini(NOTE_MAX, score + 1)
		if score >= NOTE_MAX:
			_perfect_ready = true
	_last_scored = base


func _draw() -> void:
	super._draw()
	if score <= NOTE_MIN and not _perfect_ready:
		return
	# Plaquinha do jurado acima da cabeça.
	var y := -HEIGHT * 0.5 - 62.0
	var col := Color(1.0, 0.85, 0.2) if _perfect_ready else Color(1, 1, 1)
	draw_rect(Rect2(-17, y, 34, 22), Color(0.16, 0.06, 0.1, 0.9))
	draw_rect(Rect2(-15, y + 2, 30, 18), col)
	draw_string(ThemeDB.fallback_font, Vector2(-16, y + 17), "%d" % score if score < 10 else "10", HORIZONTAL_ALIGNMENT_CENTER, 32, 16, Color(0.16, 0.06, 0.1))
