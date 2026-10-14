extends Node
## Autoload "Game": estado global da partida (modo, personagens escolhidos, meta
## de KOs) e troca de telas. Não guarda nada do que acontece dentro da luta.

const MENU_SCENE := "res://scenes/ui/main_menu.tscn"
const MODE_SCENE := "res://scenes/ui/mode_select.tscn"
const SELECT_SCENE := "res://scenes/ui/character_select.tscn"
const OPTIONS_SCENE := "res://scenes/ui/options.tscn"
const HOW_TO_PLAY_SCENE := "res://scenes/ui/how_to_play.tscn"
const MATCH_SCENE := "res://scenes/match.tscn"

## Elenco do primeiro corte. A ordem define a ordem na tela de escolha.
const CHARACTERS: Array[Dictionary] = [
	{
		"name": "Juba",
		"scene": "res://scenes/characters/agil.tscn",
		"retrato": "res://assets/characters/juba/retrato.png",
		"desc": "Mico-leão-dourado capoeirista. Rápido e leve:\ncombos e volta fácil, mas voa mais cedo.",
		"weight": "Leve",
	},
	{
		"name": "Seu Capivas",
		"scene": "res://scenes/characters/pesado.tscn",
		"retrato": "res://assets/characters/seu_capivas/retrato.png",
		"desc": "Capivara tiozão de clube. Lento e pesado:\naguenta muito dano e um acerto lança longe.",
		"weight": "Pesado",
	},
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
