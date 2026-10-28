class_name MatchManager
extends Node2D
## Dono da partida (T16 a T18): monta arena e lutadores a partir de Game, vigia as
## zonas de KO, conta o placar até Game.ko_target, trata KO simultâneo e morte
## súbita, faz a contagem inicial e abre a tela de resultado.

signal ko_scored(scorer: String, victim: String)
signal sudden_death_started
signal match_ended(winner: String)
signal countdown_finished

enum Phase { COUNTDOWN, FIGHT, ENDED }

const ARENA := preload("res://scenes/arena.tscn")
## Teste: força a arena original (as cenas de teste usam a geometria dela).
var use_default_arena := false
const IDS := ["p1", "p2"]
const START_FACING := {"p1": 1, "p2": -1}
const COUNTDOWN_STEPS := ["3", "2", "1", "LUTEM!"]

## Retângulo de KO em coordenadas do mundo: sair dele é KO.
@export var ko_zone := Rect2(-1400, -1200, 2800, 2100)
## Altura em que o lutador reaparece depois de um KO.
@export var respawn_height := -450.0
@export var respawn_invincibility := 2.0
## Segundos parado na plataforma de retorno antes de cair sozinho.
@export var respawn_platform_time := 3.0
## Segundos de cada número da contagem.
@export var countdown_step := 0.8
## Pausa entre o último KO e a tela de resultado.
@export var results_delay := 1.4

var phase := Phase.COUNTDOWN
var sudden_death := false
var fighters := {}
var kos := {"p1": 0, "p2": 0}
var ko_target := 3
## Semente da CPU do P2 no modo CPU (-1 = aleatória). Simulações usam para repetir partidas.
var cpu_seed := -1

var _arena: Node2D
var _start_positions := {}
## Lutadores com a invencibilidade de retorno ainda valendo.
var _respawn_shield := {}
var _count_time := 0.0
var _count_index := -1
## Modo treino (só existe quando Game.mode == "training").
var training: TrainingMode = null
var log_enabled := true
var _match_time := 0.0
var _last_hits := {}
## Estatísticas da partida por jogador (tela de resultado): dano causado, acertos
## e acertos por golpe. Zeradas em start_match().
var stats := {}

@onready var hud: Hud = $Hud
@onready var pause_menu: PauseMenu = $UiLayer/PauseMenu
@onready var results: ResultsScreen = $UiLayer/Results
@onready var camera: Camera2D = $Camera


func _ready() -> void:
	log_enabled = not Game.suppress_scene_changes  # testes não escrevem no registro do playtest
	ko_target = Game.ko_target
	_build_fighters()
	hud.setup(fighters, ko_target)
	pause_menu.match_manager = self
	results.rematch_requested.connect(restart)
	var fx := FxDirector.new()
	fx.name = "Fx"
	add_child(fx)
	fx.watch_match(self)
	start_match()


func _build_fighters() -> void:
	var arena_scene := ARENA if use_default_arena else load(Game.arena_scene()) as PackedScene
	_arena = arena_scene.instantiate()
	add_child(_arena)
	# Zona de KO própria da arena (meta "ko_zone" na raiz ou num filho, posto
	# pelo arena_v2 a partir do formato), senão fica a padrão.
	var zone: Variant = arena_ko_zone(_arena)
	if zone != null:
		ko_zone = zone
	for pid in IDS:
		var marker := _arena.get_node_or_null("Spawn" + pid.capitalize()) as Node2D
		var start: Vector2 = marker.global_position if marker else Vector2(-300 if pid == "p1" else 300, -400)
		_start_positions[pid] = start
		var scene := load(Game.character_scene(pid)) as PackedScene
		var f := scene.instantiate() as Fighter
		f.name = pid.to_upper()
		f.player_id = pid
		f.body_color = Game.PLAYER_COLORS[pid]
		f.facing = START_FACING[pid]
		f.position = start
		f.auto_respawn = false  # a partida cuida de KO e retorno
		f.show_debug_label = false
		add_child(f)
		fighters[pid] = f
	# T20: a CPU assume o P2 neste modo (o teclado/gamepad do jogador 2 deixa de valer).
	if Game.mode == "cpu":
		fighters["p2"].set_cpu(CpuBrain.new(cpu_seed))
	elif Game.mode == "training":
		# Treino: P2 vira boneco, a pausa abre o painel de treino
		training = TrainingMode.new()
		training.name = "Training"
		add_child(training)
		training.setup(self, fighters["p1"], fighters["p2"])
		pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	for pid in IDS:
		(fighters[pid] as Fighter).hit_taken.connect(_on_fighter_hit.bind(pid))
	ko_scored.connect(func(scorer: String, _victim: String) -> void: _set_mood(scorer, "vitoria", 2.4))
	ko_scored.connect(func(scorer: String, _victim: String) -> void:
		var f := fighters.get(scorer) as Fighter
		if f != null and is_instance_valid(f):
			f.on_ko_scored())


