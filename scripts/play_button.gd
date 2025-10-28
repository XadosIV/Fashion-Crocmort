extends Button

@export var GameScene : PackedScene

func _pressed():
	get_tree().change_scene_to_packed(GameScene)
