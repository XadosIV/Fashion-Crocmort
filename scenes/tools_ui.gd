extends Control
signal toolsClic(typeID, toolsID)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("toolsClic", get_node("/root/Global")._tool_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#get_node("/root/Global")

func _on_table_button_pressed() -> void:
	$Control/table.visible = true
	$Control/drawer.visible = false
	$Control/drawer._init_button()

func _on_drawer_button_pressed() -> void:
	$Control/table.visible = false
	$Control/drawer.visible = true
	$Control/table._init_button()

func _on_drawer_drawer_clic(accessoriesID: Variant) -> void:
	toolsClic.emit(1, accessoriesID)

func _on_table_table_clic(IDtool: Variant) -> void:
	toolsClic.emit(0, IDtool)
