extends Node2D

var measure


func draw_frame(slot: int):
	pass


func _ready():
	var lbl = get_node("LblMessage")
	lbl.text = "あなたの番です"
	var mh = get_node("MeasureHighlight")
	mh.hl = true


func _process(delta):
	var mouse = get_global_mouse_position()


func _on_BtnReturn_button_up():
	get_tree().change_scene("res://Scenes/Title.tscn")
