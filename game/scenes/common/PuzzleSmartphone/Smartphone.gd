extends CanvasLayer

# class member variables go here, for example:
# var a = 2
var sequence = []
onready var lock = get_node("Smartphone/LockNodes")

signal activate_lock
signal solved


func _ready():
	set_process_input(true)


func _input(event):
	var pos = lock.selector
	
	if event.is_action_released("move_left"):
		if pos.x > 0:
			pos.x = pos.x - 1
			lock.update_selector_pos(pos.x, pos.y)
	elif event.is_action_released("move_right"):
		if pos.x < lock.COLUMNS - 1:
			pos.x = pos.x + 1
			lock.update_selector_pos(pos.x, pos.y)
	elif event.is_action_released("move_up"):
		if pos.y > 0:
			pos.y = pos.y - 1
			lock.update_selector_pos(pos.x, pos.y)
	elif event.is_action_released("move_down"):
		if pos.y < lock.ROWS - 1:
			pos.y = pos.y + 1
			lock.update_selector_pos(pos.x, pos.y)
			
	if event.is_action_released("action"):
		emit_signal("activate_lock")
		check_puzzle_solved()


func check_puzzle_solved():
	var solution = [
		[0, 1, 0],
		[0, 0, 0],
		[0, 0, 0]
	]
	
	# Transpose solution matrix
	_transpose(solution)
	
	var matrix = lock.get_puzzle_matrix_state()
	
	# print("Matrix:")
	# for row in matrix:
	# 	print(row)
	
	if matrix == solution:
		print("SOLVED")
		# Should add a bit of delay
		emit_signal("solved")
		# Temporary code
		
		get_node("PlayerInstructions").set_text("PUZZLE SOLVED \n" 
			+ "Are you satisfied now ? \n"
			+ "Go back to your life... \n\n" + 
			"Speak with the Dream Lord"
			)
			
		disable_input()

func disable_input():
	set_process_input(false)

func _transpose(matrix):
	for x in range(matrix.size()):
		for y in range(matrix[x].size()):
			if x < y:
				var tmp = matrix[x][y]
				matrix[x][y] = matrix[y][x]
				matrix[y][x] = tmp