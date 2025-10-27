extends Control

var toolsID = -1

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
		#put back default
	else :
		toolsID = newID
		for childBtn in $Buttons.get_children() :
			if childBtn.ID == newID :
				childBtn.set_self_modulate(Color(1, 1, 1, 0.5))
				Input.set_custom_mouse_cursor(childBtn.icon)
			else :
				childBtn.set_self_modulate(Color(1, 1, 1, 1))
