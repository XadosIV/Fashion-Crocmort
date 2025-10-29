extends Sprite2D

var global

func _ready():
	set_process_input(true)
	global = get_node("/root/Global")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_rect().has_point(get_local_mouse_position()) and global.toolsID == 1 and global.toolTab == 0:
			visible = false
			var path = "../.."
			if !get_node(path).name.contains("Henry") :
				path = "../../../.."
			get_node(path)._injury_healed()
			
