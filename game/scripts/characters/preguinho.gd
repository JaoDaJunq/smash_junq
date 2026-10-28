class_name Preguinho
extends Fighter
## Preguinho: macaco-prego faz-tudo (design/personagens/macaco_prego.md, design/proposta-rodada11.md).
## Macacos · Versátil. Mecânica própria "Caixa de ferramentas": o especial neutro troca a
## ferramenta da vez (martelo → chave inglesa → furadeira) e os 3 golpes fortes mudam com ela:
##  - martelo: forte e lento (mais dano e lançamento, +4 quadros de início);
##  - chave inglesa: alcance (30% mais longe);
##  - furadeira: vários acertos (3 fracos que prendem e o último lança).
## Especiais:
##  - lado "Coco quebrado": coquinho em arco; ao bater no chão quebra em 2 pedaços que rolam.
##  - cima "Escada dobrável": abre a escada (2 s) e sobe por ela; o adversário também pode usar.
##  - baixo "Pregar": prego no chão até alguém pisar (1 por vez); quem pisa tropeça.

const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PIX := "res://assets/characters/macaco_prego/pixel/"
const MARTELO := 0
const CHAVE := 1
const FURADEIRA := 2
const TOOL_NAMES := ["Martelo", "Chave inglesa", "Furadeira"]
const TILTS := ["ftilt", "utilt", "dtilt"]
const DRILL_HITS := [3, 6, 9]      # quadros (depois do início) em que a próxima furada pode acertar
const COCO_THROW := Vector2(520.0, -560.0)
const COCO_GRAVITY := 1600.0
const PIECE_SPEED := 380.0
const LADDER_LEAP := 960.0

var tool := MARTELO
var _peck := 1
var _variants := {}
var _icons: Texture2D
var _swap_pop := 0.0


func _ready() -> void:
	super()
	if ResourceLoader.exists(PIX + "ferramentas.png"):
		_icons = load(PIX + "ferramentas.png")


func _physics_process(delta: float) -> void:
	_swap_pop = maxf(_swap_pop - delta * 4.0, 0.0)
	super(delta)


func tool_name() -> String:
	return TOOL_NAMES[tool]


# --- Golpes fortes mudam com a ferramenta ---

func start_attack(move_id: String) -> bool:
	if not super(move_id):
		return false
	if move_id in TILTS:
		attack = _tool_variant(move_id, attack)
	return true


## Cópia (em cache) do golpe forte com a regra da ferramenta da vez.
func _tool_variant(move_id: String, base: AttackData) -> AttackData:
	var key := "%s_%d" % [move_id, tool]
	if _variants.has(key):
		return _variants[key]
	var d := base.duplicate() as AttackData
	match tool:
		MARTELO:
			d.startup += 4
			d.recovery += 3
			d.damage *= 1.45
			d.base_knockback *= 1.1
			d.knockback_growth *= 1.15
			d.hitbox_radius += 3.0
		CHAVE:
			d.hitbox_offset *= 1.3
			d.hitbox_radius += 2.0
			d.damage *= 0.92
		FURADEIRA:
			d.active = 13
			d.damage = 1.4
			d.base_knockback = 100.0
			d.knockback_growth = 0.4
			d.set_meta("furadeira", true)
	_variants[key] = d
	return d


## Furadeira: a última furada é a forte.
func _attack_for(_target: Fighter) -> AttackData:
	if attack == null or not attack.has_meta("furadeira") or _peck < DRILL_HITS.size() + 1:
		return attack
	var key := "%s_fim" % attack_id
	if not _variants.has(key):
		var d := attack.duplicate() as AttackData
		d.damage = 2.6
		d.base_knockback = 270.0
		d.knockback_growth = 5.0
		_variants[key] = d
	return _variants[key]


