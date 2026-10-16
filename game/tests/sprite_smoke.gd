extends Node
## Teste dos lutadores em pixel art (sem janela): roda a luta de verdade, confere
## que cada estado mostra a animação certa (golpes no quadro de impacto durante
## os quadros ativos, pés na base do lutador, espelhamento) e desenha uma tira de
## filme com os quadros mostrados, ampliados, para conferência.
##   godot --headless --path game res://tests/sprite_smoke.tscn
## Saída: evidence/etapa-3/pixel/<personagem>.png (outra pasta, a partir da
## raiz do repositório: ... -- --saida=evidence/playtest-01)

const MAIN := preload("res://scenes/main.tscn")
const ZOOM := 2
const CELL := Vector2i(150, 150)

var results: Array[String] = []
var failures := 0
var out_dir := ""


func _ready() -> void:
	var sub := "evidence/etapa-3/pixel"
	for arg in OS.get_cmdline_user_args():
		if arg.begins_with("--saida="):
			sub = arg.trim_prefix("--saida=")
	out_dir = ProjectSettings.globalize_path("res://").path_join("..").path_join(sub)
	DirAccess.make_dir_recursive_absolute(out_dir)
	var main := MAIN.instantiate()
	add_child(main)
	var p1: Fighter = main.get_node("P1")
	var p2: Fighter = main.get_node("P2")
	await _frames(40)
	await _film(p1, p2, "juba")
	await _film(p2, p1, "seu_capivas")
	print("\n".join(results))
	print("RESULTADO: %s (%d falha(s))" % ["OK" if failures == 0 else "FALHOU", failures])
	get_tree().quit(failures)


func _film(f: Fighter, other: Fighter, file: String) -> void:
	var v := f.get_node_or_null("Visual") as PixelSprite
	var tag := f.display_name
	_check("%s tem sprite em pixel art" % tag, v != null and v._counts.size() >= 20, str(v._counts.size()) if v else "sem nó Visual")
	if v == null:
		return
	_check("%s esconde o retângulo greybox" % tag, f.has_art, "")
	var pid := f.player_id
	var rows := {}
	other.global_position = Vector2(480, -56)
	other.velocity = Vector2.ZERO
	await _reset(f)
	rows["parado"] = await _record(f, v, 36, 6)
	_check("%s parado usa 'parado'" % tag, v.anim == "parado", v.anim)
	_check("%s pés na base do lutador" % tag, absf(_feet_y(v) - Fighter.HEIGHT * 0.5) <= 2.0, "pés em y=%.1f" % _feet_y(v))
	await _reset(f)
	Input.action_press(pid + "_right", 0.6)
	await _frames(6)
	rows["andar"] = await _record(f, v, 60, 5)
	_check("%s andando usa 'andar'" % tag, v.anim == "andar", v.anim)
	var walked := {}
	for shot in rows["andar"]:
		walked[shot["frame"]] = true
	var extra := walked.keys().filter(func(i: int) -> bool: return not v.walk_frames.is_empty() and i not in v.walk_frames)
	_check("%s andar só usa os quadros escolhidos" % tag, extra.is_empty(), "fora da lista: %s" % str(extra))
	Input.action_release(pid + "_right")
	await _reset(f)
	Input.action_press(pid + "_right", 1.0)
	await _frames(10)
	rows["correr"] = await _record(f, v, 48, 4)
	_check("%s correndo usa 'correr'" % tag, v.anim == "correr", v.anim)
	Input.action_release(pid + "_right")
	await _reset(f)
	_double_jump(pid)
	rows["pulo"] = await _record(f, v, 72, 6)
	for move in ["jab", "ftilt", "utilt", "dtilt", "special_neutral"]:
		await _reset(f)
		if not f.start_attack(move):
			continue
		var data := f.attack
		var total: int = data.startup + data.active + data.recovery
		var impact_ok := true
		var shots := []
		var shown_af := -1  # quadro de ataque que o visual já desenhou (ele roda depois da física)
		for i in total + 2:
			await get_tree().physics_frame
			await get_tree().process_frame
			if shown_af > data.startup and shown_af <= data.startup + data.active:
				impact_ok = impact_ok and v.frame == int(v._impact[v.anim])
			shown_af = f.attack_frame if f.state == Fighter.State.ATTACK else -1
			if i % maxi(1, total / 9) == 0:
				shots.append(_shot(f, v))
		rows[move] = shots
		_check("%s %s mostra o quadro de impacto nos quadros ativos" % [tag, move], impact_ok, PixelSprite.ATTACK_ANIM[move])
	# Leva um golpe
	await _reset(f)
	other.global_position = f.global_position + Vector2(70, 0)
	await _frames(3)
	f.receive_hit(other, other.throw_data("fthrow"), -1)
	var hurt := false
	for i in 10:
		await get_tree().physics_frame
		await get_tree().process_frame
		hurt = hurt or v.anim == "dor"
	_check("%s apanhando usa 'dor'" % tag, hurt, v.anim)
	other.global_position = Vector2(480, -56)
	f.facing = -1
	await get_tree().process_frame
	await get_tree().process_frame
	_check("%s espelha ao virar" % tag, v.scale.x < 0.0, "escala %.2f" % v.scale.x)
	f.facing = 1
	_render(v, rows, out_dir.path_join(file + ".png"))


