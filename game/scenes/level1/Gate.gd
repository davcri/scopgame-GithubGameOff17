extends Node2D


func _ready():
	set_process_input(true)
	
func _input(event):
	if event.is_action_released("action"):
		var bodies = get_node("Switch/Area2D").get_overlapping_bodies()
		for b in bodies:
			if b.get_name() == "Player":
				# Change sprite
				get_node("Switch").toggle()
				get_node("Gate").toggle()
				
				
