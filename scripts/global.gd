extends Node
var mouse = load("res://assets/UI/mouse.png")
var toolTab = 0
var toolsID = -1
var name_selected = "oui"

func _ready() -> void:
	pass
	#Input.set_custom_mouse_cursor(mouse)

func _input(event):
	if event.is_action_pressed("au_secours"):
		get_tree().quit()

func _tool_changed(tab: int, tool: int) -> void :
	toolTab = tab
	toolsID = tool
