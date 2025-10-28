extends Camera2D

var zoomed = false
@export var zoomSize = 1.5

var limUp
var limDown

func _ready() -> void:
	limUp = 1080 / (2 * zoomSize)
	var entier = 1080 / limUp
	limDown = limUp * (entier -1)

func _process(_delta: float) -> void:
	if zoomed:
		if Input.is_action_just_pressed("up_scroll"):
			position = Vector2(960, position.y - 40)
		if Input.is_action_just_pressed("down_scroll"):
			position = Vector2(960, position.y + 40)
		
		if position.y < limUp:
			position = Vector2(960, limUp)
		if position.y > limDown:
			position = Vector2(960, limDown)

func toggleZoom():
	zoomed = not zoomed
	if zoomed:
		zoom = Vector2(zoomSize,zoomSize)
	else:
		zoom = Vector2(1,1)
		position = Vector2(960,540)
