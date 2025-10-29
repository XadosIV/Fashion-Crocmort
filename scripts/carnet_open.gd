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

var tips1 = true
var tips2 = false



@onready var commande_list := $CommandeList
@onready var photo_exemple := $Photo_exemple
@onready var pin1 := $Pin1
@onready var pin2 := $Pin2
@onready var pin3 := $Pin3
@onready var pin4 := $Pin4


func _ready() -> void:
	prenom = get_node("/root/Global").name_selected
	import_all_data()
	
	select_id_and_attribute_value()
	charge_text()
	
	
func start():
	select_id_and_attribute_value()
	charge_text()
	
func charge_text():
	var repl := {"prenom": prenom, "lien": lien}

	var raw := commande.format(repl).replace("\\n", "\n")
	
	var resume_formate = resume.format(repl)
	var commande_formatee = "- " + commande.format(repl).replace("\\n", "\n- ")
#		
	$ch_Name2.text = "Prénom : %s" % prenom
	$ch_Name.text = prenom
	$ch_Lien.text = "Lien avec le client : %s" % lien.capitalize()
	
	$ch_Resume.text = resume_formate
	$ch_Elem_Commande.text = commande_formatee


	var lines: Array[String] = []
	for s in raw.split("\n", false):
		s = s.strip_edges()
		if s != "":
			lines.append(s)
			
			



	_populate_command_buttons(lines)
	
func _apply_hover_style(btn : Button)->void:
	btn.focus_mode = Control.FOCUS_NONE
	#btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	var sb_empty := StyleBoxEmpty.new()
	btn.add_theme_stylebox_override("normal", sb_empty)
	btn.add_theme_stylebox_override("focus", sb_empty)
	
	var sb_hover := StyleBoxFlat.new()
	sb_hover.bg_color = Color(0, 0, 0, 0.07)  
	sb_hover.corner_radius_top_left = 6
	sb_hover.corner_radius_top_right = 6
	sb_hover.corner_radius_bottom_left = 6
	sb_hover.corner_radius_bottom_right = 6
	btn.add_theme_stylebox_override("hover", sb_hover)
	
	var sb_pressed := StyleBoxFlat.new()
	sb_pressed.bg_color =Color(0, 0, 0, 0.12)
	sb_pressed.corner_radius_top_left = 6
	sb_pressed.corner_radius_top_right = 6
	sb_pressed.corner_radius_bottom_left = 6
	sb_pressed.corner_radius_bottom_right = 6
	btn.add_theme_stylebox_override("pressed", sb_pressed)
	
	btn.add_theme_color_override("font_color", Color.BLACK)
	btn.add_theme_color_override("font_hover_color", Color.BLACK)
	btn.add_theme_color_override("font_pressed_color", Color(0.15, 0.15, 0.15))

func _populate_command_buttons(lines: Array[String]) -> void:
	
	commande_list.alignment = BoxContainer.ALIGNMENT_BEGIN
	commande_list.add_theme_constant_override("separation", 8)

	for child in commande_list.get_children():
		child.queue_free()
	
	for i in lines.size():
		
		var row := HBoxContainer.new()
		commande_list.add_child(row)

		var bullet := Label.new()
		
		row.add_child(bullet)

		var btn := Button.new()
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		btn.add_theme_color_override("font_color", Color.BLACK)
		_apply_hover_style(btn)
		row.add_child(btn)


		btn.pressed.connect(_on_command_pressed.bind(i, lines))
	

func _on_command_pressed(index: int, lines: Array[String]) -> void:
	

	
	if(lines.size() <= 2):

		if(index==0):
			get_node("/root/Global").pb_1 = lines[index]
			pin1.visible = true
		elif (index == 1):	
			get_node("/root/Global").pb_2 = lines[index]
			pin2.visible = true
	else:

		if (tips1):
			tips1 = false
			tips2 = true
			get_node("/root/Global").pb_1 = lines[index]
			
			if(index == 0):
				pin1.visible = true
			elif(index == 1):
				pin2.visible = true
			elif(index == 3):
				pin3.visible = true
			elif(index == 4):
				pin4.visible = true
				
			
		elif (tips2):
			tips1 = true
			tips2 = false
			get_node("/root/Global").pb_2 = lines[index]
			if(index == 0):
				pin1.visible = true
			elif(index == 1):
				pin2.visible = true
			elif(index == 3):
				pin3.visible = true
			elif(index == 4):
				pin4.visible = true
		

		


func select_id_and_attribute_value():
	
	resume_id = randi() % example_dict_story.size()
	lien_id = randi() % example_dict_link.size()

	resume = example_dict_story[resume_id] 
	commande = example_dict_description[resume_id]
	lien = example_dict_link[lien_id]
	
	if (resume_id == 5):
		photo_exemple.visible = true
	else:
		photo_exemple.visible = false
	

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
	
