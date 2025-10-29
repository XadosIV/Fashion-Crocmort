extends Node2D

@export var journalSfx: AudioStream
@export var scissorSfx: AudioStream
@export var plugSfx: AudioStream
@export var skinSfx: AudioStream
@export var tabSfx: AudioStream
@export var objectSfx: AudioStream
@export var clotheSfx: AudioStream

@export_range(0,1) var difficulty = 0.5

@export var debug = false

var body : Henry

func _ready():
	loadLevel()

func endGame():
	var attributs = body.calcul_attribut()
	print(attributs)

func resetHenry():
	body.randomizeHenry(true)

func loadLevel(dif=-1):
	if dif != -1:
		difficulty = dif

	chooseCorpulence()
	if debug:
		body.loadBody(-1)
	else:
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

func _on_ui_clic_journal() -> void:
	$sfx.set_stream(journalSfx)
	$sfx.play()

func _on_henry_2_hair_removed() -> void:
	if $sfx.stream == scissorSfx :
		if !$sfx.playing :
			$sfx.play()
	else :
		$sfx.set_stream(scissorSfx)
		$sfx.play()

func _on_henry_2_limb_added() -> void:
	$sfx.set_stream(plugSfx)
	$sfx.play()

func _on_henry_2_injury_cured() -> void:
	$sfx.set_stream(skinSfx)
	$sfx.play()

func _on_ui_clic_tool(typeID: Variant, toolID: Variant) -> void:
	if $sfx.playing && toolID == -1:
		return
	if toolID == -1 && typeID != 0:
		$sfx.set_stream(clotheSfx)
	elif toolID <= -1 :
		$sfx.set_stream(tabSfx)
	else :
		$sfx.set_stream(objectSfx)
	$sfx.play()
