class_name FxDirector
extends Node2D
## Efeitos visuais e sons da luta. Escuta os avisos dos lutadores (acerto,
## bloqueio, pulo, pouso, corrida) e da partida (KO, fim) e cria partículas,
## flashes e sons. Não muda nenhuma regra do jogo: dá para remover sem quebrar nada.
## Texturas: assets/fx (Kenney Particle Pack, CC0).

const TEX_SPARK := preload("res://assets/fx/star_06.png")
const TEX_BURST := preload("res://assets/fx/star_08.png")
const TEX_TWINKLE := preload("res://assets/fx/star_04.png")
const TEX_BOLT := preload("res://assets/fx/spark_01.png")
const TEX_SMOKE := preload("res://assets/fx/smoke_04.png")
const TEX_PUFF := preload("res://assets/fx/smoke_07.png")
const TEX_DEBRIS := preload("res://assets/fx/dirt_02.png")
const TEX_RING := preload("res://assets/fx/circle_01.png")
const TEX_GLOW := preload("res://assets/fx/circle_05.png")
const TEX_SLASH := preload("res://assets/fx/slash_02.png")
const TEX_STREAK := preload("res://assets/fx/trace_01.png")

## Lançamento a partir do qual o golpe conta como forte (faísca grande, som pesado).
@export var heavy_launch := 850.0
## Lançamento a partir do qual o lutador deixa rastro de fumaça.
@export var trail_launch := 650.0
## Câmera lenta no KO que decide a partida.
@export var final_ko_slow_motion := true

const DUST := Color(0.9, 0.87, 0.82, 0.75)
const SPARK_CORE := Color(1.0, 0.97, 0.85)
const SHIELD_BLUE := Color(0.6, 0.9, 1.0)

var _trail_tick := 0
var _flash: ColorRect


func _ready() -> void:
	z_index = 0
	for f in get_tree().get_nodes_in_group("fighters"):
		watch(f)
	get_tree().node_added.connect(_on_node_added)
	var layer := CanvasLayer.new()
	layer.layer = 5
	add_child(layer)
	_flash = ColorRect.new()
	_flash.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_flash.set_anchors_preset(Control.PRESET_FULL_RECT)
	_flash.color = Color(1, 1, 1, 0)
	layer.add_child(_flash)


func _on_node_added(node: Node) -> void:
	if node is Fighter:
		watch.call_deferred(node)


## Passa a escutar os avisos de um lutador.
func watch(f: Fighter) -> void:
	if f.hit_taken.is_connected(_on_hit):
		return
	f.hit_taken.connect(_on_hit.bind(f))
	f.blocked.connect(_on_blocked.bind(f))
	f.shield_broken.connect(_on_shield_broken.bind(f))
	f.jumped.connect(_on_jumped.bind(f))
	f.landed.connect(_on_landed.bind(f))
	f.dashed.connect(_on_dashed.bind(f))
	f.respawn_platform_left.connect(_on_platform_left.bind(f))


## Liga os avisos da partida (KO e fim). Chamado pelo MatchManager.
func watch_match(match_node: Node) -> void:
	match_node.ko_scored.connect(_on_ko.bind(match_node))
	match_node.match_ended.connect(_on_match_ended)


func _physics_process(_delta: float) -> void:
	_trail_tick += 1
	if _trail_tick % 3 != 0:
		return
	for f in get_tree().get_nodes_in_group("fighters"):
		var fighter := f as Fighter
		# Sem nuvem desfocada: o rastro no golpe forte fica a cargo dos cortes
		# pixelados do acerto, mantendo a leitura limpa durante o voo.


# --- Acertos ---

## Golpe médio (a partir deste lançamento) já ganha um corte pequeno na cor de quem bateu.
@export var medium_launch := 500.0
## Quanto a faísca sai do centro de quem apanhou para o lado de quem bateu
## (fica na borda do corpo, sem tapar o rosto).
@export var spark_pull := 20.0


