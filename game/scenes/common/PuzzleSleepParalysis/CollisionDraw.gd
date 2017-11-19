extends CollisionShape2D

export var color = Color(0.1, 0.1, 0.2)

func _ready():
	pass

# Draw collision rectangle 
func _draw():
	var collision_rect = Rect2(
		- get_shape().get_extents().x, 
		- get_shape().get_extents().y, 
		get_shape().get_extents().x * 2, 
		get_shape().get_extents().y * 2
	)
	
	draw_rect(collision_rect, color)
