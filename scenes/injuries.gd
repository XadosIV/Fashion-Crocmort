extends Sprite2D

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_rect().has_point(to_local(event.position)):
			visible = false
