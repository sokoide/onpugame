extends Node2D

var r1
var r2
var hl: bool = false
var hl_width: float = 5.0
var cl: Color = Color.green


func can_place(measure: int) -> bool:
	# TODO: check if the note can be placed in the measure
	return measure == 0


func _ready():
	var m = get_tree().get_root().get_node("Node2D").get_node("Measure")
	var w = m.texture.get_width() * m.scale.x
	var h = m.texture.get_height() * m.scale.y
	var topleft_x = hl_width / 2
	var topleft_y = hl_width / 2
	print("({}, {}) ({}, {})".format([topleft_x, topleft_y, w, h], "{}"))

	r1 = Rect2(topleft_x, topleft_y, w - hl_width, h / 2 - hl_width)
	r2 = Rect2(topleft_x, topleft_y + h / 2, w - hl_width, h / 2 - hl_width)
	print(r1)


func _draw():
	if not hl:
		return

	var mouse = get_local_mouse_position()
	var i = 0
	for r in [r1, r2]:
		if r.has_point(mouse):
			if can_place(i):
				cl = Color.green
			else:
				cl = Color.red
			draw_rect(r, cl, false, hl_width, false)
		i += 1


func _process(delta):
	update()
