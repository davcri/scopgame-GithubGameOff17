extends Area2D

onready var sprite = get_node("DreamLord")

signal DreamLordSpeaking


func _ready():
	pass

# Note that also tiles are considered bodies! So they will trigger 
# this function
func _on_Area2D_body_enter(body):
	# print(body)
	if body.get_name() == "Player":
		if sprite.get_opacity() == 0: 
			reveal_dream_lord()
	else:
		print(body)
		
		
func reveal_dream_lord():
	var duration = 5  # seconds
	var tween = get_node("Tween")
	tween.interpolate_property(sprite, "visibility/opacity", 0, 1, duration, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	tween.start()
	
	var voice = get_node("Voice")
	voice.play()
	emit_signal("DreamLordSpeaking", [duration])