extends AnimatedSprite


func _ready():
	pass

func toggle():
	if get_frame() == 0:  # Frame 0 = gate close
		set_frame(1)
		get_node("StaticBody2D/CollisionShape2D").set_trigger(true)  # Disable collisions
		# read docs about set_trigger to know more
		
	elif get_frame() == 1:  # Frame 1 = gate open
		get_node("StaticBody2D/CollisionShape2D").set_trigger(false)  # Enable collisions
		set_frame(0)

func _on_Switch_toggled():
	toggle()
