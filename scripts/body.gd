@tool
extends Sprite2D

@export_range(0.0, 1.0) var difficulty := 0.5
@export var chances = {"default":0.5}

@export var create_dictionnary := false:
	set(value):
		if value and Engine.is_editor_hint():
			var new_dict = {}
			create_dictionnary = false
			for child in get_children():
				var base_chance = 0.5
				var adjusted = clamp(base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5), 0.05, 0.95)
				new_dict[child.name] = adjusted

				if child.get_child_count() > 0 and child.visible:
					for c in child.get_children():
						var sub_adjusted = clamp(base_chance * (0.5 + difficulty) + randf() * 0.2 * (difficulty - 0.5), 0.05, 0.95)
						new_dict[c.name] = sub_adjusted
				chances = new_dict
				notify_property_list_changed()

# Si jamais tout explose, ça, ça marche, mais ça prend pas en compte
# La difficulté
"""@export var create_dictionnary := false:
	set(value):
		if value and Engine.is_editor_hint():
			var new_dict = {}
			create_dictionnary = false
			for child in get_children():
				new_dict[child.name] = 0.5
				if child.get_child_count() > 0 and child.visible:
					for c in child.get_children():
						new_dict[c.name] = 0.5
			chances = new_dict
			notify_property_list_changed()"""

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
	for child in get_children():
		child.visible = true
		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				c.visible = true

func randomizeHenry():
	for child in get_children():
		var chance = chances.get(child.name, 0.5)
		
		if child.name.to_lower().begins_with("bras"):
			# On inverse la chance pour les bras, sachant
			# que c'est le seul sprite à être "pas blessé"
			# quand il est montré, contrairement aux hématomes genre
			child.visible = randf() < 1-chance
		else:
			child.visible = randf() < chance
			

		if child.get_child_count() > 0 and child.visible:
			for c in child.get_children():
				var sub_chance = chances.get(c.name, 0.5)
				c.visible = randf() < sub_chance


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		randomizeHenry()