## Zera o placar e os lutadores e começa a contagem. Usado na entrada e na revanche.
func start_match() -> void:
	get_tree().call_group("match_cleanup", "queue_free")  # projéteis etc. soltos
	kos = {"p1": 0, "p2": 0}
	sudden_death = false
	_respawn_shield.clear()
	results.visible = false
	for pid in IDS:
		var f: Fighter = fighters[pid]
		f.spawn_point = _start_positions[pid]
		f.respawn()
		f.invincible_time = 0.0
		f.facing = START_FACING[pid]
		f.set_physics_process(false)
	hud.set_kos(kos)
	hud.refresh_damage()
	hud.hide_banner()
	camera.call("_update", 1.0)
	phase = Phase.COUNTDOWN
	_count_time = 0.0
	_count_index = -1
	_match_time = 0.0
	_last_hits.clear()
	_reset_stats()
	if training != null:
		training.on_dummy_respawned()
		skip_countdown()  # treino começa direto


func restart() -> void:
	start_match()


func can_pause() -> bool:
	return phase != Phase.ENDED


# --- Contagem inicial ---

func _process(delta: float) -> void:
	if phase != Phase.COUNTDOWN:
		return
	_count_time += delta
	var index := mini(int(_count_time / countdown_step), COUNTDOWN_STEPS.size() - 1)
	if index != _count_index:
		_count_index = index
		var last := index == COUNTDOWN_STEPS.size() - 1
		hud.show_banner(COUNTDOWN_STEPS[index], 0.7 if last else 0.0, Color(1, 0.82, 0.25) if last else Color.WHITE)
		Sfx.play("fight" if last else "countdown")
		if last:
			_begin_fight()


## Pula o que falta da contagem (útil para testes).
func skip_countdown() -> void:
	if phase == Phase.COUNTDOWN:
		_count_index = COUNTDOWN_STEPS.size() - 1
		hud.hide_banner()
		_begin_fight()


func _begin_fight() -> void:
	phase = Phase.FIGHT
	for f in fighters.values():
		f.set_physics_process(true)
	countdown_finished.emit()


# --- KO, placar e retorno ---

func _physics_process(delta: float) -> void:
	if phase != Phase.FIGHT:
		return
	_match_time += delta
	_update_respawn_shield()
	var out: Array[String] = []
	for pid in IDS:
		if not ko_zone.has_point((fighters[pid] as Fighter).global_position):
			out.append(pid)
	if not out.is_empty():
		resolve_kos(out)


## Resolve KOs do mesmo quadro: cada KO dá ponto ao outro jogador. Se os dois
## saíram juntos, os dois pontuam. Público para os testes poderem forçar KOs.
func resolve_kos(victims: Array[String]) -> void:
	if training != null:
		# Treino não tem placar: só efeito, retorno e o registro do golpe
		for victim in victims:
			ko_scored.emit(other(victim), victim)
			if victim == "p2":
				training.on_dummy_ko()
			respawn_fighter(victim)
			if victim == "p2":
				training.on_dummy_respawned()
		return
	for victim in victims:
		_log_ko(victim)
	var outcome := Scoring.apply_kos(kos, victims, ko_target, sudden_death)
	kos = outcome["kos"]
	sudden_death = outcome["sudden_death"]
	for victim in victims:
		ko_scored.emit(other(victim), victim)
	for victim in victims:
		respawn_fighter(victim)
	hud.set_kos(kos)
	if outcome["winner"] != "":
		end_match(outcome["winner"])
	elif outcome["sudden_death_started"]:
		# Empatados na meta: o próximo KO decide (regra provisória do GDD)
		hud.show_banner("MORTE SÚBITA", 2.0, Color(0.95, 0.2, 0.15))
		sudden_death_started.emit()


## Zona de KO definida pela arena (Rect2) ou null se ela não definir.
static func arena_ko_zone(arena: Node) -> Variant:
	if arena == null:
		return null
	if arena.has_meta("ko_zone"):
		return arena.get_meta("ko_zone")
	for child in arena.get_children():
		if child.has_meta("ko_zone"):
			return child.get_meta("ko_zone")
	return null


func other(pid: String) -> String:
	return "p2" if pid == "p1" else "p1"


# --- Registro do playtest ---

func _on_fighter_hit(attacker: Node2D, data: AttackData, launch: Vector2, victim: String) -> void:
	var move := data.id
	if move == "" and attacker is Fighter:
		move = (attacker as Fighter).attack_id
	_last_hits[victim] = {"golpe": move, "lancamento": roundi(launch.length()), "tempo": _match_time,
		"de": (attacker as Fighter).display_name if attacker is Fighter else "?"}
	# Estatísticas: quem bateu é o outro lado (projéteis também contam para o dono)
	var by := other(victim)
	if not stats.has(by):
		_reset_stats()
	var st: Dictionary = stats[by]
	st["dano"] = float(st["dano"]) + data.damage
	st["acertos"] = int(st["acertos"]) + 1
	var per: Dictionary = st["golpes"]
	var key := move if move != "" else "?"
	per[key] = int(per.get(key, 0)) + 1


