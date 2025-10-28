@tool
class_name Henry
extends Node2D

@export_range(0.0, 1.0) var difficulty := 0.5
@export var chances = {"default":0.5}

@export var create_dictionnary := false:
	set(value):
		if value and Engine.is_editor_hint():
			create_dictionnary = false
			generateChances()
			notify_property_list_changed()

@export var randomize_button := false:
	set(value):
		if value and Engine.is_editor_hint():
			randomize_button = false # remet à false pour le re-cliquer
			randomizeHenry()

@export var reset_button := false:
	set(value):
		if value and Engine.is_editor_hint():
			randomize_button = false # remet à false pour le re-cliquer
			fullHenry()
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

func randomizeHenry():
	for child in $Plaies.get_children():
		var chance = chances.get(child.name, 0.5)
		child.visible = randf() < chance
	
	for child in $"Membres/Attaché".get_children():
		var chance = chances.get(child.name, 0.5)
		if child.name.to_lower().begins_with("bras") or child.name.to_lower().begins_with("jambe"):
			# On inverse la chance pour les bras, sachant
			# que c'est le seul sprite à être "pas blessé"
			# quand il est montré, contrairement aux hématomes genre
			child.visible = randf() < 1-chance
			
			$"Membres/Coupés".get_node_or_null(str(child.name)).visible = not child.visible
		else:
			child.visible = randf() < chance
			

		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				var sub_chance = chances.get(c.name, 0.5)
				c.visible = randf() < sub_chance

func generateChances():
	var global_factor = 0.5 # 0.5 = moitié de chance globale
	var new_dict = {}
	for child in $Plaies.get_children():
		var base_chance = 0.5
		var adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
		new_dict[child.name] = adjusted

	for child in $"Membres/Attaché".get_children():
		var base_chance = 0.5
		var adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
		new_dict[child.name] = adjusted

		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				var sub_adjusted = clamp((base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5)) * global_factor, 0.05, 0.95)
				new_dict[c.name] = sub_adjusted
	chances = new_dict



func loadBody(dif):
	difficulty = dif
	generateChances()
	randomizeHenry()

func _process(delta):
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed("ui_accept"):
			randomizeHenry()
