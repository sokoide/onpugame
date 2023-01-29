extends Node2D

var turn: int = 0  # 0:you, 101:computer, 102: computer thinking
var lbl
var mh
var timer


func reset():
	turn = 0
	mh.reset()
	update_label()


func update_label():
	if turn == 0:
		lbl.text = "あなたの番です"
		mh.hl = true
	else:
		lbl.text = "コンピューターの番です"
		mh.hl = false


func _on_note_placed():
	print("_on_note_placed")
	turn = 101
	update_label()


func _ready():
	randomize()
	lbl = get_node("LblMessage")
	mh = get_node("MeasureHighlight")
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

	var i = 0
	for sz in [1, 2, 4, 8]:
		var s = Global.create_note("b", sz)

		s.set_position(Vector2(100 + i * 128, 1000))
		add_child(s)
		s.print()
		i += 1
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