func _on_hit(attacker: Node2D, data: AttackData, launch: Vector2, target: Fighter) -> void:
	var speed := launch.length()
	var contact := target.global_position + Vector2(0, -15)
	if attacker != null and is_instance_valid(attacker):
		# Para o lado de quem bateu, mas sempre colado em quem apanhou
		# (com a castanha, quem bateu pode estar do outro lado da arena).
		var dx := attacker.global_position.x - target.global_position.x
		var side := signf(dx) if absf(dx) > 1.0 else float(-target.facing)
		contact.x += side * (minf(absf(dx) * 0.35, 16.0) + spark_pull)
	var heavy := speed >= heavy_launch
	var medium := speed >= medium_launch
	var tint := Color.WHITE
	var body := Color.WHITE
	if attacker is Fighter:
		body = (attacker as Fighter).body_color
		tint = body.lerp(Color.WHITE, 0.55)
	var dir := launch.normalized() if speed > 1.0 else Vector2.RIGHT
	# faísca: núcleo claro com contorno escuro (lê no céu claro e no escuro),
	# nasce grande e encolhe; estrelas espalhadas na direção do lançamento
	var spark := HitSpark.new()
	spark.global_position = contact
	spark.radius = 44.0 if heavy else (36.0 if medium else 30.0)
	spark.scale_from = 0.9 if not heavy else 1.0
	spark.life = 0.22 if heavy else 0.16
	spark.accent = Color.WHITE
	spark.core = SPARK_CORE
	spark.glow = tint
	spark.add_to_group("match_cleanup")
	add_child(spark)
	_burst(TEX_TWINKLE, contact, 14 if heavy else 9, 0.4, 560.0 if heavy else 400.0, 50.0,
		0.5, tint, dir, 0.0)
	if medium:
		# corte na cor do jogador, em mistura normal (aditivo some no céu claro)
		_pop(TEX_SLASH, contact, 1.4 if heavy else 0.9, 0.18, body.lerp(Color.WHITE, 0.2), 0.3 if heavy else 0.25, dir.angle(), false)
	if heavy:
		_screen_flash(0.12)
	Sfx.play_hit(data, speed, heavy)  # mesmo quadro do acerto (início da pausa de impacto)


func _on_blocked(data: AttackData, f: Fighter) -> void:
	_burst(TEX_TWINKLE, f.global_position, 6, 0.25, 260.0, 180.0, 0.3, SHIELD_BLUE, Vector2.UP, 0.0)
	_pop(TEX_RING, f.global_position, 1.0, 0.18, SHIELD_BLUE * Color(1, 1, 1, 0.7), 0.15)
	Sfx.play("shield_hit")


func _on_shield_broken(f: Fighter) -> void:
	_pop(TEX_BOLT, f.global_position + Vector2(-34, -20), 2.2, 0.45, SHIELD_BLUE, 1.2)
	_pop(TEX_BOLT, f.global_position + Vector2(34, -10), 1.8, 0.45, Color.WHITE, 1.0, PI * 0.5)
	_pop(TEX_GLOW, f.global_position, 2.6, 0.4, SHIELD_BLUE * Color(1, 1, 1, 0.7), 1.2)
	_burst(TEX_TWINKLE, f.global_position, 22, 0.7, 520.0, 180.0, 0.55, SHIELD_BLUE, Vector2.UP, 300.0)
	_pop(TEX_RING, f.global_position, 3.0, 0.45, SHIELD_BLUE)
	_screen_flash(0.18, SHIELD_BLUE)
	Sfx.play("shield_break")


# --- Movimento ---

func _on_jumped(in_air: bool, f: Fighter) -> void:
	var feet := f.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
	if in_air:
		_pop(TEX_RING, feet, 0.7, 0.25, f.body_color.lerp(Color.WHITE, 0.6) * Color(1, 1, 1, 0.6), 0.2)
		Sfx.play("jump", -4.0, 0.12)
	else:
		_dust(feet, 4, 0.6)
		Sfx.play("jump")


func _on_landed(fall_speed: float, f: Fighter) -> void:
	if fall_speed < 500.0:
		return
	var feet := f.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
	var power := clampf(fall_speed / 1500.0, 0.4, 1.2)
	_dust(feet, int(4 + 4 * power), power)
	Sfx.play("land", -6.0 + 6.0 * power)


func _on_dashed(f: Fighter) -> void:
	var feet := f.global_position + Vector2(-f.facing * 20.0, Fighter.HEIGHT * 0.5)
	_burst(TEX_PUFF, feet, 3, 0.4, 120.0, 25.0, 0.3, DUST, Vector2(-f.facing, -0.3), 0.0, 1)
	Sfx.play("dash")


func _on_platform_left(f: Fighter) -> void:
	var feet := f.global_position + Vector2(0, Fighter.HEIGHT * 0.5)
	_burst(TEX_TWINKLE, feet, 8, 0.4, 160.0, 180.0, 0.3, f.body_color.lerp(Color.WHITE, 0.4), Vector2.DOWN, 0.0)


func _dust(at: Vector2, amount: int, power: float) -> void:
	_burst(TEX_PUFF, at + Vector2(-18, 0), amount / 2 + 1, 0.45, 150.0 * power, 20.0, 0.55 * power, DUST, Vector2(-1, -0.25), 0.0, 1)
	_burst(TEX_PUFF, at + Vector2(18, 0), amount / 2 + 1, 0.45, 150.0 * power, 20.0, 0.55 * power, DUST, Vector2(1, -0.25), 0.0, 1)


# --- KO e fim de partida ---

