class_name Scoring
extends RefCounted
## Regras puras do placar (GDD, seção Regras), sem estado, para testar sem jogo.
## Cada KO dá ponto ao outro jogador; KOs no mesmo quadro pontuam juntos.
## Vence quem chegar à meta primeiro; empate na meta vira morte súbita
## (regra provisória): o próximo KO que desempatar decide.


static func other(pid: String) -> String:
	return "p2" if pid == "p1" else "p1"


## Aplica os KOs de um quadro. Retorna:
##   kos: novo placar  ·  winner: "p1", "p2" ou "" (segue a partida)
##   sudden_death: se a partida está em morte súbita  ·  sudden_death_started: começou agora
static func apply_kos(kos: Dictionary, victims: Array, ko_target: int, sudden_death: bool) -> Dictionary:
	var next := kos.duplicate()
	for victim in victims:
		next[other(victim)] += 1
	var result := {"kos": next, "winner": "", "sudden_death": sudden_death, "sudden_death_started": false}
	var a: int = next["p1"]
	var b: int = next["p2"]
	if maxi(a, b) < ko_target:
		return result
	if a != b:
		result["winner"] = "p1" if a > b else "p2"
	elif not sudden_death:
		result["sudden_death"] = true
		result["sudden_death_started"] = true
	return result
