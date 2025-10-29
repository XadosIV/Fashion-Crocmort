extends Control

var example_dict_name_female = {}
var example_dict_name_male = {}
var gender = "male"
var target_id = 5

var name_selected = ""

var portraits = {}

func _ready() -> void:
	
	var id_desc = 1 #get_node("/root/Global").carnet.resume_id
	
	var photo =  load("res://assets/mugshot/mugshot clown.png")
	
	portraits = {
		1 : load("res://assets/mugshot/mugshot clown.png"),
		2 : load("res://assets/mugshot/mugshot metal.png"),
		3 : load("res://assets/mugshot/mugshot naruto(5).png"),
		4 : load("res://assets/mugshot/mugshot_aryen.png"),
		5 : load("res://assets/mugshot/mugshot_chill_guy (1).png"),
		6 : load("res://assets/mugshot/mugshot_disco.png"),
		7 : load("res://assets/mugshot/mugshot_hideux (7).png"),
		8 : load("res://assets/mugshot/mugshot_papy_classe (6).png")
		
	}
	
	match id_desc:
		0 :
			photo = portraits[7]
		1 :
			photo = portraits[5]
		2 :
			photo = portraits[6]
		3 :
			photo = portraits[4]
		4 :
			photo = portraits[4]
		5 :
			photo = portraits[3]
		6 :
			photo = portraits[2]
		7 :
			photo = portraits[5]
		8 :
			photo = portraits[8]
		9 :
			photo = portraits[8]
		10 :
			photo = portraits[2]
		11 :
			photo = portraits[5]
		12:
			photo = portraits[7]
		13:
			photo = portraits[7]
		14:
			photo = portraits[3]
		15:
			photo = portraits[7]
		16:
			photo = portraits[3]
		17:
			photo = portraits[4]
		18:
			photo = portraits[6]

		
	

	var texture_rect = $Photo 
	texture_rect.texture = photo
	
	#select_gender()
	
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
	var file = FileAccess.open("res://CSV/Prenom.csv", FileAccess.READ)
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
	
	
	
	
	
