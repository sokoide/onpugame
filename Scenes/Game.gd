extends Node2D

var turn: int = 0  # 0:you, 1:computer
var lbl
var mh


func update_label():
	if turn == 0:
		lbl.text = "あなたの番です"
		mh.hl = true
	else:
		lbl.text = "コンピューターの番です"
		mh.hl = false


func _ready():
	turn = 0
	lbl = get_node("LblMessage")
	mh = get_node("MeasureHighlight")

	var i = 0
	for sz in [1, 2, 4, 8]:
		var s = Global.create_note("b", sz)

		s.set_position(Vector2(100 + i * 128, 1000))
		add_child(s)
		s.print()
		i += 1


func _process(delta):
	update_label()


func _on_BtnReturn_button_up():
	get_tree().change_scene("res://Scenes/Title.tscn")
