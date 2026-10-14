extends GdUnitTestSuite
## Testes unitários do placar (T21): 3 KOs, KO simultâneo e morte súbita.


func _kos(a: int, b: int) -> Dictionary:
	return {"p1": a, "p2": b}


func test_ko_scores_for_the_other_player() -> void:
	var r := Scoring.apply_kos(_kos(0, 0), ["p2"], 3, false)
	assert_dict(r["kos"]).is_equal(_kos(1, 0))
	assert_str(r["winner"]).is_empty()


func test_third_ko_wins() -> void:
	var r := Scoring.apply_kos(_kos(2, 1), ["p2"], 3, false)
	assert_str(r["winner"]).is_equal("p1")
	r = Scoring.apply_kos(_kos(0, 2), ["p1"], 3, false)
	assert_str(r["winner"]).is_equal("p2")


func test_simultaneous_ko_scores_for_both() -> void:
	var r := Scoring.apply_kos(_kos(1, 0), ["p1", "p2"], 3, false)
	assert_dict(r["kos"]).is_equal(_kos(2, 1))
	assert_str(r["winner"]).is_empty()


func test_simultaneous_ko_reaching_target_unequal_wins() -> void:
	# 2 x 1 com KO duplo vira 3 x 2: quem chegou à meta sozinho vence
	var r := Scoring.apply_kos(_kos(2, 1), ["p1", "p2"], 3, false)
	assert_dict(r["kos"]).is_equal(_kos(3, 2))
	assert_str(r["winner"]).is_equal("p1")


func test_tie_at_target_starts_sudden_death() -> void:
	var r := Scoring.apply_kos(_kos(2, 2), ["p1", "p2"], 3, false)
	assert_dict(r["kos"]).is_equal(_kos(3, 3))
	assert_str(r["winner"]).is_empty()
	assert_bool(r["sudden_death"]).is_true()
	assert_bool(r["sudden_death_started"]).is_true()


func test_next_ko_in_sudden_death_decides() -> void:
	var r := Scoring.apply_kos(_kos(3, 3), ["p1"], 3, true)
	assert_str(r["winner"]).is_equal("p2")
	assert_bool(r["sudden_death_started"]).is_false()


func test_double_ko_in_sudden_death_keeps_going() -> void:
	var r := Scoring.apply_kos(_kos(3, 3), ["p1", "p2"], 3, true)
	assert_str(r["winner"]).is_empty()
	assert_bool(r["sudden_death"]).is_true()
	assert_bool(r["sudden_death_started"]).is_false()


func test_input_score_is_not_mutated() -> void:
	var before := _kos(1, 1)
	Scoring.apply_kos(before, ["p2"], 3, false)
	assert_dict(before).is_equal(_kos(1, 1))
