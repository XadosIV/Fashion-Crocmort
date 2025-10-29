extends TextureButton

@export var soundOn: Texture
@export var soundOff: Texture

var sound = true
signal changeSound(on)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("changeSound", get_node("/root/Global")._update_sound_volume)
	sound = get_node("/root/Global").sound
	if sound :
		texture_normal = soundOn
	else :
		texture_normal = soundOff

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _pressed() -> void:
	sound = !sound
	if sound :
		texture_normal = soundOn
	else :
		texture_normal = soundOff
	changeSound.emit(sound)
	
