class_name AttackData
extends Resource
## Dados de um golpe. Tempos em quadros (60 por segundo). Posições no espaço do
## lutador olhando para a direita: x positivo é para frente, y negativo é para cima.

@export var id := ""

@export_group("Tempo (quadros)")
@export var startup := 4
@export var active := 3
@export var recovery := 10
## Só para golpes aéreos: quadros parados se pousar no meio do golpe.
@export var landing_lag := 6

@export_group("Acerto")
@export var hitbox_offset := Vector2(45, -10)
@export var hitbox_radius := 26.0
@export var damage := 3.0
## Graus. 0 = para frente, 90 = para cima, -90 = para baixo, 180 = para trás.
@export_range(-180.0, 180.0) var angle := 45.0
@export var base_knockback := 300.0
@export var knockback_growth := 6.0

@export_group("Movimento do atacante")
## Impulso aplicado no primeiro quadro (x para frente, y negativo para cima).
@export var self_velocity := Vector2.ZERO
## Depois deste golpe no ar, o lutador não pode pular nem atacar até pousar (recuperação).
@export var helpless_after := false

@export_group("Som")
## Som de assinatura do personagem (nome de evento do Sfx, ex. "assinatura_berimbau")
## tocado 4 dB abaixo do golpe quando este golpe é forte ou especial. Vazio = nenhum.
@export var signature_layer := ""


func total_frames() -> int:
	return startup + active + recovery


func is_active(frame: int) -> bool:
	return frame > startup and frame <= startup + active
