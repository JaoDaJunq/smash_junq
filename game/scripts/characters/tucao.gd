class_name Tucao
extends Fighter
## Tucão: tucano-toco pipoqueiro do estádio (design/personagens/tucano.md e
## design/revisao/novos_personagens.md §2). Forte. Especiais:
##  - neutro "Punhado de pipoca": 3 pipocas em ARCO que sobem, caem e quicam 1x
##    (artilharia leve); cada acerto estoura (fx_pipoca_estouro).
##  - lado "Gol de peixinho": voa reto de bico à frente (no ar não cai); parede alta
##    ou faixa "Interditado" à frente = TRAVE: para e fica tonto.
##  - cima "Cabeceio": sobe de cabeça; projétil perto da cabeça volta para a frente,
##    vira dele e bate 1.5x (pingue-pongue com a roda de baiana da Canga).
##  - baixo "Bicada pilão": no ar mergulha; no chão crava o bico (o chão solta 4
##    pipocas para cima). Se errar, o BICO ENTALA (castigo extra).
## Mecânica "Bico blindado": nos golpes de bico aguenta até ARMOR_MAX de dano por
## golpe sem ser interrompido (estalo laranja visível); passou disso, apanha normal.
## KO "GOOOL": chuva de pipoca em cima dele.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PIPOCA_PATH := "res://assets/characters/tucano/pixel/pipoca.png"
const PIPOCA_COR := Color("f5ecc8")
## Golpes de bico (com o bico blindado) até o fim do ativo.
const BICO := ["jab3", "ftilt", "utilt", "fair", "uair", "dair", "special_side", "special_down"]
const ARMOR_MAX := 12.0          # dano aguentado por golpe; passou disso apanha normal
const PIPOCA_SPEED := 620.0
const PIPOCA_ANGLES := [-0.35, -0.12, 0.10]   # sobem em arco
const PIPOCA_GRAVITY := 1400.0
const PIPOCA_LIFE := 0.9
const PIPOCA_W := 20.0           # largura na tela (px) se a folha pipoca.png chegar
const LUNGE_SPEED := 900.0
const FLY_SPEED := 1120.0
const DIVE_SPEED := 1300.0
const HEADER_RANGE := 70.0
const HEADER_SPEED := 1100.0
const STUCK_EXTRA := 18          # quadros de castigo do bico entalado
const TRAVE_DAZE := 0.45
const TRAVE_REACH := 40.0        # faixa da Onça a menos disso conta como trave

var _armor_taken := 0.0
var _stuck_left := 0
var _flash := 0.0
var _headed: Array = []          # projéteis já cabeceados neste golpe
var trave_count := 0             # (testes) quantas vezes bateu na trave


func is_beak_armored() -> bool:
	return attack != null and attack_id in BICO and attack_frame <= attack.startup + attack.active


func receive_hit(attacker: Node2D, data: AttackData, direction_sign: int) -> bool:
	if data != null and state != State.SHIELD and is_beak_armored() and _armor_taken + data.damage <= ARMOR_MAX:
		_armor_taken += data.damage
		damage_percent += data.damage
		var stop := Combat.hitstop_frames(data.damage)
		_hitstop = stop
		if attacker is Fighter:
			attacker._hitstop = stop
		damage_changed.emit(damage_percent)
		hit_taken.emit(attacker, data, Vector2.ZERO)
		_flash = 0.12
		if move_fx != null:
			move_fx.event("armor")
		return true
	return super(attacker, data, direction_sign)


func _process(delta: float) -> void:
	if _flash > 0.0:
		_flash -= delta
		modulate = Color(1.35, 0.95, 0.6) if _flash > 0.0 else Color.WHITE


