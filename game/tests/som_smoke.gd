extends Node
## Teste de fumaça do som (sem janela):
##   godot --headless --path game res://tests/som_smoke.tscn
## Golpe: tipo/volume/tom pelo dano, sem repetir arquivo, toca no mesmo quadro;
## barramentos (limitador, sidechain, Impacto, Voz); abaixada da música;
## assinaturas dos personagens.

var results: Array[String] = []
var failures := 0


func _ready() -> void:
	Music.auto_follow_scene = false
	await get_tree().process_frame
	_test_hits()
	_test_no_repeat()
	await _test_same_frame()
	_test_buses()
	await _test_duck()
	_test_signatures()
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _attack(id: String, damage: float, signature := "") -> AttackData:
	var a := AttackData.new()
	a.id = id
	a.damage = damage
	if signature != "" and "signature_layer" in a:
		a.set("signature_layer", signature)
	return a


func _test_hits() -> void:
	for event in ["hit_light", "hit_medium", "hit_heavy", "ko", "shield_hit", "shield_break",
			"ui_move", "ui_confirm", "ui_back"]:
		_check("Som carregado: " + event, not (Sfx._streams[event] as Array).is_empty(), "")
	Sfx.play_hit(_attack("jab", 2.5), 300.0)
	var light_vol := Sfx.last_hit_volume_db
	var light_pitch := Sfx.last_hit_pitch
	_check("Dano 2.5 usa o som leve", Sfx.last_hit_event == "hit_light", Sfx.last_hit_event)
	_check("Golpe leve agudo (tom ~1.08)", light_pitch > 1.03 and light_pitch < 1.12, "%.3f" % light_pitch)
	Sfx.play_hit(_attack("fair", 7.0), 600.0)
	_check("Dano 7 usa o som médio", Sfx.last_hit_event == "hit_medium", Sfx.last_hit_event)
	Sfx.play_hit(_attack("ftilt", 18.0), 900.0)
	var heavy_vol := Sfx.last_hit_volume_db - float(Sfx.VOLUME["hit_heavy"])
	var light_rel := light_vol - float(Sfx.VOLUME["hit_light"])
	_check("Dano 18 usa o som forte", Sfx.last_hit_event == "hit_heavy", Sfx.last_hit_event)
	_check("Golpe forte grave (tom ~0.90)", Sfx.last_hit_pitch > 0.86 and Sfx.last_hit_pitch < 0.94, "%.3f" % Sfx.last_hit_pitch)
	_check("Volume pelo dano: ~6 dB entre fraco e forte", absf(heavy_vol - light_rel - 6.0) < 1.0,
		"%.1f dB" % (heavy_vol - light_rel))
	Sfx.play_hit(_attack("jab", 3.0), 1000.0, true)
	_check("Lançamento forte usa o som forte", Sfx.last_hit_event == "hit_heavy", Sfx.last_hit_event)


func _test_no_repeat() -> void:
	var repeats := 0
	var last := -1
	for i in 60:
		var idx: int = Sfx._pick("hit_medium", 3)
		if idx == last:
			repeats += 1
		last = idx
	_check("Nunca repete o mesmo arquivo seguido (60 sorteios)", repeats == 0, str(repeats))


func _test_same_frame() -> void:
	for p in Sfx._impact_players:
		p.stop()
	var frame := Engine.get_physics_frames()
	Sfx.play_hit(_attack("jab", 4.0), 300.0)
	var playing := false
	for p in Sfx._impact_players:
		playing = playing or p.playing
	_check("Som do golpe começa no mesmo quadro do acerto", playing and Engine.get_physics_frames() == frame, "")
	await get_tree().process_frame


