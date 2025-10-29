extends Control
signal clicJournal
signal clicTool(typeID, toolID)
signal end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_carnet_ui_clic_journal() -> void:
	clicJournal.emit()


func _on_tools_ui_tools_clic(typeID: Variant, toolsID: Variant) -> void:
	clicTool.emit(typeID, toolsID)


func _on_carnet_ui_end() -> void:
	end.emit()
