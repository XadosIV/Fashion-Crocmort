extends Control

var toolsID = -1
var wPen = load("res://assets/UI/whitePen.png")
var bPen = load("res://assets/UI/blackPen.png")
signal drawerClic(accessoriesID)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tool_pressed(newID: int) -> void:
	if newID == toolsID : 
		for childBtn in $Buttons.get_children() :
			if childBtn.get_child_count() > 0 : continue
			if childBtn.ID == newID :
				childBtn.set_self_modulate(Color(1, 1, 1, 1))
				break
		toolsID = -1
		Input.set_custom_mouse_cursor(get_node("/root/Global").mouse)
	else :
		toolsID = newID
		for childBtn in $Buttons.get_children() :
			if childBtn.get_child_count() > 0 : continue
			if childBtn.ID == newID :
				childBtn.set_self_modulate(Color(1, 1, 1, 0.5))
			else :
				childBtn.set_self_modulate(Color(1, 1, 1, 1))
		if newID >= 9 :
			Input.set_custom_mouse_cursor(bPen if newID == 9 else wPen)
	drawerClic.emit(toolsID)

func _init_button() -> void :
	_on_tool_pressed(-2)
	Input.set_custom_mouse_cursor(get_node("/root/Global").mouse)
	toolsID = -1
	drawerClic.emit(-1)
