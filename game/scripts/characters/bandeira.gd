class_name Bandeira
extends Fighter
## Bandeira: tamanduá-bandeira dedetizador (design/personagens/tamandua.md,
## design/proposta-rodada11.md). Forte. Especiais:
##  - neutro "Nuvem de veneno": borrifa uma nuvem que fica 3 s no lugar; quem está
##    dentro tosse (sem escudo) e toma 1% a cada meio segundo (nuvem_veneno.gd).
##  - lado "Língua": língua comprida à frente; engole projétil (cura 2%) ou puxa
##    um pouco o adversário.
##  - cima "Escalada de garra": crava as garras e sobe como numa árvore; pega a
##    borda de mais longe (alcance maior que o normal).
##  - baixo "Abraço de tamanduá": abraço lento e muito forte: segura, aperta e joga.
## Mecânica própria "come praga": tudo que a língua engole de projétil cura 2%.

const JATO_OFFSET := Vector2(108.0, -4.0)   # sai do bico da bomba (era na altura do joelho)
const NUVEM_OFFSET := Vector2(80.0, -40.0)
const TONGUE_FROM := Vector2(34.0, -14.0)      # boca (x vezes o facing)
const TONGUE_TIP := Vector2(138.0, -14.0)
const TONGUE_REACH := 38.0
const EAT_HEAL := 2.0
const CLIMB_SPEED := 700.0
const CLIMB_LAST_FRAME := 24
const CLIMB_LEDGE_REACH := 150.0
const LEDGE_REACH_BOOST := Vector2(140.0, 110.0)
const BOOST_TIME := 1.6
const SQUEEZE_TICK := 12
const SQUEEZE_END := 48
const SQUEEZE_DAMAGE := 2.5
const HUG_THROW_DAMAGE := 6.0

var _nuvem: NuvemVeneno = null
var _squeeze := 0
var _boost := 0.0
var _normal_reach := Vector2.ZERO
var eaten := 0


func _ready() -> void:
	super()
	_normal_reach = ledge_reach


func _physics_process(delta: float) -> void:
	if _boost > 0.0:
		_boost -= delta
		ledge_reach = LEDGE_REACH_BOOST
	else:
		ledge_reach = _normal_reach
	super(delta)


func nuvem() -> NuvemVeneno:
	return _nuvem if is_instance_valid(_nuvem) else null


func _on_attack_frame(move_id: String, frame: int) -> void:
	match move_id:
		"ftilt":
			if frame == attack.startup and move_fx != null:
				move_fx.play_at("fx_jato", global_position + Vector2(JATO_OFFSET.x * facing, JATO_OFFSET.y), 1.5, 0.3)   # jato do bico da bomba
		"special_neutral":
			if frame == attack.startup:
				if is_instance_valid(_nuvem):
					_nuvem.queue_free()
				_nuvem = NuvemVeneno.spawn(self, global_position + Vector2(NUVEM_OFFSET.x * facing, NUVEM_OFFSET.y))
		"special_side":
			if frame > attack.startup and frame <= attack.startup + attack.active:
				_eat_projectiles()
		"special_up":
			_climb(frame)
		"special_down":
			_hug(frame)


## Língua: engole projétil dos outros que encosta nela (da boca até a ponta).
func _eat_projectiles() -> void:
	var a := global_position + Vector2(TONGUE_FROM.x * facing, TONGUE_FROM.y)
	var b := global_position + Vector2(TONGUE_TIP.x * facing, TONGUE_TIP.y)
	for n in get_tree().get_nodes_in_group("projectiles"):
		var p := n as Projectile
		if p == null or p.owner_fighter == self or p.is_queued_for_deletion():
			continue
		var closest := Geometry2D.get_closest_point_to_segment(p.global_position, a, b)
		if closest.distance_to(p.global_position) <= TONGUE_REACH:
			eaten += 1
			var h := minf(EAT_HEAL, damage_percent)
			if h > 0.0:
				add_damage(-h)
			p.queue_free()


## Escalada: sobe devagar e firme, como numa árvore; se há borda ao alcance, agarra.
func _climb(frame: int) -> void:
	if frame >= 4 and frame <= CLIMB_LAST_FRAME:
		velocity.y = -CLIMB_SPEED
		_attack_in_air = true
		if frame == 4:
			jumped.emit(true)
		if frame >= 10 and _try_climb_ledge():
			return   # pendurou na borda: o golpe acabou
	if frame == attack.startup + attack.active:
		_boost = BOOST_TIME


func _try_climb_ledge() -> bool:
	var hand := global_position + Vector2(0, -HEIGHT * 0.35)
	var best: Node2D = null
	var bd := CLIMB_LEDGE_REACH
	for ledge in get_tree().get_nodes_in_group("ledges"):
		var side: int = ledge.get_meta("side", 1)
		if _ledge_taken(ledge):
			continue
		var d: float = (ledge.global_position - hand).length()
		var outside: bool = (hand.x - ledge.global_position.x) * side > -RADIUS * 0.5
		if outside and d < bd:
			best = ledge
			bd = d
	if best != null:
		_on_attack_end(attack_id)
		attack = null
		attack_id = ""
		_grab_ledge(best, int(best.get_meta("side", 1)))
		return true
	return false


## Abraço: lento; ao encostar prende (sem dano), aperta 4 vezes e joga.
func _hug(frame: int) -> void:
	if frame == 1:
		_squeeze = 0
	if holding != null:
		attack_frame = attack.startup + 1   # segura o golpe enquanto aperta
		velocity = Vector2.ZERO
		_squeeze += 1
		if _squeeze % SQUEEZE_TICK == 0:
			holding.add_damage(SQUEEZE_DAMAGE)
			if move_fx != null:
				move_fx.play("fx_tosse", "target", holding, 2.0, true, 0.3, "estrelas")
		if _squeeze >= SQUEEZE_END:
			_hug_throw()
		return
	if attack.is_active(frame):
		var center := hitbox_center(attack)
		for n in get_tree().get_nodes_in_group("fighters"):
			var t := n as Fighter
			if t == null or t == self or not t.can_be_grabbed():
				continue
			if Combat.circle_hits_rect(center, attack.hitbox_radius, t.hurtbox()):
				_squeeze = 0
				hold(t)
				return


func _hug_throw() -> void:
	var d := attack.duplicate() as AttackData
	d.damage = HUG_THROW_DAMAGE
	throw_held(d, facing)
	attack_frame = attack.startup + attack.active + 1


## Apertar botões solta o abraço mais cedo (como o agarrão normal).
func shorten_grab(seconds: float) -> void:
	if attack_id == "special_down" and holding != null:
		_squeeze += int(seconds * 60.0)
	else:
		super(seconds)


func _check_hits() -> void:
	if attack_id == "special_down":
		return   # o abraço não machuca ao encostar: prende
	super()


func _on_attack_end(move_id: String) -> void:
	if move_id == "special_down" and holding != null:
		var d := moveset.special_down.duplicate() as AttackData
		d.damage = HUG_THROW_DAMAGE
		throw_held(d, facing)


func respawn() -> void:
	super()
	_boost = 0.0
	_squeeze = 0
