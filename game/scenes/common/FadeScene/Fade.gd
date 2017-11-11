extends CanvasLayer


onready var sprite = get_node("TextureFrame")
onready var tween = get_node("Tween")

func _ready():
	fadein()
	
func fadein():
	var length = 4
	var delay = 0.5
	tween.interpolate_property(sprite, "visibility/opacity", sprite.get_opacity(), 0, length, Tween.EASE_IN, Tween.TRANS_LINEAR, delay)
	tween.start()