func _on_attack_frame(move_id: String, frame: int) -> void:
	if attack.has_meta("furadeira"):
		if frame == 1:
			_peck = 1
		elif frame - attack.startup in DRILL_HITS:
			_peck += 1
			_hit_targets.clear()   # cada furada pode acertar de novo
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				tool = (tool + 1) % TOOL_NAMES.size()
				_swap_pop = 1.0
		"special_side":
			if frame == attack.startup:
				_throw_coco()
		"special_up":
			if frame == attack.startup:
				EscadaDobravel.open(self, global_position + Vector2(facing * 26.0, HEIGHT * 0.5))
				velocity.y = -LADDER_LEAP
				velocity.x *= 0.4
				_attack_in_air = true
				jumped.emit(true)
		"special_down":
			if frame == attack.startup:
				_nail()


# --- Coco quebrado ---

func _throw_coco() -> void:
	var d := attack.duplicate() as AttackData
	d.damage = 5.0
	d.hitbox_radius = 16.0
	d.angle = 45.0
	d.base_knockback = 230.0
	d.knockback_growth = 5.0
	var p := Projectile.spawn(PROJECTILE, self, d, global_position + Vector2(facing * 38.0, -30.0),
			Vector2(COCO_THROW.x * facing, COCO_THROW.y), 2.0)
	p.gravity = COCO_GRAVITY
	p.bounces = 0
	if has_art and ResourceLoader.exists(PIX + "coquinho.png"):
		p.set_sprite(_coco_frame(0), 1.5)
	p.landed_still.connect(_on_coco_landed)


## Quadro `i` de coquinho.png (0 = inteiro, 1 = aberto em duas metades) como textura.
func _coco_frame(i: int, half := 0) -> Texture2D:
	var a := AtlasTexture.new()
	a.atlas = load(PIX + "coquinho.png")
	if i == 0:
		a.region = Rect2(0, 0, 64, 64)
	else:   # metades: esquerda (x 0-31) e direita (x 32-63) do 2º quadro
		a.region = Rect2(64 + (0 if half < 0 else 32), 0, 32, 64)
	return a


## O coco bateu no chão: quebra em 2 pedaços que rolam, um para cada lado.
func _on_coco_landed(p: Projectile) -> void:
	if not is_instance_valid(self):
		return
	var d := p.data.duplicate() as AttackData
	d.damage = 3.5
	d.hitbox_radius = 14.0
	d.angle = 50.0
	d.base_knockback = 200.0
	d.knockback_growth = 3.5
	for side in [-1, 1]:
		var tex: Texture2D = _coco_frame(1, side) if has_art and ResourceLoader.exists(PIX + "coquinho.png") else null
		CocoPedaco.launch(self, d, p.global_position + Vector2(side * 10.0, -4.0), PIECE_SPEED * side, tex)


# --- Pregar ---

func _nail() -> void:
	if not is_on_floor():
		return   # no ar não tem onde pregar
	var d := attack.duplicate() as AttackData
	d.damage = 4.0
	d.hitbox_radius = 10.0
	d.angle = 75.0
	d.base_knockback = 190.0
	d.knockback_growth = 2.5
	var from := global_position + Vector2(facing * 46.0, HEIGHT * 0.5 - 20.0)
	var q := PhysicsRayQueryParameters2D.create(from, from + Vector2(0, 50.0), LAYER_STAGE | LAYER_PLATFORM)
	q.exclude = [get_rid()]
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	var spot: Vector2 = hit.position if not hit.is_empty() else global_position + Vector2(0, HEIGHT * 0.5)
	PregoChao.plant(self, spot, d)


# --- Visual ---

func _draw() -> void:
	super()
	# ferramenta da vez em cima da cabeça (pula quando troca)
	if _icons != null:
		var s := 38.0 * (1.0 + 0.35 * _swap_pop)
		var c := Vector2(0.0, -HEIGHT * 0.5 - 86.0)
		draw_circle(c, s * 0.56, Color(0.16, 0.06, 0.07, 0.75))
		draw_texture_rect_region(_icons, Rect2(c - Vector2(s, s) * 0.5, Vector2(s, s)), Rect2(tool * 64, 0, 64, 64))
