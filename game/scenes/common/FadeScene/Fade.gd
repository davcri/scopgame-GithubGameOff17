extends CanvasLayer


onready var sprite = get_node("TextureFrame")
onready var tween = get_node("Tween")

func _ready():
	fadein(4, 0.5)
	
func fadein(length, delay):
	tween.interpolate_property(sprite, "visibility/opacity", sprite.get_opacity(), 0, length, Tween.EASE_IN, Tween.TRANS_SINE, delay)
	tween.start()

func dim():
	var length = 4
	tween.interpolate_property(sprite, "visibility/opacity", sprite.get_opacity(), 0.5, 0.5, Tween.EASE_IN, Tween.TRANS_SINE, 0)
	tween.start()