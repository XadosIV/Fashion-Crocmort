extends Control

var example_dict_name = {}
var example_dict_name_female = {}
var example_dict_name_male = {}

func _ready() -> void:
	
	var photo = Image.load_from_file("res://PlaceHolderImage/PhotoJean.png")
	var tex = ImageTexture.create_from_image(photo)
	
	var texture_rect = $Photo 
	texture_rect.texture = tex
	
	$Name.text = "Jean"
	import_ressource_data()
	
	

func import_ressource_data():
	var file = FileAccess.open("res://CSV/Prénom.csv", FileAccess.READ)
	
	while not file.eof_reached():
		var data_set = Array(file.get_csv_line())
		example_dict_name[example_dict_name.size()] = data_set
	
	file.close()
	
	#var length_dict = example_dict_name.size()
	#for key in length_dict:
	#	var values = example_dict_name[key]
	#	if key == 0:
	#		continue
		
	#	example_dict_name_female[key] = values[0]
	#	example_dict_name_male[key] = values[1]
		
		
	
	print(example_dict_name)
	
	
	
	
