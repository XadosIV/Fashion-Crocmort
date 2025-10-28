extends Control

var example_dict_name = {}
var example_dict_name_female = {}
var example_dict_name_male = {}
var gender = "female"

var name_selected = ""

func _ready() -> void:
	
	var photo = Image.load_from_file("res://PlaceHolderImage/PhotoJean.png")
	var tex = ImageTexture.create_from_image(photo)
	
	var texture_rect = $Photo 
	texture_rect.texture = tex
	

	
	import_ressource_data()
	select_name()
	
	$Name.text = name_selected
	
	
	

func select_name():
	randomize()

	var random_key = randi() % example_dict_name_female.size()
	
	if gender == "female":
		name_selected = example_dict_name_female[random_key]
	if gender == "male":
		name_selected = example_dict_name_male[random_key]
			

func import_ressource_data():
	var file = FileAccess.open("res://CSV/Prénom.csv", FileAccess.READ)
	if not file:
		push_error("Impossible d'ouvrir le fichier CSV.")
		return
	
	var line_index := 0
	var first_line := true
	
	while not file.eof_reached():
		var data_set = Array(file.get_csv_line())
		
		if first_line:
			first_line = false
			continue
	
		if data_set.size() >= 2 and data_set[0] != "" and data_set[1] != "" :
	
			example_dict_name[line_index] = data_set
			example_dict_name_female[line_index] = data_set[0]
			example_dict_name_male[line_index] = data_set[1]
			line_index += 1
	
	file.close()
	
	
	
	
	
