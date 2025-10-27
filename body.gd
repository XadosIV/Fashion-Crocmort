extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func randomizeHenry():
	for child in get_children():
		child.visible = randi_range(0,1) == 1
		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				c.visible = randi_range(0,1) == 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		randomizeHenry()
