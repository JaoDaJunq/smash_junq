class_name MoveNames
extends RefCounted
## Nome legível (português, para a tela de resultado) do id interno de um golpe
## ("jab", "fair", "special_side"...). Ids desconhecidos viram texto com a
## primeira letra maiúscula, sem "_".

const NAMES := {
	"jab": "Soco rápido", "jab2": "Soco rápido", "jab3": "Soco rápido",
	"ftilt": "Golpe pra frente", "utilt": "Golpe pra cima", "dtilt": "Rasteira",
	"dash_attack": "Ataque correndo",
	"nair": "Giro no ar", "fair": "Aéreo pra frente", "bair": "Aéreo pra trás",
	"uair": "Aéreo pra cima", "dair": "Aéreo pra baixo",
	"special_neutral": "Especial", "special_side": "Especial pro lado",
	"special_up": "Especial pra cima", "special_down": "Especial pra baixo",
	"fthrow": "Arremesso pra frente", "bthrow": "Arremesso pra trás",
	"uthrow": "Arremesso pra cima", "dthrow": "Arremesso pra baixo",
	"grab": "Agarrão", "pummel": "Agarrão",
}


static func label(id: String) -> String:
	if id == "":
		return "—"
	if NAMES.has(id):
		return NAMES[id]
	var base := id
	# variações numeradas do mesmo golpe ("jab3", "special_side2")
	while base.length() > 1 and base[base.length() - 1].is_valid_int():
		base = base.substr(0, base.length() - 1)
	if NAMES.has(base):
		return NAMES[base]
	return id.replace("_", " ").capitalize()
