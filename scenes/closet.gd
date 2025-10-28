extends Control

var toolsID = -1
signal closetClic(clothesID)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tool_pressed(newID: int) -> void:
	if (toolsID == newID) :
		toolsID = -1
	else :
		toolsID = newID
	closetClic.emit(toolsID)

func _init_button() -> void :
	Input.set_custom_mouse_cursor(get_node("/root/Global").mouse)
	toolsID = -1
	closetClic.emit(-1)
