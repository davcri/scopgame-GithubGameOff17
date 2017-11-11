extends CanvasLayer


func _ready():
	pass

func decrease(amount):
	var bar = get_node("TextureProgress")
	bar.set_val(bar.get_val() - amount)