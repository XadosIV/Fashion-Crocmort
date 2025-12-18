extends Control

@onready var NB_value_label = $Nb_value_label #nb de corps
@onready var msg_fin_label = $msg_fin_label #Bien joué ou non
@onready var score_label = $Score_label #score calculé

@onready var next_button = $NextButton

var score = 0
var msg = ""
var nb_corps = 0
var win
var finalCorpse : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_button.pressed.connect(_next_pressed)


func affiche():
	NB_value_label.text = str(nb_corps)
	msg_fin_label.text = msg
	score_label.text = str(score)
	finalCorpse.position = Vector2(0, 0)
	finalCorpse.scale = Vector2(1, 1)
	$Corpulence/FinalCorpse.add_child(finalCorpse)
	
func _next_pressed():
	$Corpulence/FinalCorpse.remove_child(finalCorpse)
	finalCorpse.queue_free()
	var game = get_node("../..")
	if win:
		game.loadLevel(0)
	else:
		game.loadLevel(-1)
		#game.menu()
	visible = false
