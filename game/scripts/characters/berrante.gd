class_name Berrante
extends Fighter
## Berrante: bugio-ruivo radialista (design/personagens/bugio.md,
## design/revisao/novos_personagens.md §6). Forte. Especiais:
##  - neutro "Berro em onda": empurra quem está à frente; mais forte com volume.
##  - lado "Fio do microfone": lança o microfone pelo fio (alcance longo, ponta forte);
##    no ar, se a ponta chegar perto de uma borda, ele se pendura nela (único tether).
##  - cima "Berro foguete": berra para baixo e sobe; altura cresce com o volume.
##  - baixo "Teste do som": sem dano; quem está perto pula de susto (sai do escudo,
##    acorda de hipnose/cochilo) e o volume sobe 1.
## Mecânica "Volume": 4 barrinhas em cima da cabeça. Cada berro +1; cada barra dá
## +8% de dano em tudo. Com 4, o próximo berro é MÁXIMO (dobro) e ele fica rouco
## por 5 s (barra zera; berros viram tosse fraca).

const VOL_MAX := 4
const VOL_BONUS := 0.08
const ROUCO_TIME := 5.0
const BERRO_RADIUS := 300.0
const BERRO_PUSH := 520.0
const SUSTO_RADIUS := 200.0
const CORD_REACH := 210.0
const BERROS := ["special_neutral", "special_up", "special_down"]

var volume := 0
var rouco_time := 0.0
var _maximo := false
var _bar: Node2D


func _ready() -> void:
	super()
	_bar = VolumeBar.new()
	_bar.position = Vector2(0, -HEIGHT * 0.5 - 84)   # acima da setinha "P1"
	add_child(_bar)
	_sync_bar()


func _physics_process(delta: float) -> void:
	super(delta)
	if rouco_time > 0.0:
		rouco_time = maxf(0.0, rouco_time - delta)
		if rouco_time == 0.0:
			_sync_bar()


func is_rouco() -> bool:
	return rouco_time > 0.0


func set_volume(v: int) -> void:
	volume = clampi(v, 0, VOL_MAX)
	_sync_bar()


func _sync_bar() -> void:
	if _bar != null:
		_bar.volume = volume
		_bar.rouco = is_rouco()
		_bar.queue_redraw()


## Folha "rouco" quando está parado e rouco.
func anim_override() -> Array:
	if is_rouco() and state in [State.IDLE, State.WALK]:
		return ["rouco", 5.0]
	return []


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == 1:
		_maximo = false
		var mult := 1.0 + VOL_BONUS * volume
		if move_id in BERROS and not is_rouco() and volume >= VOL_MAX:
			_maximo = true
			mult *= 2.0
		if is_rouco() and move_id in BERROS:
			mult *= 0.4   # tosse
		if mult != 1.0:
			var a := attack.duplicate() as AttackData
			a.damage *= mult
			a.base_knockback *= minf(mult, 1.6)
			attack = a
	match move_id:
		"special_neutral":
			if frame == attack.startup + 2:   # depois do acerto (o acerto redefine o lançamento)
				var push := BERRO_PUSH * (1.0 + 0.2 * volume) * (2.0 if _maximo else 1.0) * (0.3 if is_rouco() else 1.0)
				for f in _foes_within(BERRO_RADIUS * (1.3 if _maximo else 1.0), true):
					if f.state != State.SHIELD:
						_shove(f, Vector2(push * facing, -80.0), 0.35)
				_berrou()
		"special_side":
			if frame == attack.startup + attack.active and _attack_in_air:
				_try_cord_ledge()
		"special_up":
			if frame == attack.startup:
				var rise := 500.0 if is_rouco() else 800.0 + 112.0 * volume
				if _maximo:
					rise = 1300.0
				velocity.y = -rise
				_attack_in_air = true
				jumped.emit(true)
				_berrou()
		"special_down":
			if frame == attack.startup:
				if not is_rouco():
					for f in _foes_within(SUSTO_RADIUS, false):
						_susto(f)
				_berrou()


## Berro feito: sobe o volume; no máximo, fica rouco.
func _berrou() -> void:
	if is_rouco():
		return
	if _maximo:
		volume = 0
		rouco_time = ROUCO_TIME
	else:
		volume = mini(VOL_MAX, volume + 1)
	_sync_bar()


## Pulinho de susto: sai do escudo, acorda de hipnose/atordoamento parado.
func _susto(f: Fighter) -> void:
	if f.state == State.SHIELD:
		f.state = State.IDLE
	if f.state == State.HITSTUN and f._launch == Vector2.ZERO:
		f._hitstun = 0.0   # hipnose/cochilo: acorda
	if f.state in [State.IDLE, State.WALK, State.RUN, State.SHIELD]:
		_shove(f, Vector2(0.0, -560.0), 0.28)
	if move_fx != null:
		move_fx.play("fx_susto", "target_head", f, 2.0, true, 0.6, "estrelas")
	if f.has_method("on_scared"):
		f.on_scared()


## Empurrão sem dano: atordoamento curto com velocidade própria (o estado de
## chão anularia uma velocidade simples no quadro seguinte).
func _shove(f: Fighter, v: Vector2, seconds: float) -> void:
	if f.state == State.HITSTUN:
		f._launch += v
	else:
		f._launch = v
		f._fall = 0.0
		f.state = State.HITSTUN
	f._hitstun = maxf(f._hitstun, seconds)
	f._hitstun_total = maxf(f._hitstun_total, seconds)


func _foes_within(radius: float, only_front: bool) -> Array:
	var out := []
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f == null or f == self or not f.can_be_hit():
			continue
		var d := f.global_position - global_position
		if d.length() > radius:
			continue
		if only_front and signf(d.x) != float(facing):
			continue
		out.append(f)
	return out


## Fio do microfone no ar: se a ponta alcança uma borda livre à frente, pendura.
func _try_cord_ledge() -> void:
	var tip := global_position + Vector2(facing * CORD_REACH, -HEIGHT * 0.3)
	var best: Node2D = null
	var bd := 1e9
	for ledge in get_tree().get_nodes_in_group("ledges"):
		var side: int = ledge.get_meta("side", 1)
		if side != -facing or _ledge_taken(ledge):
			continue   # só borda virada para ele
		var d: float = (ledge.global_position - tip).length()
		var ahead: float = (ledge.global_position.x - global_position.x) * facing
		if d < 120.0 and ahead > 0.0 and d < bd:
			best = ledge
			bd = d
	if best != null:
		_on_attack_end(attack_id)
		attack = null
		attack_id = ""
		_grab_ledge(best, int(best.get_meta("side", 1)))


func respawn() -> void:
	super()
	volume = 0
	rouco_time = 0.0
	_sync_bar()


## 4 barrinhas de equalizador em cima da cabeça.
class VolumeBar:
	extends Node2D
	var volume := 0
	var rouco := false

	func _draw() -> void:
		if volume == 0 and not rouco:
			return
		var cols := [Color("6bd04a"), Color("c8d84a"), Color("f0a020"), Color("e8402a")]
		for i in 4:
			var h := 6.0 + i * 4.0
			var r := Rect2(Vector2(-22 + i * 12, -h), Vector2(9, h))
			draw_rect(r.grow(1.5), Color("2a0f12"))
			var c: Color = cols[i] if i < volume else Color(0.25, 0.2, 0.2, 0.6)
			if rouco:
				c = Color(0.55, 0.55, 0.55, 0.8)
			draw_rect(r, c)
