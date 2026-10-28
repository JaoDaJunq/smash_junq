class_name Combat
extends RefCounted
## Regras de combate puras (sem estado), para poder testar sem rodar o jogo.

## Segundos de atordoamento por pixel/segundo de lançamento.
const HITSTUN_PER_SPEED := 0.0004
## Desaceleração da velocidade do lançamento (px/s²), separada da gravidade.
const LAUNCH_DECAY := 320.0
## Fração da gravidade aplicada enquanto o lutador está atordoado (voa mais reto).
const HITSTUN_GRAVITY_SCALE := 0.35


## Fórmula do GDD: base + (dano % do alvo × crescimento) × (100 / peso do alvo).
## O dano do golpe já deve estar somado ao percentual do alvo.
static func launch_speed(attack: AttackData, target_percent: float, target_weight: float) -> float:
	return attack.base_knockback + target_percent * attack.knockback_growth * (100.0 / target_weight)


## Direção do lançamento. direction_sign: 1 = lança para a direita, -1 = para a esquerda.
static func launch_vector(attack: AttackData, speed: float, direction_sign: int) -> Vector2:
	var rad := deg_to_rad(attack.angle)
	return Vector2(cos(rad) * direction_sign, -sin(rad)) * speed


static func hitstun_time(speed: float) -> float:
	return speed * HITSTUN_PER_SPEED


## Lançamento a partir do qual o golpe já pode matar: a pausa ganha uns quadros
## a mais (o "segura... PAH" do golpe final).
const KILL_LAUNCH := 1500.0


## Pausa no impacto (quadros a 60/s): golpes com mais dano congelam mais.
## 8% = 9 quadros, 20% = 16, teto 18 (Smash Ultimate: 0.65*dano+6). Com o
## lançamento (launch_speed > 0) de golpe que pode matar, +4 a +6 quadros.
static func hitstop_frames(damage: float, launch_speed := 0.0) -> int:
	var frames := mini(5 + int(damage * 0.55), 18)
	if launch_speed >= KILL_LAUNCH:
		frames += 4 + int(clampf((launch_speed - KILL_LAUNCH) / 500.0, 0.0, 1.0) * 2.0)
	return frames


static func circle_hits_rect(center: Vector2, radius: float, rect: Rect2) -> bool:
	var closest := Vector2(clampf(center.x, rect.position.x, rect.end.x), clampf(center.y, rect.position.y, rect.end.y))
	return center.distance_squared_to(closest) <= radius * radius