func _pipoca(at: Vector2, v: Vector2, data: AttackData, life := PIPOCA_LIFE) -> Projectile:
	var p := Projectile.spawn(PROJECTILE, self, data, at, v, life)
	p.color = PIPOCA_COR
	p.gravity = PIPOCA_GRAVITY
	p.bounces = 1
	p.look = "pipoca"
	if has_art and ResourceLoader.exists(PIPOCA_PATH):
		p.set_sprite_fit(load(PIPOCA_PATH), PIPOCA_W)
	return p


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == 1:
		_armor_taken = 0.0
		_stuck_left = 0
		_headed.clear()
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				for a in PIPOCA_ANGLES:
					var v := Vector2(PIPOCA_SPEED * facing, 0.0).rotated(float(a) * facing)
					_pipoca(hitbox_center(attack), v, attack)
		"special_side":
			if frame >= attack.startup and frame <= attack.startup + attack.active:
				velocity.x = LUNGE_SPEED * facing
				if not is_on_floor():
					velocity.y = 0.0   # peixinho: no ar vai reto
				if _hits_trave():
					_trave()
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.2
		"special_up":
			if frame == attack.startup:
				velocity.y = -FLY_SPEED
				_attack_in_air = true
				jumped.emit(true)
			if attack.is_active(frame):
				_header()
		"special_down":
			if _attack_in_air and frame >= attack.startup / 2 and not is_on_floor():
				velocity = Vector2(velocity.x * 0.3, DIVE_SPEED)
			elif not _attack_in_air:
				if frame == attack.startup:
					_ground_popcorn()
				elif frame == attack.startup + attack.active and _hit_targets.is_empty():
					_stuck_left = STUCK_EXTRA   # errou: o bico entala
					if move_fx != null:   # entalou: a terra trinca de novo (linha do chão da folha: 46)
						move_fx.play_at("fx_bico_entalado", global_position + Vector2(56.0 * facing, HEIGHT * 0.5 - 28.0), 2.0, 0.45)
				elif frame == attack.startup + attack.active + 1 and _stuck_left > 0:
					_stuck_left -= 1
					attack_frame -= 1   # fica preso no chão (sem repetir o ativo)


## Parede alta ou faixa "Interditado" bem à frente durante o peixinho.
func _hits_trave() -> bool:
	if tall_wall_ahead(10.0):
		return true
	var x0 := global_position.x + (RADIUS if facing > 0 else -RADIUS - TRAVE_REACH)
	var ahead := Rect2(x0, global_position.y - HEIGHT * 0.5, TRAVE_REACH, HEIGHT)
	for n in get_tree().get_nodes_in_group("traves"):
		if n.has_method("trave_rect") and n.trave_rect().intersects(ahead):
			return true
	return false


## Bateu na trave: para, quica para trás e fica tonto (estrelinhas na cabeça).
func _trave() -> void:
	trave_count += 1
	_end_attack()
	hypnotize(TRAVE_DAZE)
	_launch = Vector2(-300.0 * facing, -350.0)
	velocity = _launch
	if move_fx != null:
		move_fx.event("trave")


## Cabeceio: projétil perto da cabeça volta para a frente, agora dele, mais forte.
func _header() -> void:
	var head := global_position + Vector2(0, -60)
	for n in get_tree().get_nodes_in_group("projectiles"):
		var p := n as Projectile
		if p == null or p.is_queued_for_deletion() or p.owner_fighter == self or p in _headed:
			continue
		if p.global_position.distance_to(head) <= HEADER_RANGE:
			_headed.append(p)
			p.velocity = Vector2(HEADER_SPEED * facing, -80.0)
			p.owner_fighter = self
			p.return_after = -1.0
			p.lifetime = maxf(p.lifetime, 0.8)
			if p.data != null:
				p.data = p.data.duplicate()
				p.data.damage *= 1.5
			if move_fx != null:
				move_fx.play_at("fx_trave_tranco", p.global_position, 1.2, 0.25, "tranco")


## Pilão no chão: o chão solta 4 pipocas para cima.
func _ground_popcorn() -> void:
	var d := attack.duplicate() as AttackData
	d.damage = 2.0
	d.hitbox_radius = 14.0
	d.base_knockback = 140.0
	d.knockback_growth = 1.0
	d.angle = 80.0
	var at := global_position + Vector2(56.0 * facing, HEIGHT * 0.5 - 16.0)
	for vx in [-120.0, -40.0, 40.0, 120.0]:
		_pipoca(at, Vector2(vx, -700.0), d, 1.0)


## GOOOL: chuva de pipoca em cima dele ao marcar um KO.
func on_ko_scored() -> void:
	if move_fx == null or not is_inside_tree():
		return
	for i in 6:
		var t := get_tree().create_timer(i * 0.13)
		t.timeout.connect(func() -> void:
			if is_instance_valid(self) and move_fx != null:
				var off := Vector2(randf_range(-70.0, 70.0), -HEIGHT * 0.5 - randf_range(80.0, 160.0))
				move_fx.play_at("fx_pipoca_estouro", global_position + off, 1.5, 0.35))
