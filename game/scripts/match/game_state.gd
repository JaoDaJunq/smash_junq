extends Node
## Autoload "Game": estado global da partida (modo, personagens escolhidos, meta
## de KOs) e troca de telas. Não guarda nada do que acontece dentro da luta.

const MENU_SCENE := "res://scenes/ui/main_menu.tscn"
const MODE_SCENE := "res://scenes/ui/mode_select.tscn"
const SELECT_SCENE := "res://scenes/ui/character_select.tscn"
const OPTIONS_SCENE := "res://scenes/ui/options.tscn"
const CONTROLS_SCENE := "res://scenes/ui/controls.tscn"
const HOW_TO_PLAY_SCENE := "res://scenes/ui/how_to_play.tscn"
const ARENA_SELECT_SCENE := "res://scenes/ui/arena_select.tscn"
const MATCH_SCENE := "res://scenes/match.tscn"

## Elenco do primeiro corte. A ordem define a ordem na tela de escolha.
const CHARACTERS: Array[Dictionary] = [
	{
		"name": "Juba",
		"scene": "res://scenes/characters/agil.tscn",
		"retrato": "res://assets/characters/juba/retrato.png",
		"desc": "Mico-leão-dourado capoeirista. Rápido e leve:\ncombos e volta fácil, mas voa mais cedo.",
		"weight": "Leve",
		"id": "juba",
		"stats": {"Velocidade": 5, "Força": 2, "Peso": 1, "Volta ao palco": 5},
	},
	{
		"name": "Seu Capivas",
		"scene": "res://scenes/characters/pesado.tscn",
		"retrato": "res://assets/characters/seu_capivas/retrato.png",
		"desc": "Capivara tiozão de clube. Lento e pesado:\naguenta muito dano e um acerto lança longe.",
		"weight": "Pesado",
		"id": "seu_capivas",
		"stats": {"Velocidade": 2, "Força": 5, "Peso": 5, "Volta ao palco": 2},
	},
	{
		"name": "Maracajá",
		"scene": "res://scenes/characters/maracaja.tscn",
		"desc": "Jaguatirica malandra do parkour. Rápido e rasteiro:\nbotes de longe, gruda na parede e pula de novo.",
		"weight": "Leve",
		"id": "maracaja",
		"stats": {"Velocidade": 5, "Força": 2, "Peso": 2, "Volta ao palco": 4},
	},
	{
		"name": "Dona Canga",
		"scene": "res://scenes/characters/dona_canga.tscn",
		"desc": "Arara-canga baiana da escola de samba. Pesada que dança:\nno ritmo da bateria o golpe bate mais forte.",
		"weight": "Pesado",
		"id": "arara_canga",
		"stats": {"Velocidade": 2, "Força": 4, "Peso": 5, "Volta ao palco": 3},
	},
	{
		"name": "Marianinha",
		"scene": "res://scenes/characters/marianinha.tscn",
		"desc": "Ginasta de trampolim, pequena e elétrica:\n3 pulos no ar e quica na cabeça dos outros.",
		"weight": "Muito leve",
		"id": "marianinha",
		"stats": {"Velocidade": 4, "Força": 2, "Peso": 1, "Volta ao palco": 5},
	},
	{
		"name": "Mestra Sucuri",
		"scene": "res://scenes/characters/mestra_sucuri.tscn",
		"desc": "Sucuri faixa-preta de jiu-jitsu. A rainha dos agarrões:\nlaça de longe, hipnotiza e aperta.",
		"weight": "Pesado",
		"id": "sucuri",
		"stats": {"Velocidade": 2, "Força": 5, "Peso": 4, "Volta ao palco": 2},
	},
	{
		"name": "Seu Peba",
		"scene": "res://scenes/characters/seu_peba.tscn",
		"desc": "Tatu-peba sanfoneiro de forró. Versátil e cascudo:\nnas costas o casco segura metade do golpe.",
		"weight": "Médio",
		"id": "tatu_peba",
		"stats": {"Velocidade": 3, "Força": 3, "Peso": 4, "Volta ao palco": 3},
	},
	{
		"name": "Tucão",
		"scene": "res://scenes/characters/tucao.tscn",
		"desc": "Tucano pipoqueiro do estádio. Forte e cabeçudo:
de bico ninguém interrompe, aguenta o tranco e bate.",
		"weight": "Pesado",
		"id": "tucano",
		"stats": {"Velocidade": 3, "Força": 5, "Peso": 4, "Volta ao palco": 3},
	},
	{
		"name": "Dona Onça",
		"scene": "res://scenes/characters/dona_onca.tscn",
		"desc": "Onça-pintada delegada do bairro. Pesada e implacável:\ncada patada vai pra ficha, na 3ª é voz de prisão.",
		"weight": "Pesado",
		"id": "onca",
		"stats": {"Velocidade": 3, "Força": 5, "Peso": 5, "Volta ao palco": 2},
	},
	{
		"name": "Cutia Ligeira",
		"scene": "res://scenes/characters/cutia.tscn",
		"desc": "Cutia vendedora de castanha da feira. Rápida e esperta:\nenterra castanhas que estouram em quem pisar.",
		"weight": "Leve",
		"id": "cutia",
		"stats": {"Velocidade": 5, "Força": 2, "Peso": 2, "Volta ao palco": 4},
	},
]

