extends Node2D

var turn: int = 0  # 0:you, 101:computer, 102: computer thinking
var lbl
var mh
var timer

var player_cards: Array = []


func reset():
	turn = 0
	mh.reset()
	update_label()
	# delete all player cards
	delete_all_cards()

	# draw player cards
	for i in range(4):
		var sz = random_sz()
		var s = Global.create_note("b", sz)
		var pos = open_position()
		s.set_position(pos)
		add_child(s)


func open_position() -> Vector2:
	for y in range(920, 920 + 128 + 1, 128):
		for x in range(100, 100 + 5 * 128, 128):
			if has_object(Vector2(x + 1, y + 1)) == false:
				return Vector2(x, y)
	return delete_first_card()


func has_object(pos: Vector2) -> bool:
	for node in get_children():
		if node is Sprite and node.visible:
			var r = Rect2(node.position, Vector2(64, 64))
			if r.has_point(pos):
				return true
	return false


func delete_first_card() -> Vector2:
	for node in get_children():
		if node is Sprite and node.name[0] == "@" and node.visible == true:
			node.visible = false
			node.queue_free()
			return node.position
	return Vector2(0, 0)


func delete_all_cards() -> void:
	for node in get_children():
		if node is Sprite and node.name[0] == "@":
			node.visible = false
			node.queue_free()


func update_label():
	if turn == 0:
		lbl.text = "あなたの番です"
		mh.hl = true
	elif turn == 201:
		lbl.text = "あなたの勝ちです！"
		mh.hl = false
	elif turn == 202:
		lbl.text = "引き分けです"
		mh.hl = false
	elif turn == 203:
		lbl.text = "あなたの負けです"
		mh.hl = false
	else:
		lbl.text = "コンピューターの番です"
		mh.hl = false


func random_sz() -> int:
	var r = randi() % 100
	if r < 50:
		return 8
	elif r < 75:
		return 4
	elif r < 87.5:
		return 2
	else:
		return 1


func _on_note_placed():
	print("_on_note_placed")
	turn = 101
	update_label()


func _on_gameover(t: int):
	turn = t
	update_label()


func _ready():
	randomize()
	lbl = get_node("LblMessage")
	mh = get_node("Measure")
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

	reset()


func _process(delta):
	if turn == 101:
		turn = 102
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.start()


func _on_timer_timeout() -> void:
	# computer
	var r = randi() % 100
	# 0-25: zen
	# 25-50: han
	# 50-75: 4bun
	# 75-100: 8bun
	if r < 25:
		mh.cpu_try_drop(1)
	elif r < 50:
		mh.cpu_try_drop(2)
	elif r < 75:
		mh.cpu_try_drop(4)
	else:
		mh.cpu_try_drop(8)

	# change turn
	turn = 0
	update_label()


func _on_BtnReturn_button_up() -> void:
	reset()
	get_tree().change_scene("res://Scenes/Title.tscn")


func _on_BtnRestart_button_up() -> void:
	reset()


func _on_BtnDraw_button_up() -> void:
	# TODO: can't handle if #cards > 10
	var sz = random_sz()

	var s = Global.create_note("b", sz)
	var pos = open_position()
	s.set_position(pos)
	add_child(s)

	turn = 101
	update_label()
