class_name Moveset
extends Resource
## Golpes de um personagem. Nomes seguem o GDD: básicos no chão, aéreos e especiais.

const GROUND := ["jab", "ftilt", "utilt", "dtilt"]
const AIR := ["nair", "fair", "bair", "uair", "dair"]
const SPECIALS := ["special_neutral", "special_side", "special_up", "special_down"]

@export_group("Chão")
@export var jab: AttackData        ## Golpe rápido, sem direção
@export var ftilt: AttackData      ## Golpe forte lateral
@export var utilt: AttackData      ## Golpe para cima
@export var dtilt: AttackData      ## Golpe baixo
@export_group("Ar")
@export var nair: AttackData
@export var fair: AttackData
@export var bair: AttackData
@export var uair: AttackData
@export var dair: AttackData
@export_group("Especiais")
@export var special_neutral: AttackData
@export var special_side: AttackData
@export var special_up: AttackData
@export var special_down: AttackData


func move(move_id: String) -> AttackData:
	return get(move_id) as AttackData
