class_name BolhaMoleza
extends Node2D
## Bolha de moleza do Seu Preguiçoso: quem está dentro (lutadores, menos o dono,
## e projéteis) anda em câmera lenta (slow_factor 0.5 por quadro). Dura TIME s.

const RADIUS := 150.0
const TIME := 4.0
const SLOW := 0.5

var owner_fighter: Fighter
var _t := 0.0


static func spawn(owner_f: Fighter, at: Vector2) -> BolhaMoleza:
	var b := BolhaMoleza.new()
	b.owner_fighter = owner_f
	b.global_position = at
	b.z_index = 4
	b.add_to_group("bolhas_moleza")
	b.add_to_group("match_cleanup")
	owner_f.get_parent().add_child(b)
	return b


func _physics_process(delta: float) -> void:
	_t += delta
	if _t >= TIME:
		queue_free()
		return
	for n in get_tree().get_nodes_in_group("fighters"):
		var f := n as Fighter
		if f != null and f != owner_fighter and _inside(f.global_position):
			f.slow_factor = minf(f.slow_factor, SLOW)
	for n in get_tree().get_nodes_in_group("projectiles"):
		if "slow_factor" in n and n.get("owner_fighter") != owner_fighter and _inside(n.global_position):
			n.slow_factor = minf(n.slow_factor, SLOW)
	queue_redraw()


func _inside(p: Vector2) -> bool:
	return (p - global_position).length() <= RADIUS


func _draw() -> void:
	var grow := minf(1.0, _t * 6.0)
	var fade := clampf((TIME - _t) / 0.4, 0.0, 1.0)
	var r := RADIUS * grow
	draw_circle(Vector2.ZERO, r, Color(0.55, 0.75, 1.0, 0.16 * fade))
	# borda "mole": ondula devagar
	var pts := PackedVector2Array()
	for i in 49:
		var a := i * TAU / 48.0
		var w := 1.0 + 0.035 * sin(a * 5.0 + _t * 2.0)
		pts.append(Vector2.from_angle(a) * r * w)
	draw_polyline(pts, Color(0.16, 0.06, 0.07, 0.8 * fade), 6.0)
	draw_polyline(pts, Color(0.75, 0.9, 1.0, 0.85 * fade), 3.0)
	# zzz flutuando
	for i in 3:
		var k := fmod(_t * 0.35 + i / 3.0, 1.0)
		var p := Vector2(-40 + i * 40, r * 0.3 - k * r * 0.9)
		var s := 6.0 + 4.0 * i
		var c := Color(1, 1, 1, (1.0 - k) * 0.8 * fade)
		draw_polyline(PackedVector2Array([p, p + Vector2(s, 0), p + Vector2(0, s), p + Vector2(s, s)]), c, 2.5)