## Arenas. "Ruínas da Mata" é a original (desenhada por código); as outras usam
## arte importada por tools/importar_arena.py.
const ARENAS: Array[Dictionary] = [
	{"name": "Ruínas da Mata", "scene": "res://scenes/arena.tscn", "preview": "res://assets/arenas/previa_ruinas.png", "pin": Vector2(0.77, 0.72),
		"desc": "A clássica: palco largo de pedra flutuando no entardecer e duas plataformas no alto."},
	{"name": "Pantanal", "scene": "res://scenes/arenas/pantanal.tscn", "preview": "res://assets/arenas/pantanal/previa.png", "pin": Vector2(0.39, 0.59),
		"desc": "Uma ilha de barro no meio da lagoa e duas vitórias-régias que sobem e descem dos lados."},
	{"name": "Caatinga", "scene": "res://scenes/arenas/caatinga.tscn", "preview": "res://assets/arenas/caatinga/previa.png", "pin": Vector2(0.80, 0.33),
		"desc": "Chão largo com uma laje de pedra alta à esquerda e tábuas em alturas diferentes."},
	{"name": "Cerrado", "scene": "res://scenes/arenas/cerrado.tscn", "preview": "res://assets/arenas/cerrado/previa.png", "pin": Vector2(0.61, 0.49),
		"desc": "Palco compacto e alto, ilhas de terra dos lados e três galhos de ipê em triângulo."},
]

const PLAYER_COLORS := {
	"p1": Color(0.31, 0.55, 1.0),
	"p2": Color(1.0, 0.42, 0.35),
}

## "versus" (2 jogadores), "cpu" (P2 controlado pela CPU, ver T20) ou "training" (P2 é um boneco).
var mode := "versus"
## Caminho da cena do personagem de cada jogador.
var characters := {
	"p1": CHARACTERS[0]["scene"],
	"p2": CHARACTERS[1]["scene"],
}
var ko_target := 3
## Índice em ARENAS; -1 = aleatória (sorteada a cada partida).
var arena_index := 0
## Resultado da última partida (preenchido pelo MatchManager).
var last_result := {}
## Teste: quando true, go_to() só registra o pedido em requested_scene.
var suppress_scene_changes := false
var requested_scene := ""


func character_scene(player_id: String) -> String:
	return characters[player_id]


func character_index(player_id: String) -> int:
	for i in CHARACTERS.size():
		if CHARACTERS[i]["scene"] == characters[player_id]:
			return i
	return 0


## Cena da arena da próxima partida (sorteia se a escolha for "aleatória").
func arena_scene() -> String:
	var options := ARENAS.filter(arena_ready)
	if arena_index >= 0 and arena_index < ARENAS.size() and arena_ready(ARENAS[arena_index]):
		return ARENAS[arena_index]["scene"]
	return options[randi() % options.size()]["scene"]


## A arena tem cena e (se usa arte) a arte já importada?
func arena_ready(a: Dictionary) -> bool:
	if not ResourceLoader.exists(a["scene"]):
		return false
	var key := String(a["scene"]).get_file().get_basename()
	return a["scene"] == ARENAS[0]["scene"] or FileAccess.file_exists("res://assets/arenas/%s/blocos.png" % key)


func arena_name(index: int) -> String:
	return "Aleatória" if index < 0 else ARENAS[index]["name"]


func set_character(player_id: String, index: int) -> void:
	characters[player_id] = CHARACTERS[index]["scene"]


## Nome exibido de quem controla o lado: "Jogador 1", "Jogador 2" ou "CPU".
func player_label(player_id: String) -> String:
	if player_id == "p2" and mode == "training":
		return "Boneco"
	if player_id == "p2" and mode == "cpu":
		return "CPU"
	return "Jogador " + player_id.trim_prefix("p")


func go_to(path: String) -> void:
	requested_scene = path
	if suppress_scene_changes:
		return
	get_tree().paused = false
	get_tree().change_scene_to_file(path)


func go_menu() -> void:
	go_to(MENU_SCENE)


## Só um jogador humano escolhe os dois lutadores (contra a CPU ou treino).
func is_single_player() -> bool:
	return mode == "cpu" or mode == "training"


## O lutador já tem os sprites importados (senão aparece como "?" na grade).
func character_ready(index: int) -> bool:
	if index < 0 or index >= CHARACTERS.size():
		return false
	return FileAccess.file_exists("res://assets/characters/%s/pixel/animacoes.json" % CHARACTERS[index].get("id", ""))
