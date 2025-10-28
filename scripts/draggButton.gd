extends Button

@export var ID: int
var is_dragging = false
var origin
var offset = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
	var path = "../.."
	if get_node(path).name == "Buttons" :
		path = "../../.."
	connect("button_down", self._start_dragging)
	connect("pressed", get_node(path)._on_tool_pressed.bind(ID))
	connect("button_up", _stop_dragging)
	connect("button_up", get_node(path)._on_tool_pressed.bind(ID))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_dragging:
		_followMouse()
		
func _followMouse():
	position = get_global_mouse_position() + offset

func _start_dragging() -> void:
	origin = position
	offset = position - get_global_mouse_position()
	is_dragging = true
	
func _stop_dragging() -> void:
	is_dragging = false
	position = origin
