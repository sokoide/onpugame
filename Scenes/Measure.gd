extends Sprite

signal gameover

var r1
var r2
var hl: bool = false
var hl_width: float = 5.0
var cl: Color = Color.green
var m1sum: int = 0
var m2sum: int = 0
var m1: Array = []
var m2: Array = []
var lblm1
var lblm2
var draw_r1: bool = false
var draw_r2: bool = false
var cpu_points: int = 0
var player_points: int = 0


func reset():
	m1 = []
	m2 = []
	m1sum = 0
	m2sum = 0
	update_scores()
	update()


func drop(pos: Vector2, sz: int) -> int:
	if not hl:
		return 0

	var lpos: Vector2 = to_local(pos)
	var cost: int = 32 / sz
	draw_r1 = false
	draw_r2 = false

	if r1.has_point(lpos) and m1sum + cost <= 32:
		m1.append(sz)
		m1sum += cost
		player_points += 1
		update_scores()
		update()
		return 1
	elif r2.has_point(lpos) and m2sum + cost <= 32:
		m2.append(sz)
		m2sum += cost
		player_points += 1
		update_scores()
		update()
		return 2
	return 0


func cpu_try_drop(sz: int) -> void:
	var cost: int = 32 / sz
	if m1sum + cost <= 32:
		m1.append(sz)
		m1sum += cost
		cpu_points += 1
	elif m2sum + cost <= 32:
		m2.append(sz)
		m2sum += cost
		cpu_points += 1
	update_scores()
	update()


func can_drop(pos: Vector2, sz: int):
	var lpos: Vector2 = to_local(pos)
	var cost: int = 32 / sz
	draw_r1 = false
	draw_r2 = false

	if not hl:
		return

	if r1.has_point(lpos):
		draw_r1 = true
		if m1sum + cost <= 32:
			cl = Color.green
		else:
			cl = Color.red
	elif r2.has_point(lpos):
		draw_r2 = true
		if m2sum + cost <= 32:
			cl = Color.green
		else:
			cl = Color.red
	update()


func update_scores():
	lblm1.text = "Score: " + str(m1sum)
	lblm2.text = "Score: " + str(m2sum)


func _ready():
	var m = get_node("/root/Node2D/Measure")
	var w = m.texture.get_width()
	var h = m.texture.get_height()
	var topleft_x = hl_width
	var topleft_y = hl_width
	var game = get_node("/root/Node2D")

	connect("gameover", game, "_on_gameover")
	print("Measure ({}, {}) ({}, {})".format([topleft_x, topleft_y, w, h], "{}"))

	r1 = Rect2(topleft_x, topleft_y, w - hl_width, h / 2 - hl_width)
	r2 = Rect2(topleft_x, topleft_y + h / 2 + hl_width, w - hl_width, h / 2 - hl_width)
	print("r1: {} {}".format([r1.position, r1.size], "{}"))
	print("r2: {} {}".format([r2.position, r2.size], "{}"))

	lblm1 = get_node("/root/Node2D/Measure/Score1")
	lblm2 = get_node("/root/Node2D/Measure/Score2")
	reset()


func _process(delta):
	if m1sum == 32 and m2sum == 32:
		var t = 201
		if player_points == cpu_points:
			t = 202
		elif player_points < cpu_points:
			t = 203
		emit_signal("gameover", t)


func _draw():
	if not hl:
		return

	if draw_r1:
		draw_rect(r1, cl, false, hl_width, false)
	if draw_r2:
		draw_rect(r2, cl, false, hl_width, false)
