extends Control


var example_dict_story= {}
var example_dict_description = {}
var example_dict_link = {}

var gender = "male"
var lien_id = 5
var resume_id = 5

var prenom = "non"
var lien = "Mamie"
var resume = "test"
var commande = "commande"

@onready var commande_list := $CommandeList





func _ready() -> void:
	prenom = get_node("/root/Global").name_selected
	import_all_data()
	
	select_id_and_attribute_value()
	charge_text()
	
	
func start():
	select_id_and_attribute_value()
	charge_text()
	
#func charge_text():
#	
#	var replacements = {
#		"prenom":prenom ,
#		"lien": lien
#	}
#	var resume_formate = resume.format(replacements)
#	var commande_formatee = "- " + commande.format(replacements).replace("\\n", "\n- ")
#	
#	$ch_Name2.text = "Prénom : %s" % prenom
#	$ch_Name.text = prenom
#	$ch_Lien.text = "Lien avec le client : %s" % lien.capitalize()
#	
#	$ch_Resume.text = resume_formate
#	$ch_Elem_Commande.text = commande_formatee

func charge_text():
	var repl := {"prenom": prenom, "lien": lien}

	var raw := commande.format(repl).replace("\\n", "\n")
	
	var resume_formate = resume.format(repl)
	
	
	$ch_Name2.text = "Prénom : %s" % prenom
	$ch_Name.text = prenom
	$ch_Lien.text = "Lien avec le client : %s" % lien.capitalize()
	
	$ch_Resume.text = resume_formate


	var lines: Array[String] = []
	for s in raw.split("\n", false):
		s = s.strip_edges()
		if s != "":
			lines.append(s)



	_populate_command_buttons(lines)

func _populate_command_buttons(lines: Array[String]) -> void:

	for child in commande_list.get_children():
		child.queue_free()

	for i in lines.size():
		var row := HBoxContainer.new()
		commande_list.add_child(row)

		var bullet := Label.new()
		bullet.text = "•"
		row.add_child(bullet)

		var btn := Button.new()
		btn.text = lines[i]
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.flat = true
		btn.add_theme_color_override("font_color", Color.BLACK)
		row.add_child(btn)


		btn.pressed.connect(_on_command_pressed.bind(i, lines[i]))

func _on_command_pressed(index: int, text: String) -> void:
	print("Clique sur la ligne", index, ":", text)








func select_id_and_attribute_value():
	
	resume_id = randi() % example_dict_story.size()
	lien_id = randi() % example_dict_link.size()

	resume = example_dict_story[resume_id] 
	commande = example_dict_description[resume_id]
	lien = example_dict_link[lien_id]
	

func import_link():
	var file_lien = FileAccess.open("res://CSV/Lien.csv", FileAccess.READ)
	if not file_lien:
		push_error("Impossible d'ouvrir le fichier lien CSV.")
		return
	
	var line_index := 0
	var first_line := true
	
	while not file_lien.eof_reached():
		var data_set = Array(file_lien.get_csv_line())
		
		if first_line:
			first_line = false
			continue
	
		if data_set.size() >= 2 and data_set[0] != "" and data_set[1] != "" :
	
			if(gender == "female"):
				example_dict_link[line_index] = data_set[0]
			
			if(gender == "male"):
				example_dict_link[line_index] = data_set[1]
				
			line_index += 1
	
	file_lien.close()

func import_desc():
	var file_desc= FileAccess.open("res://CSV/Description.csv", FileAccess.READ)
	if not file_desc:
		push_error("Impossible d'ouvrir le fichier description CSV.")
		return
	
	var line_index := 0
	var first_line := true
	
	while not file_desc.eof_reached():
		var data_set = Array(file_desc.get_csv_line())
		
		if first_line:
			first_line = false
			continue
	
		if data_set.size() >= 2 and data_set[0] != "" and data_set[1] != "" :
	
			if(gender == "female"):
				example_dict_description[line_index] = data_set[0]
			
			if(gender == "male"):
				example_dict_description[line_index] = data_set[1]
				

			line_index += 1
	
	file_desc.close()

func import_story():
	var file_story = FileAccess.open("res://CSV/Histoire.csv", FileAccess.READ)
	if not file_story:
		push_error("Impossible d'ouvrir le fichier histoire CSV.")
		return
	
	var line_index := 0
	var first_line := true
	
	while not file_story.eof_reached():
		var data_set = Array(file_story.get_csv_line())
		
		if first_line:
			first_line = false
			continue
	
		if data_set.size() >= 2 and data_set[0] != "" and data_set[1] != "" :
	
			if(gender == "female"):
				example_dict_story[line_index] = data_set[0]
			
			if(gender == "male"):
				example_dict_story[line_index] = data_set[1]
				

			line_index += 1
	
	file_story.close()
	
func import_all_data():
	
	import_desc()
	import_story()
	import_link()
	
