extends Sprite

var ty: String
var sz: int
var seleced: bool = false
var mh

var can_grab = false
var drag_start_position = position
var dragging = false


func print():
	print("Note: {} {}".format([ty, sz], "{}"))


func set_position(pos: Vector2):
	drag_start_position = pos
	position = pos


func _ready():
	mh = get_node("/root/Node2D/MeasureHighlight")


func _process(delta):
	# drag & drop
	if can_grab == false:
		return
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		mh.can_drop(get_global_mouse_position(), sz)
		var mouse = get_local_mouse_position()
		if self.get_rect().has_point(mouse):
			if dragging == false:
				dragging = true
			position = get_global_mouse_position()
	elif dragging == true:
		var dropped = mh.drop(get_global_mouse_position(), sz)
		if dropped == 0:
			dragging = false
			position = drag_start_position
		else:
			# remove myself
			queue_free()
