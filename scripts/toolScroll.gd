extends ScrollContainer
@export var clothingID: int
signal clothesData(clothID)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("clothesData", get_node("../..")._on_tool_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tool_pressed(newID: int) -> void:
	clothesData.emit(newID + clothingID * 10)
