extends Button

func _ready() -> void:
	if OS.get_name() == "Web" :
		visible = false

func _pressed():
	get_tree().quit()
