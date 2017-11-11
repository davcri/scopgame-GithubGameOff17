extends TextureFrame

export var color = Color(0, 0, 0, 1)

func _ready():
	# Connect "size_changed" signal to "on_screen_resize" method
	get_tree().get_root().connect("size_changed", self, "on_screen_resize")
	
	# Make sure that the node is in the origin
	set_pos(Vector2(0,0))

func _draw():
	# Draws the TextureFrame on top of the viewport area (the entire screen)
	draw_rect(get_viewport_rect(), color)
	 
func on_screen_resize():
	# Updates the size of the TextureFrame
	self.set_size(get_viewport_rect().size)