extends Control

var toolsID = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Input.set_custom_mouse_cursor(arrow)


func _on_tool_pressed(newID: int) -> void:
	if newID == toolsID : 
		toolsID = -1
	else :
		toolsID = newID
	print(toolsID)
