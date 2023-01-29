extends Node2D


func _ready():
	pass


func _on_BtnReturn_button_up():
	get_tree().change_scene("res://Scenes/Title.tscn")
