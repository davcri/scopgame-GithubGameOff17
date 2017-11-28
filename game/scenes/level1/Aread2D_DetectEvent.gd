extends Area2D

signal action_event_available
signal action_event_no_longer_available

func _ready():
	pass

func _on_Area2D_body_enter(body):
	if body.get_name() == "Player":
		emit_signal("action_event_available")

func _on_Area2D_body_exit(body):
	if body.get_name() == "Player":
		emit_signal("action_event_no_longer_available")
