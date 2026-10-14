class_name PlaytestLog
extends RefCounted
## Registro do playtest: cada evento (KO, fim de partida, golpe no treino) vira
## uma linha JSON num arquivo em user://playtest/. Serve para calibrar a força dos
## golpes com números reais de quem jogou.
## No Windows a pasta fica em %APPDATA%\Godot\app_userdata\Smash Junq\playtest\

## Pasta dos arquivos (os testes trocam por uma pasta própria).
static var dir := "user://playtest"
static var enabled := true


static func append(file: String, entry: Dictionary) -> void:
	if not enabled:
		return
	DirAccess.make_dir_recursive_absolute(dir)
	var path := dir.path_join(file)
	var mode := FileAccess.READ_WRITE if FileAccess.file_exists(path) else FileAccess.WRITE
	var f := FileAccess.open(path, mode)
	if f == null:
		return
	f.seek_end()
	var line := {"quando": Time.get_datetime_string_from_system()}
	line.merge(entry)
	f.store_line(JSON.stringify(line))


## Caminho completo da pasta, para mostrar ao jogador.
static func folder() -> String:
	return ProjectSettings.globalize_path(dir)
