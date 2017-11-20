extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var player = get_parent().get_node("Player")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("EventIcon").set_opacity(0)


func _on_Area2D_body_enter(body):
	if body == player:
		get_node("SamplePlayer2D").play("event")
		get_node("EventIcon").set_opacity(1)


func _on_Area2D_body_exit(body):
	if body == player:
		get_node("EventIcon").set_opacity(0)
