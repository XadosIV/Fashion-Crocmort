extends Node

func _input(event):
	if event.is_action_pressed("au_secours"):
		get_tree().quit()
