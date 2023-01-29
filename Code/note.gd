extends Sprite

var ty: String
var sz: int
var seleced: bool = false


func print():
	print("Note: {} {}".format([ty, sz], "{}"))


var can_grab = false
var grabbed_offset = Vector2()
var drag_start_position = position
var dragging = false


func set_position(pos: Vector2):
	drag_start_position = pos
	position = pos


func _process(delta):
	# drag & drop
	if can_grab == false:
		return
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var mouse = get_local_mouse_position()
		if self.get_rect().has_point(mouse):
			if dragging == false:
				dragging = true
			position = get_global_mouse_position() + grabbed_offset
	elif dragging == true:
		dragging = false
		position = drag_start_position
