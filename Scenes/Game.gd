extends Node2D

var measure


func draw_frame(slot: int):
	pass


func _ready():
	var lbl = get_node("LblMessage")
	lbl.text = "あなたの番です"
	var mh = get_node("MeasureHighlight")
	mh.hl = true

	var i = 0
	for sz in [1, 2, 4, 8]:
		var s = Global.create_note("b", sz)

		s.set_position(Vector2(100 + i * 128, 1000))
		add_child(s)
		s.print()
		i += 1


func _process(delta):
	pass


func _on_BtnReturn_button_up():
	get_tree().change_scene("res://Scenes/Title.tscn")