func _on_ko(scorer: String, victim: String, match_node: Node) -> void:
	var f: Fighter = match_node.fighters[victim]
	var view := _visible_rect()
	var at := Vector2(clampf(f.global_position.x, view.position.x + 60.0, view.end.x - 60.0),
		clampf(f.global_position.y, view.position.y + 60.0, view.end.y - 60.0))
	var center := view.get_center()
	var out := (f.global_position - center).normalized()
	if out == Vector2.ZERO:
		out = Vector2.UP
	var color := f.body_color.lerp(Color.WHITE, 0.25)
	# feixe saindo da borda da tela, para dentro
	var beam := KoBeam.new()
	beam.global_position = at
	beam.rotation = (-out).angle()
	beam.color = color
	beam.add_to_group("match_cleanup")
	add_child(beam)
	_pop(TEX_BURST, at, 3.0, 0.45, Color.WHITE)
	_pop(TEX_RING, at, 4.0, 0.5, color)
	_burst(TEX_TWINKLE, at, 24, 0.8, 700.0, 70.0, 0.5, color, -out, 200.0)
	_burst(TEX_PUFF, at, 8, 0.9, 260.0, 90.0, 0.8, color * Color(1, 1, 1, 0.6), -out, 0.0)
	_screen_flash(0.25, color)
	get_tree().call_group("fight_camera", "shake", 2600.0)
	Sfx.play("ko")
	Sfx.play("ko_ring")


func _on_match_ended(_winner: String) -> void:
	Sfx.play("match_end")
	if final_ko_slow_motion:
		Engine.time_scale = 0.3
		await get_tree().create_timer(0.7, true, false, true).timeout
		Engine.time_scale = 1.0


func _exit_tree() -> void:
	Engine.time_scale = 1.0  # nunca deixa o jogo preso em câmera lenta


# --- Utilidades ---

## Área do mundo visível pela câmera atual.
func _visible_rect() -> Rect2:
	var cam := get_viewport().get_camera_2d()
	var size := get_viewport_rect().size
	if cam == null:
		return Rect2(Vector2.ZERO, size)
	var world_size := size / cam.zoom
	return Rect2(cam.get_screen_center_position() - world_size * 0.5, world_size)


## Uma imagem que cresce e some (flash, anel, estouro).
func _pop(tex: Texture2D, at: Vector2, scale_to: float, time: float, color: Color, scale_from := 0.4, angle := 0.0, additive := true) -> void:
	var s := Sprite2D.new()
	s.texture = tex
	s.global_position = at
	s.rotation = angle
	s.z_as_relative = false
	s.z_index = 7
	s.modulate = color
	s.scale = Vector2.ONE * scale_from
	if additive:
		var mat := CanvasItemMaterial.new()
		mat.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
		s.material = mat
	s.add_to_group("match_cleanup")
	add_child(s)
	var tw := s.create_tween().set_parallel(true)
	tw.tween_property(s, "scale", Vector2.ONE * scale_to, time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_property(s, "modulate:a", 0.0, time).set_ease(Tween.EASE_IN)
	tw.chain().tween_callback(s.queue_free)


## Partículas de uma vez só, que se apagam sozinhas.
func _burst(tex: Texture2D, at: Vector2, amount: int, life: float, speed: float, spread_deg: float,
		size: float, color: Color, direction: Vector2, gravity_y: float, z := 6) -> void:
	var p := CPUParticles2D.new()
	p.texture = tex
	p.global_position = at
	p.z_as_relative = false
	p.z_index = z  # negativo = atrás dos lutadores (poeira)
	p.one_shot = true
	p.explosiveness = 0.95
	p.amount = maxi(amount, 1)
	p.lifetime = life
	p.direction = direction if direction != Vector2.ZERO else Vector2.UP
	p.spread = spread_deg
	p.initial_velocity_min = speed * 0.5
	p.initial_velocity_max = speed
	p.gravity = Vector2(0, gravity_y)
	p.damping_min = speed * 0.8
	p.damping_max = speed * 1.6
	p.scale_amount_min = size * 0.6
	p.scale_amount_max = size
	p.angle_min = -180.0
	p.angle_max = 180.0
	var ramp := Gradient.new()
	ramp.set_color(0, color)
	ramp.set_color(1, Color(color.r, color.g, color.b, 0.0))
	p.color_ramp = ramp
	var curve := Curve.new()
	curve.add_point(Vector2(0, 0.6))
	curve.add_point(Vector2(0.3, 1.0))
	curve.add_point(Vector2(1, 0.8))
	p.scale_amount_curve = curve
	if z > 0:
		var mat := CanvasItemMaterial.new()
		mat.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
		p.material = mat
	p.add_to_group("match_cleanup")
	add_child(p)
	p.emitting = true
	p.finished.connect(p.queue_free)


## Clarão na tela inteira. Obedece à opção "Tremor de tela" (quem desliga o
## tremor costuma querer menos coisa piscando também).
func _screen_flash(strength: float, color := Color.WHITE) -> void:
	if _flash == null or not Settings.screen_shake:
		return
	_flash.color = Color(color.r, color.g, color.b, strength)
	var tw := _flash.create_tween()
	tw.tween_property(_flash, "color:a", 0.0, 0.18)
