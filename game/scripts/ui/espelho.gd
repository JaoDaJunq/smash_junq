class_name Espelho
extends RefCounted
## Luta-espelho: quando P1 e P2 escolhem o MESMO lutador, só o sprite da luta
## do P2 ganha a "cor 2" (cores 15% mais escuras e contorno na cor do jogador).

const SHADER := preload("res://shaders/paleta_espelho.gdshader")
const PIXEL_SHADER := "res://shaders/pixel_nitido.gdshader"


## Os dois lados com o mesmo personagem (índices de Game.CHARACTERS)?
static func is_mirror(a: int, b: int) -> bool:
	return a >= 0 and a == b


## Material da paleta trocada. nitido: versão com o pixel nítido do sprite da luta.
static func material(nitido := false) -> ShaderMaterial:
	var m := ShaderMaterial.new()
	m.shader = SHADER
	m.set_shader_parameter("nitido", nitido)
	m.set_shader_parameter("outline_color", Game.PLAYER_COLORS["p2"])
	return m


## Troca a paleta do visual de um lutador: o sprite com o shader de pixel
## nítido vira a versão nítida do espelho; outras peças sem material (rigs)
## recebem a versão simples. Retorna quantas peças mudaram.
static func apply_fighter(f: Node) -> int:
	var visual := f.get_node_or_null("Visual")
	if visual == null:
		return 0
	f.set_meta("espelho", true)
	return _apply_tree(visual)


static func _apply_tree(n: Node) -> int:
	var changed := 0
	# O shader fica exclusivamente no quadro animado do sprite de luta. Assim
	# brilhos, roupa, retratos e arte pintada não ganham uma camada ciano.
	if n is Sprite2D and n.name == "Quadro":
		(n as CanvasItem).material = material(true)
		changed += 1
	for c in n.get_children():
		changed += _apply_tree(c)
	return changed


## O lutador está com a paleta do espelho?
static func is_applied(f: Node) -> bool:
	return f.has_meta("espelho")


## Liga/desliga a paleta trocada numa peça da interface (retrato, arte).
static func set_on(c: CanvasItem, on: bool) -> void:
	if on:
		if not (c.material is ShaderMaterial and (c.material as ShaderMaterial).shader == SHADER):
			c.material = material(false)
	elif c.material is ShaderMaterial and (c.material as ShaderMaterial).shader == SHADER:
		c.material = null