func _test_buses() -> void:
	var names: Array[String] = []
	for i in AudioServer.bus_count:
		names.append(AudioServer.get_bus_name(i))
	_check("Barramentos Master/SFX/Music/Impacto/Voz", names.has("Master") and names.has("SFX") and names.has("Music")
		and names.has("Impacto") and names.has("Voz"), ", ".join(names))
	var limiter: AudioEffect = null
	for k in AudioServer.get_bus_effect_count(0):
		if AudioServer.get_bus_effect(0, k) is AudioEffectHardLimiter:
			limiter = AudioServer.get_bus_effect(0, k)
	_check("Master tem limitador com teto -1 dB", limiter != null and is_equal_approx((limiter as AudioEffectHardLimiter).ceiling_db, -1.0), "")
	var music := AudioServer.get_bus_index("Music")
	var comp: AudioEffectCompressor = null
	for k in AudioServer.get_bus_effect_count(music):
		if AudioServer.get_bus_effect(music, k) is AudioEffectCompressor:
			comp = AudioServer.get_bus_effect(music, k)
	_check("Music tem compressor sidechain pelo Impacto (-20 dB, 3:1, 150 ms)", comp != null and comp.sidechain == &"Impacto"
		and is_equal_approx(comp.threshold, -20.0) and is_equal_approx(comp.ratio, 3.0) and is_equal_approx(comp.release_ms, 150.0),
		"" if comp == null else "%s %.0f %.1f %.0f" % [comp.sidechain, comp.threshold, comp.ratio, comp.release_ms])
	var imp := AudioServer.get_bus_index("Impacto")
	_check("Impacto sai no SFX e vem depois do Music (sidechain)", imp > music and AudioServer.get_bus_send(imp) == &"SFX", str(imp))
	var routed := true
	for p in Sfx._impact_players:
		routed = routed and p.bus == &"Impacto"
	_check("Golpes saem no barramento Impacto", routed, "")
	_check("Volume do jogador continua no Music", is_equal_approx(AudioServer.get_bus_volume_db(music), linear_to_db(Settings.music_volume))
		or Settings.music_volume == 0.0, "%.1f dB" % AudioServer.get_bus_volume_db(music))


func _test_duck() -> void:
	var music := AudioServer.get_bus_index("Music")
	var player_db := AudioServer.get_bus_volume_db(music)
	Sfx.play_hit(_attack("ftilt", 14.0), Sfx.KILL_LAUNCH + 100.0)
	_check("Golpe que pode matar abaixa a música", Sfx.last_hit_ducked, "")
	await get_tree().create_timer(0.08).timeout
	var ducked: float = Music.duck_db()
	_check("Música ~6 dB abaixo logo depois", ducked < -4.5 and ducked > -7.0, "%.1f dB" % ducked)
	_check("Abaixada não mexe no volume do jogador", is_equal_approx(AudioServer.get_bus_volume_db(music), player_db), "")
	await get_tree().create_timer(0.45).timeout
	_check("Música volta em ~0,25 s", absf(Music.duck_db()) < 0.5, "%.1f dB" % Music.duck_db())
	Sfx.play("ko")
	await get_tree().create_timer(0.08).timeout
	_check("KO abaixa a música", Music.duck_db() < -4.5, "%.1f dB" % Music.duck_db())
	await get_tree().create_timer(0.45).timeout
	Sfx.play_hit(_attack("jab", 3.0), 300.0)
	_check("Golpe fraco não abaixa", not Sfx.last_hit_ducked, "")


func _test_signatures() -> void:
	_check("AttackData tem signature_layer", "signature_layer" in AttackData.new(), "")
	Sfx.play_hit(_attack("ftilt", 12.0, "assinatura_berimbau"), 900.0)
	_check("Golpe forte toca a assinatura", Sfx.last_signature == "assinatura_berimbau", Sfx.last_signature)
	Sfx.play_hit(_attack("jab", 3.0, "assinatura_berimbau"), 300.0)
	_check("Golpe leve não toca a assinatura", Sfx.last_signature == "", Sfx.last_signature)
	Sfx.play_hit(_attack("special_side", 5.0, "assinatura_apito"), 300.0)
	_check("Especial toca a assinatura", Sfx.last_signature == "assinatura_apito", Sfx.last_signature)
	for pair in [["agil", "assinatura_berimbau"], ["tucao", "assinatura_apito"], ["dona_canga", "assinatura_pandeiro"]]:
		var ms := load("res://data/movesets/%s.tres" % pair[0]) as Moveset
		var found := false
		for id in Moveset.SPECIALS + ["ftilt"]:
			var a := ms.move(id)
			if a != null and str(a.get("signature_layer")) == pair[1]:
				found = true
		_check("Moveset %s usa %s" % pair, found, "")


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])
