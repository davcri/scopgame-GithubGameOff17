extends AnimatedSprite


func _ready():
	pass

func toggle():
	if get_frame() == 0:
		set_frame(1)
	elif get_frame() == 1:
		set_frame(0)
