extends Button

@export var ID: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var path = "../.."
	if get_node(path).name == "Buttons" :
		path = "../../.."
	connect("pressed", get_node(path)._on_tool_pressed.bind(ID))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
