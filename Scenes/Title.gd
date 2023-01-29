extends Node2D


func center_window():
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	print(screen_size * 0.5)
	print(window_size * 0.5)
	var new_pos = screen_size * 0.5 - window_size * 0.5
	new_pos.y = 0
	OS.set_window_position(new_pos)


func game_start():
	get_tree().change_scene("res://Scenes/Game.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	center_window()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# button handlers
func _on_BtnStart_button_up():
	game_start()


func _on_BtnHelp_button_up():
	get_tree().change_scene("res://Scenes/Rules.tscn")
