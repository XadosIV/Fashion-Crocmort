extends Node2D

@export_range(0,1) var difficulty = 0.5

var body : Henry

func _ready():
	loadLevel()

func loadLevel(dif=-1):
	if dif != -1:
		difficulty = dif

	chooseCorpulence()
	body.loadBody(difficulty)


func chooseCorpulence():
	var index = randi_range(0, $Corpulence.get_child_count()-1)
	
	var i = 0
	for child in $Corpulence.get_children():
		if i == index:
			child.visible = true
			body = child
		else:
			child.visible = false
