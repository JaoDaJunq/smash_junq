extends RefCounted
## Utilidades compartilhadas da arte da arena: texturas procedurais e materiais.

static var _soft: GradientTexture2D
static var _additive: CanvasItemMaterial


## Brilho radial suave (branco no centro, transparente na borda), gerado em código.
static func soft_glow() -> GradientTexture2D:
	if _soft == null:
		var grad := Gradient.new()
		grad.offsets = PackedFloat32Array([0.0, 0.35, 0.7, 1.0])
		grad.colors = PackedColorArray([
			Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.45),
			Color(1, 1, 1, 0.12), Color(1, 1, 1, 0.0)])
		_soft = GradientTexture2D.new()
		_soft.gradient = grad
		_soft.fill = GradientTexture2D.FILL_RADIAL
		_soft.fill_from = Vector2(0.5, 0.5)
		_soft.fill_to = Vector2(1.0, 0.5)
		_soft.width = 128
		_soft.height = 128
	return _soft


## Material de mistura aditiva para brilhos.
static func additive() -> CanvasItemMaterial:
	if _additive == null:
		_additive = CanvasItemMaterial.new()
		_additive.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return _additive


## Sprite de brilho suave com tamanho (em px), cor e mistura aditiva opcional.
static func glow_sprite(size: Vector2, color: Color, additive_blend := true) -> Sprite2D:
	var s := Sprite2D.new()
	s.texture = soft_glow()
	s.scale = size / 128.0
	s.modulate = color
	if additive_blend:
		s.material = additive()
	return s
