extends CanvasLayer

# class member variables go here, for example:
# var a = 2
var sequence = []
onready var lock = get_node("Smartphone/LockNodes")

func _ready():
	print("ASD")
	set_process_input(true)
	
func _input(event):
	var pos = lock.selector
	
	if event.is_action_released("move_left"):
		print("LEFT")
		if pos.x > 0:
			pos.x = pos.x - 1
			lock.update_selector_pos(pos.x, pos.y)
	elif event.is_action_released("move_right"):
		print("RIGHT")
		if pos.x < lock.NODE_PER_ROW - 1:
			pos.x = pos.x + 1
			lock.update_selector_pos(pos.x, pos.y)
	elif event.is_action_released("move_up"):
		print("UP")
		if pos.y > 0:
			pos.y = pos.y - 1
			lock.update_selector_pos(pos.x, pos.y)
	elif event.is_action_released("move_down"):
		print("DOWN")
		if pos.y < lock.NODE_PER_COLUMN - 1:
			pos.y = pos.y + 1
			lock.update_selector_pos(pos.x, pos.y)
	