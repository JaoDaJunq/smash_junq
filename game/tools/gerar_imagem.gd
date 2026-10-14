extends SceneTree
## Gera uma imagem com a API de imagens da OpenAI (gpt-image-2) e salva o PNG no
## repositório, com um .json ao lado (prompt, parâmetros, uso de tokens) e uma
## linha em assets/manifest.csv. Roda sem janela.
##
## A chave fica só com o criador: o script lê a variável de ambiente OPENAI_API_KEY.
##
## Uso (a partir da raiz do repositório):
##   godot --headless --path game --script res://tools/gerar_imagem.gd -- \
##     --prompt-arquivo art/prompts/juba_folha.txt --saida art/conceitos/juba/folha_v1.png \
##     [--qualidade low|medium|high] [--tamanho 1024x1024|1536x1024|1024x1536] \
##     [--fundo opaque|transparent] [--ref caminho.png]... [--modelo gpt-image-2]
## Também aceita --prompt "texto" no lugar de --prompt-arquivo.
## Com --ref, usa o endpoint de edição: as imagens de referência guiam o resultado.

const API := "https://api.openai.com/v1/images/"

var _http: HTTPRequest


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	var args := _parse(OS.get_cmdline_user_args())
	var repo := ProjectSettings.globalize_path("res://").path_join("..").simplify_path()
	var key := OS.get_environment("OPENAI_API_KEY")
	if key == "":
		_fail("Falta a variável OPENAI_API_KEY. Crie a chave em platform.openai.com e configure no Windows (veja .claude/skills/gerar-arte/SKILL.md).", 2)
		return
	var prompt: String = args.get("prompt", "")
	if args.has("prompt-arquivo"):
		prompt = FileAccess.get_file_as_string(_abs(repo, args["prompt-arquivo"]))
	prompt = prompt.strip_edges()
	if prompt == "" or not args.has("saida"):
		_fail("Informe --prompt (ou --prompt-arquivo) e --saida.", 2)
		return
	var model: String = args.get("modelo", "gpt-image-2")
	var size: String = args.get("tamanho", "1024x1024")
	var quality: String = args.get("qualidade", "medium")
	var background: String = args.get("fundo", "opaque")
	var refs: Array = args.get("ref", [])
	var out_path := _abs(repo, args["saida"])

	_http = HTTPRequest.new()
	_http.timeout = 300.0
	root.add_child(_http)
	var headers := PackedStringArray(["Authorization: Bearer " + key])
	var err := OK
	if refs.is_empty():
		headers.append("Content-Type: application/json")
		var body := JSON.stringify({"model": model, "prompt": prompt, "size": size, "quality": quality,
			"background": background, "n": 1, "output_format": "png"})
		err = _http.request(API + "generations", headers, HTTPClient.METHOD_POST, body)
	else:
		var boundary := "----smashjunq%d" % Time.get_ticks_usec()
		headers.append("Content-Type: multipart/form-data; boundary=" + boundary)
		var data := PackedByteArray()
		for field in [["model", model], ["prompt", prompt], ["size", size], ["quality", quality],
				["background", background], ["n", "1"], ["output_format", "png"]]:
			data.append_array(("--%s\r\nContent-Disposition: form-data; name=\"%s\"\r\n\r\n%s\r\n" % [boundary, field[0], field[1]]).to_utf8_buffer())
		for r in refs:
			var bytes := FileAccess.get_file_as_bytes(_abs(repo, r))
			if bytes.is_empty():
				_fail("Não consegui ler a referência: " + str(r), 2)
				return
			data.append_array(("--%s\r\nContent-Disposition: form-data; name=\"image[]\"; filename=\"%s\"\r\nContent-Type: image/png\r\n\r\n" % [boundary, str(r).get_file()]).to_utf8_buffer())
			data.append_array(bytes)
			data.append_array("\r\n".to_utf8_buffer())
		data.append_array(("--%s--\r\n" % boundary).to_utf8_buffer())
		err = _http.request_raw(API + "edits", headers, HTTPClient.METHOD_POST, data)
	if err != OK:
		_fail("Falha ao enviar o pedido (%s)." % error_string(err), 1)
		return
	print("Gerando imagem (%s, %s, %s)... pode levar até 1-2 minutos." % [model, size, quality])
	var result: Array = await _http.request_completed
	var code: int = result[1]
	var text := (result[3] as PackedByteArray).get_string_from_utf8()
	if code != 200:
		_fail("A API respondeu %d: %s" % [code, text.left(600)], 1)
		return
	var json: Variant = JSON.parse_string(text)
	if typeof(json) != TYPE_DICTIONARY or not json.has("data"):
		_fail("Resposta inesperada da API.", 1)
		return
	var b64: String = json["data"][0].get("b64_json", "")
	var png := Marshalls.base64_to_raw(b64)
	DirAccess.make_dir_recursive_absolute(out_path.get_base_dir())
	var f := FileAccess.open(out_path, FileAccess.WRITE)
	f.store_buffer(png)
	f.close()
	var meta := {"modelo": model, "prompt": prompt, "tamanho": size, "qualidade": quality, "fundo": background,
		"referencias": refs, "uso": json.get("usage", {}), "data": Time.get_datetime_string_from_system()}
	var side := FileAccess.open(out_path.get_basename() + ".json", FileAccess.WRITE)
	side.store_string(JSON.stringify(meta, "  "))
	side.close()
	_append_manifest(repo, out_path, model, size, args.get("saida", ""))
	print("OK: imagem salva em ", out_path)
	quit(0)


func _append_manifest(repo: String, out_path: String, model: String, size: String, rel: String) -> void:
	var manifest := repo.path_join("assets/manifest.csv")
	var m := FileAccess.open(manifest, FileAccess.READ_WRITE)
	if m == null:
		return
	m.seek_end()
	var id := "art_" + rel.get_basename().replace("/", "_").replace("\\", "_")
	m.store_line("%s,conceito,arte gerada por IA,prompt em %s,%s,%s,Termos da OpenAI (saídas do usuário),OpenAI API %s,%s,conceito" % [
		id, rel.get_basename() + ".json", rel, size, model, Time.get_date_string_from_system()])
	m.close()


func _parse(raw: PackedStringArray) -> Dictionary:
	var out := {"ref": []}
	var i := 0
	while i < raw.size():
		var a := raw[i]
		if a.begins_with("--") and i + 1 < raw.size():
			var k := a.trim_prefix("--")
			if k == "ref":
				out["ref"].append(raw[i + 1])
			else:
				out[k] = raw[i + 1]
			i += 2
		else:
			i += 1
	return out


func _abs(repo: String, p: String) -> String:
	if p.is_absolute_path():
		return p
	return repo.path_join(p).simplify_path()


func _fail(msg: String, code: int) -> void:
	printerr("ERRO: ", msg)
	quit(code)
