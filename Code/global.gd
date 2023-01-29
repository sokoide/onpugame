extends Node


func _ready():
	pass


func create_note(ty: String, sz: int) -> Sprite:
	var NoteClass = load("res://Code/note.gd")
	var s = NoteClass.new()
	s.texture = load("res://Assets/Images/note{}_{}.png".format([sz, ty], "{}"))
	s.scale.x = 0.25
	s.scale.y = 0.25
	s.position = Vector2(100, 100)
	s.ty = ty
	s.sz = sz
	if ty == "b":
		s.can_grab = true
	return s
