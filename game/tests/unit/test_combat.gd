extends GdUnitTestSuite
## Testes unitários das regras puras de combate (T21).


func _attack(base: float, growth: float, angle := 45.0, damage := 10.0) -> AttackData:
	var data := AttackData.new()
	data.base_knockback = base
	data.knockback_growth = growth
	data.angle = angle
	data.damage = damage
	return data


func test_launch_speed_is_base_at_zero_percent() -> void:
	var data := _attack(300.0, 6.0)
	assert_float(Combat.launch_speed(data, 0.0, 100.0)).is_equal_approx(300.0, 0.001)


func test_launch_speed_follows_gdd_formula() -> void:
	# base + (dano % × crescimento) × (100 / peso)
	var data := _attack(300.0, 6.0)
	assert_float(Combat.launch_speed(data, 50.0, 100.0)).is_equal_approx(600.0, 0.001)
	assert_float(Combat.launch_speed(data, 50.0, 125.0)).is_equal_approx(540.0, 0.001)


func test_more_damage_launches_faster() -> void:
	var data := _attack(300.0, 6.0)
	var low := Combat.launch_speed(data, 20.0, 100.0)
	var high := Combat.launch_speed(data, 120.0, 100.0)
	assert_float(high).is_greater(low)


func test_heavier_target_launches_slower() -> void:
	var data := _attack(300.0, 6.0)
	assert_float(Combat.launch_speed(data, 80.0, 125.0)).is_less(Combat.launch_speed(data, 80.0, 80.0))


func test_launch_vector_respects_angle_and_side() -> void:
	var up := Combat.launch_vector(_attack(0.0, 0.0, 90.0), 100.0, 1)
	assert_float(up.x).is_equal_approx(0.0, 0.001)
	assert_float(up.y).is_equal_approx(-100.0, 0.001)
	var forward_left := Combat.launch_vector(_attack(0.0, 0.0, 0.0), 100.0, -1)
	assert_float(forward_left.x).is_equal_approx(-100.0, 0.001)
	var back := Combat.launch_vector(_attack(0.0, 0.0, 180.0), 100.0, 1)
	assert_float(back.x).is_less(0.0)


func test_hitstun_and_hitstop_grow_with_strength() -> void:
	assert_float(Combat.hitstun_time(1000.0)).is_greater(Combat.hitstun_time(400.0))
	assert_int(Combat.hitstop_frames(20.0)).is_greater(Combat.hitstop_frames(3.0))


func test_circle_hits_rect() -> void:
	var rect := Rect2(Vector2(0, 0), Vector2(56, 110))
	assert_bool(Combat.circle_hits_rect(Vector2(-10, 50), 12.0, rect)).is_true()
	assert_bool(Combat.circle_hits_rect(Vector2(-20, 50), 12.0, rect)).is_false()
	assert_bool(Combat.circle_hits_rect(Vector2(28, 55), 1.0, rect)).is_true()
