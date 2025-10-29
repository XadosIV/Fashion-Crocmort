class_name Henry
extends Node2D

@export_range(0.0, 1.0) var difficulty := 0.5
@export var chances = {"default":0.5}

signal hairRemoved
signal limbAdded
signal injuryCured

var membres = {
	"BrasGauche":true,
	"BrasDroit":true,
	"JambeGauche":true,
	"JambeDroite":true
}

var myRand = RandomNumberGenerator.new()
var mySeed = -1

var attributs = {}

func calcul_attribut():
	attributs = {}
	#Vetements & Accessoires
	get_attrib_from_node("Chapeau")
	get_attrib_from_node("Perruque")
	get_attrib_from_node("Chaussure")
	get_attrib_from_node("Bas")
	get_attrib_from_node("Haut")
	get_attrib_from_node("Maquillage")
	get_attrib_from_node("Eyes")
	#Poils
	# --- coming soon hein ---
	
	# Plaies
	for child in $Plaies.get_children():
		if child.visible:
			add_attrib("hideux")
	
	# Membres
	for child in $"Membres/Attaché".get_children():
		if child.visible:
			for c in child.get_children():
				if c.visible:
					add_attrib("hideux")
	
	for child in $"Membres/Coupés".get_children():
		if child.visible:
			if not child.bras_scotche:
				add_attrib("hideux")
	
	return attributs

	
func get_attrib_from_node(nodename):
	var node = find_child(nodename)
	if node.paire:
		for child in node.get_children():
			if child is Sprite2D:
				var leftNode
				if child.name.ends_with("D"):
					var chaussure_gauche = str(child.name).substr(0,child.name.length()-1)+"G"

					if child.visible:
						leftNode = node.find_child(chaussure_gauche)
					if (child.visible and not leftNode.visible) or (not child.visilbe and leftNode.visible):
						add_attrib("hideux")
				else:
					if child.visible:
						leftNode = child
				if leftNode:
					add_attrib(leftNode.attribut1)
					add_attrib(leftNode.attribut2)
				break
	else:
		for child in node.get_children():
			if child is Sprite2D and child.visible:
				add_attrib(child.attribut1)
				add_attrib(child.attribut2)
				break

func add_attrib(attrib):
	if attrib == "":
		return
	if attributs.has(attrib):
		attributs.set(attrib, attributs.get(attrib)+1)
	else:
		attributs.set(attrib,1)
# ------------------------------------- #

func fullHenry():
	for child in $Plaies.get_children():
		child.visible = true
	
	for child in $"Membres/Attaché".get_children():
		if child.name.to_lower().begins_with("bras") or child.name.to_lower().begins_with("jambe"):
			# On inverse la chance pour les bras, sachant
			# que c'est le seul sprite à être "pas blessé"
			# quand il est montré, contrairement aux hématomes genre
			child.visible = true
			
			$"Membres/Coupés".get_node_or_null(str(child.name)).visible = not child.visible
		else:
			child.visible = true

		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				c.visible = true

func randomizeHenry(reset=false):
	if reset:
		myRand.seed = mySeed
		myRand.state = 0
	else:
		myRand.randomize()
		mySeed = myRand.seed
	
	print(mySeed)
	
	for child in $"Membres/Coupés".get_children():
		child.reset()
	
	for child in get_children():
		if child is Area2D:
			for c in child.get_children():
				if c is Sprite2D:
					c.visible = false
	
	for child in $Plaies.get_children():
		var chance = chances.get(child.name, 0.5)
		var rand = myRand.randf()
		child.visible = rand < chance
	
	for child in $"Membres/Attaché".get_children():
		var chance = chances.get(child.name, 0.5)
		if child.name.to_lower().begins_with("bras") or child.name.to_lower().begins_with("jambe"):
			# On inverse la chance pour les bras, sachant
			# que c'est le seul sprite à être "pas blessé"
			# quand il est montré, contrairement aux hématomes genre
			var rand = myRand.randf()
			child.visible = rand < 1-chance
			
			membres.set(child.name, child.visible)
			
			if child.visible:
				$"Membres/Coupés".get_node_or_null(str(child.name)).visible = false
				var polygonPoils = $"Poils".get_node_or_null(str(child.name))
				polygonPoils.visible = true
				polygonPoils.generate_poils(myRand)
				
			else:
				$"Membres/Coupés".get_node_or_null(str(child.name)).visible = true
				var polygonPoils = $"Poils".get_node_or_null(str(child.name))
				polygonPoils.visible = false
				polygonPoils.remove_poils()
		else:
			var rand = myRand.randf()
			child.visible = rand < chance

		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				var sub_chance = chances.get(c.name, 0.5)
				var rand = myRand.randf()
				c.visible = rand < sub_chance
	
	
	
	# Generation Poils Torse et Pubis
	var _chance = chances.get("poilu", 0.5)
	var _rand = myRand.randf()
	if _rand < _chance:
		$Poils/Torse.visible = true
		$Poils/Torse.generate_poils(myRand)
		$Poils/Pubis.visible = true
		$Poils/Pubis.generate_poils(myRand)
	else:
		$Poils/Torse.visible = false
		$Poils/Torse.remove_poils()
		$Poils/Pubis.visible = false
		$Poils/Pubis.remove_poils()
	

func generateChances():
	fullHenry()
	var base_chance = 0.5
	var global_factor = 0.5 # 0.5 = moitié de chance globale
	var new_dict = {}
	for child in $Plaies.get_children():
		var adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
		new_dict[child.name] = adjusted

	for child in $"Membres/Attaché".get_children():
		var adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
		new_dict[child.name] = adjusted

		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				var sub_adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
				new_dict[c.name] = sub_adjusted
	
	# Poilu
	var _adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
	new_dict["poilu"] = _adjusted
	
	chances = new_dict

func loadBody(dif=-1):
	generateChances()
	randomizeHenry()

func _hair_sound() -> void: 
	hairRemoved.emit()
	
func _limb_sound() -> void:
	limbAdded.emit()

func _injury_healed() -> void:
	injuryCured.emit()

func _process(_delta):
	pass
	#if not Engine.is_editor_hint():
	#	randomizeHenry()
	
