extends GridContainer

const NODE_PER_ROW = 3
const NODE_PER_COLUMN = 3

var buttons = []

#   1 2 3
#   4 5 6
#   7 8 9
var selector = Vector2(0, 0)


func _ready():
	get_node("TextureButton").set_toggle_mode(true)
	
	for i in range(NODE_PER_ROW):
		var row = []
		
		for j in range(NODE_PER_COLUMN):
			if i == 0 && j == 0:
				row.append(get_node("TextureButton"))
				
			else:
				var b = get_node("TextureButton").duplicate(true)  # ???
				row.append(b)
				add_child(b)
		
		print(row)
		buttons.append(row)

	get_node("TextureButton").set_pressed(true)
	activate(selector.x, selector.y)


func activate(i, j):
	buttons[i][j].set_pressed(true)
