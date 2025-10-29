extends Control

@onready var NB_value_label = $Nb_value_label #nb de corps
@onready var msg_fin_label = $msg_fin_label #Bien joué ou non
@onready var score_label = $Score_label #score calculé

@onready var next_button = $NextButton

var score = 0
var msg = "Bien joué"
var nb_corps = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	affiche()
	next_button.pressed.connect(_next_pressed)


func affiche():
	NB_value_label.text = str(nb_corps)
	msg_fin_label.text = msg
	score_label.text = str(nb_corps)
	
func _next_pressed():
	pass
