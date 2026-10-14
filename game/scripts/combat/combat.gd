class_name Combat
extends RefCounted
## Regras de combate puras (sem estado), para poder testar sem rodar o jogo.

## Segundos de atordoamento por pixel/segundo de lançamento.
const HITSTUN_PER_SPEED := 0.0004
## Desaceleração horizontal do lançamento (px/s²).
const LAUNCH_DECAY := 900.0


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


## Pausa no impacto: golpes com mais dano congelam um pouco mais.
static func hitstop_frames(damage: float) -> int:
	return 3 + int(damage * 0.35)


static func circle_hits_rect(center: Vector2, radius: float, rect: Rect2) -> bool:
	var closest := Vector2(clampf(center.x, rect.position.x, rect.end.x), clampf(center.y, rect.position.y, rect.end.y))
	return center.distance_squared_to(closest) <= radius * radius