func _double_jump(pid: String) -> void:
	Input.action_press(pid + "_jump")
	await _frames(4)
	Input.action_release(pid + "_jump")
	await _frames(20)
	Input.action_press(pid + "_jump")
	await _frames(3)
	Input.action_release(pid + "_jump")


func _reset(f: Fighter) -> void:
	for a in ["_left", "_right", "_jump"]:
		Input.action_release(f.player_id + a)
	f.global_position = Vector2(-300, -56)
	f.velocity = Vector2.ZERO
	f.facing = 1
	await _frames(25)


func _record(f: Fighter, v: PixelSprite, frames: int, step: int) -> Array:
	var shots := []
	for i in frames:
		await get_tree().physics_frame
		await get_tree().process_frame
		if i % step == 0:
			shots.append(_shot(f, v))
	return shots


func _shot(f: Fighter, v: PixelSprite) -> Dictionary:
	return {"anim": v.anim, "frame": v.frame, "xf": v.transform, "floor": -f.global_position.y}


## Linha mais baixa visível do quadro atual, em coordenadas do lutador.
func _feet_y(v: PixelSprite) -> float:
	var img := (v._textures[v.anim] as Texture2D).get_image()
	var bottom := 0
	for y in PixelSprite.NATIVE:
		for x in PixelSprite.NATIVE:
			if img.get_pixel(v.frame * PixelSprite.NATIVE + x, y).a > 0.5:
				bottom = y
	return v.position.y + v.scale.y * (-(PixelSprite.BASELINE + 1) + bottom + 1)


func _render(v: PixelSprite, rows: Dictionary, path: String) -> void:
	var images := {}
	for a in v._textures:
		var img := Image.load_from_file(ProjectSettings.globalize_path(v.folder.path_join(a + ".png")))
		img.convert(Image.FORMAT_RGBA8)
		images[a] = img
	var cols := 0
	for r in rows.values():
		cols = maxi(cols, r.size())
	var sheet := Image.create(CELL.x * cols, CELL.y * rows.size(), false, Image.FORMAT_RGBA8)
	sheet.fill(Color(0.42, 0.27, 0.55))
	var y := 0
	for key in rows:
		var x := 0
		for shot in rows[key]:
			var clip := Rect2i(x * CELL.x, y * CELL.y, CELL.x, CELL.y)
			var origin := Vector2(clip.position.x + CELL.x * 0.5, clip.position.y + CELL.y * 0.4)
			var floor_y := int(origin.y + float(shot["floor"]))
			if floor_y < clip.end.y:
				sheet.fill_rect(Rect2i(clip.position.x, floor_y, CELL.x, clip.end.y - floor_y), Color(0.25, 0.16, 0.33))
				sheet.fill_rect(Rect2i(clip.position.x, floor_y, CELL.x, 1), Color(1, 1, 1, 0.8))
			var xf: Transform2D = shot["xf"]
			var src: Image = images[shot["anim"]]
			var fx: int = int(shot["frame"]) * PixelSprite.NATIVE
			for py in PixelSprite.NATIVE:
				for px in PixelSprite.NATIVE:
					var c := src.get_pixel(fx + px, py)
					if c.a < 0.5:
						continue
					var local := Vector2(px - v.center_x, py - (PixelSprite.BASELINE + 1))
					var p0 := origin + xf * local
					var p1 := origin + xf * (local + Vector2.ONE)
					var r := Rect2i(Vector2i(p0.min(p1)), Vector2i((p1 - p0).abs().ceil()))
					sheet.fill_rect(r.intersection(clip), c)
			sheet.fill_rect(Rect2i(clip.position.x, clip.position.y, 1, CELL.y), Color(0.1, 0.1, 0.15))
			x += 1
		sheet.fill_rect(Rect2i(0, y * CELL.y, sheet.get_width(), 1), Color(0.1, 0.1, 0.15))
		y += 1
	sheet.save_png(path)
	results.append("[--] tira salva: %s (%s)" % [path.get_file(), ", ".join(rows.keys())])


func _check(name: String, ok: bool, detail: Variant = "") -> void:
	if not ok:
		failures += 1
	results.append("[%s] %s — %s" % ["OK" if ok else "FALHA", name, str(detail)])


func _frames(n: int) -> void:
	for i in n:
		await get_tree().physics_frame
