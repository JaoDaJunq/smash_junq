class_name Roster
## Elenco completo na tela de seleção (design/elenco.md): 6 grupos de bichos,
## cada um com os 4 tipos (Rápido, Pesado, Forte, Versátil). "char" é o índice
## em Game.CHARACTERS quando o personagem já é jogável; -1 = em breve ("?").

const TYPES := ["Rápido", "Pesado", "Forte", "Versátil"]

const GROUPS: Array[Dictionary] = [
	{"name": "Macacos", "color": Color("e8a33a"), "slots": [
		{"name": "Juba", "animal": "mico-leão-dourado", "char": 0},
		{"name": "Mestre Muriqui", "animal": "muriqui", "char": -1},
		{"name": "Berrante", "animal": "bugio", "char": 11},
		{"name": "Preguinho", "animal": "macaco-prego", "char": -1},
	]},
	{"name": "Roedores", "color": Color("c98a5a"), "slots": [
		{"name": "Cutia Ligeira", "animal": "cutia", "char": 9},
		{"name": "Seu Capivas", "animal": "capivara", "char": 1},
		{"name": "Espeto", "animal": "ouriço-cacheiro", "char": 14},
		{"name": "Dona Paca", "animal": "paca", "char": -1},
	]},
	{"name": "Felinos", "color": Color("f0c24a"), "slots": [
		{"name": "Maracajá", "animal": "jaguatirica", "char": 2},
		{"name": "Dona Onça", "animal": "onça-pintada", "char": 8},
		{"name": "Suçuarana", "animal": "onça-parda", "char": -1},
		{"name": "Mourisco", "animal": "gato-mourisco", "char": -1},
	]},
	{"name": "Aves", "color": Color("e8503a"), "slots": [
		{"name": "Beija", "animal": "beija-flor", "char": -1},
		{"name": "Dona Canga", "animal": "arara-vermelha", "char": 3},
		{"name": "Tucão", "animal": "tucano", "char": 7},
		{"name": "Marianinha", "animal": "marianinha-de-cabeça-amarela", "char": 4},
	]},
	{"name": "Répteis", "color": Color("6fbf4a"), "slots": [
		{"name": "Calango", "animal": "calango", "char": 10},
		{"name": "Papo-Amarelo", "animal": "jacaré-de-papo-amarelo", "char": 13},
		{"name": "Mestra Sucuri", "animal": "sucuri", "char": 5},
		{"name": "Seu Jabuti", "animal": "jabuti", "char": -1},
	]},
	{"name": "Garrudos", "color": Color("a58c6a"), "slots": [
		{"name": "Bolinha", "animal": "tatu-bola", "char": -1},
		{"name": "Seu Preguiçoso", "animal": "preguiça", "char": 12},
		{"name": "Bandeira", "animal": "tamanduá-bandeira", "char": -1},
		{"name": "Seu Peba", "animal": "tatu-galinha", "char": 6},
	]},
]


static func rows() -> int:
	return GROUPS.size()


static func cols() -> int:
	return TYPES.size()


static func slot(cell: Vector2i) -> Dictionary:
	return GROUPS[cell.y]["slots"][cell.x]


## Célula do personagem jogável de índice i em Game.CHARACTERS.
static func cell_of(char_index: int) -> Vector2i:
	for r in GROUPS.size():
		var slots: Array = GROUPS[r]["slots"]
		for c in slots.size():
			if int(slots[c]["char"]) == char_index:
				return Vector2i(c, r)
	return Vector2i.ZERO
