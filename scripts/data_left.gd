extends Control

@onready var carnet_open   = $carnet_open
@onready var carnet_button = $Carnet_Button

@onready var close_carnet_button = $Close_Button


var first_click = true
	

func _ready() -> void:
	carnet_open.visible = false  
	close_carnet_button.visible = false
	
	if carnet_open.has_method("start") && first_click:
		carnet_open.start()
		first_click = false
	carnet_button.pressed.connect(_on_button_pressed)
	
	close_carnet_button.pressed.connect(_on_button_close)
	
	

func _on_button_pressed() -> void:
	
	carnet_open.visible = true
	carnet_button.visible = false
	close_carnet_button.visible = true
	
	if carnet_open.has_method("start") && first_click:
		carnet_open.start()
		first_click = false
		
func _on_button_close()-> void:
	
	carnet_open.visible = false
	close_carnet_button.visible = false
	carnet_button.visible = true
	
	
	
