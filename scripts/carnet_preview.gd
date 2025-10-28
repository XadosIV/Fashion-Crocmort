extends Control

var example_dict_name_female = {}
var example_dict_name_male = {}
var gender = "female"
var target_id = 5

var name_selected = ""

func _ready() -> void:
	
	var photo = Image.load_from_file("res://PlaceHolderImage/PhotoPierre.png")
	var tex = ImageTexture.create_from_image(photo)
	
	var texture_rect = $Photo 
	texture_rect.texture = tex
	
	select_gender()
	
	import_ressource_data()
	select_name()
	
	$Name.text = name_selected
	get_node("/root/Global").name_selected = name_selected

func select_gender():
	gender = ["female", "male"].pick_random()

func select_name():
	randomize()

	if gender == "female":
		target_id = randi() % example_dict_name_female.size()
		name_selected = example_dict_name_female[target_id]
	if gender == "male":
		target_id = randi() % example_dict_name_male.size()
		name_selected = example_dict_name_male[target_id]
			

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
	
			if(gender == "female"):
				example_dict_name_female[line_index] = data_set[0]
			
			if(gender == "male"):
				example_dict_name_male[line_index] = data_set[1]
				

			line_index += 1
	
	file.close()
	
	
	
	
	
