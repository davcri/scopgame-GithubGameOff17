extends AnimatedSprite

signal toggled

func _ready():
	connect("toggled", get_parent().get_node("Gate"), "_on_Switch_toggled")

func toggle():
	emit_signal("toggled")
	if get_frame() == 0:
		set_frame(1)
	elif get_frame() == 1:
		set_frame(0)
