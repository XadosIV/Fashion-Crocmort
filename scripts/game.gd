extends Node2D

@export var journalSfx: AudioStream
@export var scissorSfx: AudioStream
@export var plugSfx: AudioStream
@export var skinSfx: AudioStream
@export var tabSfx: AudioStream
@export var objectSfx: AudioStream
@export var clotheSfx: AudioStream

@export var uifin : Control

@export_range(0,1) var difficulty = 0.5

@export var debug = false

var nb_de_corps = 1
var score = 0
var scoreTotal = 0

@onready var global = get_node("/root/Global")
var body : Henry

func _ready():
	debug = false
	difficulty = global.difficulty
	uifin.visible = false
	loadLevel(0)

func nextLevel(wini):
	if wini:
		nb_de_corps += 1
		uifin.msg = "Bien joué !"
		uifin.score += 1000
	else:
		uifin.msg = "Dommage..."
	uifin.nb_corps = nb_de_corps
	uifin.win = wini
	uifin.affiche()
	uifin.visible = true

func endGame():
	var attributs = body.calcul_attribut()
	#print(attributs)
	var id = global.carnet.resume_id
	var wAttribut = global.carnet.example_dict_attributs[id]
	
	if win(attributs, wAttribut):
		nextLevel(true)
	else:
		nextLevel(false)

func win(body_attributs, w_attributs : Array):
	var sorted_keys = body_attributs.keys()
	sorted_keys.sort_custom(func(a, b): return body_attributs[a] > body_attributs[b])
	var top2_keys: Array = sorted_keys.slice(0, 2)
	
	for i in range(top2_keys.size()):
		top2_keys[i] = top2_keys[i].to_lower().strip_edges()
	for i in range(w_attributs.size()):
		w_attributs[i] = w_attributs[i].to_lower().strip_edges()
	
	if len(w_attributs) == 2:
		if w_attributs[1] == "":
			w_attributs.remove_at(1)
	
	if len(top2_keys) != len(w_attributs):
		return false
	
	for attr in top2_keys:
		if not w_attributs.has(attr):
			return false
	return true

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
