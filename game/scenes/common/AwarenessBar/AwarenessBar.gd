extends CanvasLayer

# Value goes from 0 to 100 (percentage)
const LOW_VALUE = 25
const MID_VALUE = 75
const MAX_VALUE = 100

signal zero_awareness
signal low_awareness

onready var bar = get_node("TextureProgress")

func _ready():
	pass


func decrease(amount):
	bar.set_val(bar.get_val() - amount)
	
	var awareness = get_awareness_value()
	
	if awareness <= 0:
		emit_signal("zero_awareness")
	elif awareness <= LOW_VALUE:
		emit_signal("low_awareness")
	elif awareness <= MID_VALUE:
		pass  # Do nothing at the moment
	elif awareness <= MAX_VALUE:
		pass
		
func get_awareness_value():
	return bar.get_val()