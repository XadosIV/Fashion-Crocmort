extends Button

var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_node("../../../Camera")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _pressed() -> void:
	camera.toggleZoom()
