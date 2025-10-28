extends Sprite2D

var global
var hover = false

func _ready():
	global = get_node("/root/Global")
	$Area2D.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	$Area2D.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	hover = true

func _on_mouse_exited():
	hover = false



func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		if get_rect().has_point(to_local(event.position)) and global.toolsID == 3 and global.toolTab == 0:
			visible = false
			get_node("../../Attaché/"+name).visible = true
