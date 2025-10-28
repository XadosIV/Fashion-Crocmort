extends Control

var toolsID = -1
signal tableClic(IDtool)
var scissorsMouse = load("res://assets/table/scissorsMouse.png")
var doughMouse = load("res://assets/table/doughMouse.png")
var scotchMouse = load("res://assets/table/scotchMouse.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tool_pressed(newID: int) -> void:
	if newID == toolsID : 
		for childBtn in $Buttons.get_children() :
			if childBtn.ID == newID :
				childBtn.set_self_modulate(Color(1, 1, 1, 1))
				break
		toolsID = -1
		Input.set_custom_mouse_cursor(get_node("/root/Global").mouse)
	else :
		toolsID = newID
		for childBtn in $Buttons.get_children() :
			if childBtn.ID == newID && newID <= 2:
				childBtn.set_self_modulate(Color(1, 1, 1, 0.5))
			else :
				childBtn.set_self_modulate(Color(1, 1, 1, 1))
		match newID :
			0 :
				Input.set_custom_mouse_cursor(scissorsMouse)
			1 :
				Input.set_custom_mouse_cursor(doughMouse)
			2 :
				Input.set_custom_mouse_cursor(scotchMouse)
		
	tableClic.emit(toolsID)

func _init_button() -> void :
	_on_tool_pressed(-2)
	Input.set_custom_mouse_cursor(get_node("/root/Global").mouse)
	toolsID = -1
	tableClic.emit(-1)
