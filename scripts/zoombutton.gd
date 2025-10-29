extends TextureButton

var camera
@export var zoomIn: Texture
@export var zoomOut: Texture

var zoom = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_node("../../../Camera")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _pressed() -> void:
	camera.toggleZoom()
	zoom = !zoom
	if zoom :
		texture_normal = zoomOut
	else :
		texture_normal = zoomIn
	
