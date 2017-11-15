extends CanvasLayer

# class member variables go here, for example:
# var a = 2
onready var sprite = get_node("Sprite")

func _ready():
	print(sprite)
