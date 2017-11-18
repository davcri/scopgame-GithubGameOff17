extends GridContainer

# Convention used the same as Godot, so:
# X positive to the right
# Y positive to the bottom
#
# buttons[0][0] is:
#     O . .
#     . . .
#     . . .
#
# buttons [2][2] is:
#     . . .
#     . . .
#     . . O

const ROWS = 3
const COLUMNS = 3

var buttons = []  # matrix of TextureButton
var selector = Vector2()

onready var tween = get_node("Tween")

func _ready():
	set_columns(COLUMNS)
	_initialize_buttons()
	get_node("Selector").set_offset(Vector2(0, 0.2))
	

func _initialize_buttons():
	get_node("TextureButton").set_toggle_mode(true)
	get_node("TextureButton").set_ignore_mouse(true)  # Ignores mouse clicks
	deselect(get_node("TextureButton"))
	
	for i in range(ROWS):
		var row = []
		
		for j in range(COLUMNS):
			if i == 0 && j == 0:
				row.append(get_node("TextureButton"))
			else:
				var b = get_node("TextureButton").duplicate()
				row.append(b)
				add_child(b)
				
		buttons.append(row)



func update_selector_pos(x, y):
	selector = Vector2(x, y)
	get_node("Selector").set_pos(buttons[y][x].get_pos())
	# To understand better: uncomment the following print e move the selector
	# print(selector) 
	
	# TODO: Move selector with animations

func _on_CanvasLayer_activate_lock():
	toggle_selected()
	# buttons[selector.y][selector.x].set_pressed(true)
	
func toggle_selected():
	var selected_button = buttons[selector.y][selector.x]
	if selected_button.is_pressed():
		deselect(selected_button)
	else:
		select(selected_button)

# button: TextureButton	
func deselect(button):
	button.set_pressed(false)
	button.set_opacity(0.25)

# button: TextureButton
func select(button):
	button.set_pressed(true)
	button.set_opacity(1)


func get_puzzle_matrix_state():
	var matrix = []
	
	for x in range(ROWS):
		var row = []
		
		for y in range(COLUMNS):
			if buttons[y][x].is_pressed():
				row.append(1)
			else:
				row.append(0)
		
		matrix.append(row)
	
	return matrix

#func tween_animation_code(x, y):
#	tween.remove_all()
#	
#	# Updates selector coordinates
#	selector.x = x
#	selector.y = y
#	
#	print(selector)
#	# activate(selector.x, selector.y)
#	
#	# Activate tween animation on the selector
#	var duration = 0.5
#	tween.interpolate_method(get_selector_texture_button(), "set_opacity", 1, 0, duration, Tween.TRANS_SINE, Tween.EASE_IN)
#	tween.interpolate_method(get_selector_texture_button(), "set_opacity", 0, 1, duration, Tween.TRANS_SINE, Tween.EASE_OUT, duration)
#	tween.set_repeat(true)
#	tween.start()