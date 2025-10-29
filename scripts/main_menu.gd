extends Control
@export var credits: Label
@export var buttons: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _btnSfxPlay() -> void:
	$btnSfx.play()
	
func _hideCredits() -> void:
	credits.visible = false
	buttons.visible = true
	
func _showCredits() -> void:
	credits.visible = true
	buttons.visible = false
