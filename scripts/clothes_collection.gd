extends Area2D

@export var dizaine : int
@export var toolTab = 2
@export var paire = false
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
    if event is InputEventMouseButton and not event.pressed:
        if hover and global.toolTab == toolTab:
            if global.toolsID >= 1000 :
                show_child(-1)
            if global.toolsID >= dizaine*100 and global.toolsID < (dizaine+1)*100:
                show_child(global.toolsID - dizaine*100)

func show_child(number):
	for child in get_children():
		if child is Sprite2D:
			child.visible = false
	if number == -1 :
		return
	if not paire:
		get_child(number).visible = true 
	else:
		var henry = get_parent()
		var gauche = get_child(number*2)
		var droite = get_child(number*2+1)
		
		gauche.visible = henry.membres["JambeGauche"]
		droite.visible = henry.membres["JambeDroite"]
