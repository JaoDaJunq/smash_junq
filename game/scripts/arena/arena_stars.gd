extends Node2D
## Estrelas fracas no alto do céu (camada quase parada), geradas com semente.

const COLOR_STAR := Color(0.85, 0.88, 1.0)

@export var rng_seed := 7
@export var count := 90
@export var area := Rect2(-3000, -2400, 6000, 1700)


func _draw() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = rng_seed
	for i in count:
		var p := area.position + Vector2(rng.randf() * area.size.x, rng.randf() * area.size.y)
		# Mais densas no alto, mais raras perto do horizonte.
		var fade := 1.0 - (p.y - area.position.y) / area.size.y
		var c := COLOR_STAR
		c.a = rng.randf_range(0.25, 0.85) * fade
		draw_circle(p, rng.randf_range(1.2, 2.6), c)
