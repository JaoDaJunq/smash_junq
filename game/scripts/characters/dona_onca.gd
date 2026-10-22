class_name DonaOnca
extends Fighter
## Dona Onça: onça-pintada delegada do bairro (design/personagens/onca.md).
## Pesada. Especiais:
##  - neutro "Rugido": quem está perto, à frente, é empurrado para trás.
##  - lado "Patada carregada": avança com uma patada enorme.
##  - cima "Salto da onça" (recuperação).
##  - baixo "Batida do distintivo": bate o distintivo no chão, onda curta dos dois lados.
## Mecânica própria "Ficha corrida": cada patada que acerta carimba uma ficha no
## adversário (estrelinha em cima dele). Com 3 fichas, o próximo golpe dela que
## acertar é a "voz de prisão": dano x1.5 e lançamento x1.6, e a ficha zera.

const PATADAS := ["jab", "jab_b", "ftilt", "dtilt", "fair", "nair", "special_side"]
const FICHAS_MAX := 3
const PRISAO_DANO := 1.5
const PRISAO_LANCE := 1.6
const ROAR_RADIUS := 260.0
const ROAR_PUSH := 900.0
const POUNCE_SPEED := 760.0
const LEAP_SPEED := 1120.0

var fichas := {}   # Fighter -> quantidade de fichas (0..3)
var _boosted_target: Fighter = null


func ficha_de(f: Fighter) -> int:
	return int(fichas.get(f, 0))


func _marca(f: Fighter) -> FichaMarca:
	var m := f.get_node_or_null("FichaMarca") as FichaMarca
	if m == null:
		m = FichaMarca.new()
		m.name = "FichaMarca"
		m.position = Vector2(0, -HEIGHT * 0.5 - 40)
		f.add_child(m)
	return m


func set_ficha(f: Fighter, n: int) -> void:
	fichas[f] = n
	_marca(f).count = n


func _on_attack_frame(move_id: String, frame: int) -> void:
	if frame == 1:
		_boosted_target = null
		# Alguém com ficha cheia: este golpe vira a voz de prisão.
		for f in fichas:
			if is_instance_valid(f) and ficha_de(f) >= FICHAS_MAX:
				var a := attack.duplicate() as AttackData
				a.damage *= PRISAO_DANO
				a.base_knockback *= PRISAO_LANCE
				a.knockback_growth *= PRISAO_LANCE
				attack = a
				_boosted_target = f
				break
	match move_id:
		"special_neutral":
			if frame == attack.startup:
				for n in get_tree().get_nodes_in_group("fighters"):
					var f := n as Fighter
					if f == null or f == self or not f.can_be_hit():
						continue
					var d := f.global_position - global_position
					if d.length() < ROAR_RADIUS and signf(d.x) == float(facing):
						f.velocity.x = ROAR_PUSH * facing
		"special_side":
			if frame >= attack.startup - 2 and frame <= attack.startup + attack.active:
				velocity.x = POUNCE_SPEED * facing
			elif frame == attack.startup + attack.active + 1:
				velocity.x *= 0.2
		"special_up":
			if frame == attack.startup:
				velocity.y = -LEAP_SPEED
				_attack_in_air = true
				jumped.emit(true)


func _on_hit_landed(target: Fighter, move_id: String) -> void:
	if target == _boosted_target:
		set_ficha(target, 0)
		_boosted_target = null
		return
	if move_id in PATADAS:
		set_ficha(target, mini(FICHAS_MAX, ficha_de(target) + 1))
