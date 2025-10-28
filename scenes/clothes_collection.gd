extends Area2D

@export var dizaine : int
@export var toolTab = 2
var global
var hover = false
var lastToolId = -1

func _ready():
	global = get_node("/root/Global")
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	hover = true

func _on_mouse_exited():
	hover = false

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		lastToolId = global.toolsID
	if event is InputEventMouseButton and not event.pressed:
		if hover and global.toolTab == toolTab:
			if global.toolsID >= dizaine*10 and global.toolsID < (dizaine+1)*10:
				show_child(global.toolsID - dizaine*10)

func show_child(number):
	for child in get_children():
		if child is Sprite2D:
			child.visible = false
	get_child(number).visible = true 