func _reset_stats() -> void:
	stats = {}
	for pid in IDS:
		stats[pid] = {"dano": 0.0, "acertos": 0, "golpes": {}}


func _log_ko(victim: String) -> void:
	if not log_enabled:
		return
	var f: Fighter = fighters[victim]
	var pos := f.global_position
	var side := "baixo"
	if pos.x < ko_zone.position.x:
		side = "esquerda"
	elif pos.x > ko_zone.end.x:
		side = "direita"
	elif pos.y < ko_zone.position.y:
		side = "topo"
	var entry := {
		"evento": "ko", "modo": Game.mode, "tempo_s": snappedf(_match_time, 0.1),
		"caiu": Game.player_label(victim), "personagem": f.display_name,
		"dano": snappedf(f.damage_percent, 0.1), "saiu_por": side,
	}
	if _last_hits.has(victim):
		var hit: Dictionary = _last_hits[victim]
		entry["ultimo_golpe"] = hit["golpe"]
		entry["golpe_de"] = hit["de"]
		entry["lancamento"] = hit["lancamento"]
		entry["s_desde_golpe"] = snappedf(_match_time - float(hit["tempo"]), 0.1)
	PlaytestLog.append("partidas.jsonl", entry)


func respawn_fighter(pid: String) -> void:
	var f: Fighter = fighters[pid]
	# Reaparece no alto, no lado de origem; respawn() zera o dano
	f.spawn_point = Vector2((_start_positions[pid] as Vector2).x, respawn_height)
	f.respawn()
	f.invincible_time = respawn_invincibility
	f.start_respawn_hold(respawn_platform_time)  # GDD: reaparece numa plataforma no alto
	_respawn_shield[pid] = true


## A invencibilidade de retorno acaba mais cedo quando o lutador age.
func _update_respawn_shield() -> void:
	for pid in _respawn_shield.keys():
		var f: Fighter = fighters[pid]
		if f.invincible_time <= 0.0:
			_respawn_shield.erase(pid)
		elif f.attack != null:
			f.invincible_time = 0.0
			_respawn_shield.erase(pid)


# --- Fim da partida ---

func end_match(winner: String) -> void:
	phase = Phase.ENDED
	for f in fighters.values():
		f.set_physics_process(false)
	Game.last_result = result_data(winner)
	if log_enabled:
		PlaytestLog.append("partidas.jsonl", {
			"evento": "fim", "modo": Game.mode, "duracao_s": snappedf(_match_time, 0.1),
			"vencedor": Game.player_label(winner), "placar": kos.duplicate(),
			"personagens": Game.last_result["characters"],
		})
	hud.show_banner("FIM!", 0.0, Game.PLAYER_COLORS[winner])
	for pid in IDS:
		_set_mood(pid, "vitoria" if pid == winner else "dor", 999.0)
	match_ended.emit(winner)
	await get_tree().create_timer(results_delay).timeout
	if phase != Phase.ENDED:
		return  # reiniciou nesse meio tempo
	hud.hide_banner()
	results.show_result(Game.last_result)


func result_data(winner: String) -> Dictionary:
	var labels := {}
	var names := {}
	var indices := {}   # índice em Game.CHARACTERS (retrato/arte na tela de resultado)
	for pid in IDS:
		labels[pid] = Game.player_label(pid)
		names[pid] = (fighters[pid] as Fighter).display_name
		indices[pid] = UiArt.char_index_of(fighters[pid])
	# Por jogador: dano causado, KOs e golpe que mais acertou (id e nome legível)
	var per_player := {}
	if stats.is_empty():
		_reset_stats()
	for pid in IDS:
		var st: Dictionary = stats[pid]
		var top := ""
		var top_n := 0
		var per: Dictionary = st["golpes"]
		for move: String in per:
			if int(per[move]) > top_n:
				top = move
				top_n = int(per[move])
		per_player[pid] = {"dano": roundi(float(st["dano"])), "kos": int(kos[pid]), "acertos": int(st["acertos"]),
			"golpe_top": top, "golpe_top_nome": MoveNames.label(top) if top != "" else "", "golpe_top_acertos": top_n}
	return {"winner": winner, "kos": kos.duplicate(), "labels": labels, "characters": names, "indices": indices,
		"stats": per_player}


## Muda o rosto do boneco de um jogador por um tempo (se ele tiver expressões).
func _set_mood(pid: String, face: String, seconds: float) -> void:
	if not fighters.has(pid):
		return
	var visual := (fighters[pid] as Node).get_node_or_null("Visual")
	if visual != null and visual.has_method("set_mood"):
		visual.set_mood(face, seconds)
