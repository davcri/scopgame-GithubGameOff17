extends Area2D

var in_player_range = false

func _ready():
	pass

func action():
	if in_player_range:
		self.get_node("../SamplePlayer2D").play("toggle")
		self.get_node("/root/World/gate/").queue_free()
		self.queue_free()

func _on_InteractPoint_body_enter(body):
	if body.get_name() == "Player":
		in_player_range = true

func _on_InteractPoint_body_exit(body):
	if body.get_name() == "Player":
		in_player_range = false