extends GridContainer

const NODE_PER_ROW = 3
const NODE_PER_COLUMN = 3

# 1 2 3
# 4 5 6
# 7 8 9
var buttons = []

var selector = Vector2()

onready var tween = get_node("Tween")

func _ready():
	_initialize_buttons()
	# set_fixed_process(true)
	update_selector_pos(1, 1)
	
# func _fixed_process(delta):
	

func get_selector_texture_button():
	return buttons[selector.y][selector.x]


func update_selector_pos(x, y):
	deactivate(selector.x, selector.y)
	tween.remove_all()
	
	# Updates selector coordinates
	selector.x = x
	selector.y = y
	activate(selector.x, selector.y)
	
	# Activate tween animation on the selector
	var duration = 0.5
	tween.interpolate_method(get_selector_texture_button(), "set_opacity", 1, 0, duration, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_method(get_selector_texture_button(), "set_opacity", 0, 1, duration, Tween.TRANS_SINE, Tween.EASE_OUT, duration)
	tween.set_repeat(true)
	tween.start()


func _initialize_buttons():
	get_node("TextureButton").set_toggle_mode(true)
	get_node("TextureButton").set_opacity(0.5)
	get_node("TextureButton").set_ignore_mouse(true)  # Ignores mouse clicks
	
	for i in range(NODE_PER_ROW):
		var row = []
		
		for j in range(NODE_PER_COLUMN):
			if i == 0 && j == 0:
				row.append(get_node("TextureButton"))
			else:
				var b = get_node("TextureButton").duplicate()
				row.append(b)
				add_child(b)
		
		buttons.append(row)

	# get_node("TextureButton").set_pressed(true)


func activate(i, j):
	buttons[j][i].set_pressed(true)

func deactivate(i, j):
	buttons[j][i].set_pressed(false)