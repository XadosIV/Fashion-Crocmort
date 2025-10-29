extends Sprite2D

var global
var hover = false
var bras_colle = false
var bras_scotche = false

var sprite

func _ready():
	sprite = texture
	reset()
	global = get_node("/root/Global")
	$Area2D.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	$Area2D.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	hover = true

func _on_mouse_exited():
	hover = false

func reset():
	texture = sprite
	hover = false
	bras_colle = false
	bras_scotche = false
	find_child("SansOs").visible = false
	find_child("Scotch").visible = false

func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		if hover and global.toolsID == 3 and global.toolTab == 0:
			texture = null
			find_child("SansOs").visible = true
			#visible = false
			var membre = get_node("../../Attaché/"+name)
			membre.visible = true
			for child in membre.get_children():
				child.visible = false
			get_node("../../..").membres.set(name, true)
			get_node("../../..")._limb_sound()
			bras_colle = true
		elif hover and global.toolsID == 2 and global.toolTab == 0:
			if bras_colle:
				find_child("Scotch").visible = true
				bras_scotche = true
