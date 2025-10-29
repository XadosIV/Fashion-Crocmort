extends Node
var mouse = load("res://assets/UI/mouse.png")
var toolTab = 0
var toolsID = -1
var name_selected = "oui"
var pb_1 = " "
var pb_2 = " "
var pb_3 = " "
var pb_4 = " "

func _ready() -> void:
	Input.set_custom_mouse_cursor(mouse)
	Input.set_custom_mouse_cursor(mouse, Input.CURSOR_POINTING_HAND)

func _input(event):
	if event.is_action_pressed("au_secours"):
		get_tree().quit()

func _tool_changed(tab: int, tool: int) -> void :
	toolTab = tab
	toolsID = tool
