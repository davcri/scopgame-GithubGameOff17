extends Node2D


func _ready():
	set_process_input(true)
	
signal action_event_available
signal action_event_no_longer_available
signal puzzle_started


func _input(event):
	if event.is_action_released("action"):
		on_action_pressed()
		
func on_action_pressed():
	var colliding_bodies = get_node("Sprite/Area2D").get_overlapping_bodies()
	for b in colliding_bodies:
		if b.get_name() == "Player":
			_load_smartphone_scene()

func _on_Area2D_body_enter(body):
	if body.get_name() == "Player":
		emit_signal("action_event_available")

func _on_Area2D_body_exit(body):
	if body.get_name() == "Player":
		emit_signal("action_event_no_longer_available")

func _load_smartphone_scene():
	var smartphonescene = load("res://game/scenes/common/PuzzleSmartphone/Smartphone.tscn")
	var smartphone_puzzle = smartphonescene.instance()
	get_node("/root/Level1/").call_deferred("add_child", smartphone_puzzle)
	set_process_input(false)
	emit_signal("puzzle_started")
	