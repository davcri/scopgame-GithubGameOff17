extends CanvasLayer

# class member variables go here, for example:
# var a = 2
var sequence = []

func _ready():
	print("ASD")
	set_process_input(true)
	
func _input(event):
	if event.is_action_released("move_left"):
		print("LEFT")
	elif event.is_action_released("move_right"):
		print("RIGHT")
	