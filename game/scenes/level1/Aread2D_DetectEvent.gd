extends Area2D

onready var player = get_node("/root/Level1/Player")

signal toggled


func _ready():
	connect("body_enter", self, "_on_Area2D_body_enter")
	connect("body_exit", self, "_on_Area2D_body_exit")
	set_process_input(true)

func  _input(event):
	if event.is_action_released("action"):
		var bodies = get_overlapping_bodies()
		for b in bodies:
			if b.get_name() == "Player":
				# Change sprite
				get_parent().toggle()

func _on_Area2D_body_enter(body):
	if body.get_name() == "Player":
		player.set_event_available()

func _on_Area2D_body_exit(body):
	if body.get_name() == "Player":
		player.set_event_no_longer_available()
