extends Node

# Configure here the correct paths to nodes
onready var player_node = get_node("/root/Node/Player")   
onready var area2D_trigger = get_node("/root/Node/SleepParalysisTrigger")

onready var timer = get_node("Timer")

export var paralysis_seconds = 10  
export var awareness_damage = 5

enum STATES {
	NORMAL,
	PARALYZED
}

onready var state = STATES.NORMAL

var seconds_malus = 0.5

signal sleep_paralysis_started
signal sleep_paralysis_ended


func _ready():
	if not (area2D_trigger and player_node):
		print("Nodes not configured in SleepParalysis")
	else:
		timer.set_wait_time(paralysis_seconds)
		timer.connect("timeout", self, "_on_timer_timeout")
		timer.set_one_shot(true)
		
		set_process_input(true)
		
func _input(event):
	if state == STATES.PARALYZED && not player_node.isDead():
		if event.is_action_pressed("move_left") || \
			event.is_action_pressed("move_right") || \
			event.is_action_pressed("jump") || \
			event.is_action_pressed("move_down") || \
			event.is_action_pressed("action"):
			# Do this:
			var timeleft = timer.get_time_left()
			timer.set_wait_time(timeleft + seconds_malus)
			timer.start()
			player_node.get_node("AwarenessBar").decrease(awareness_damage)
			
			if player_node.isDead():
				timer.stop()


func _on_SleepParalysisTrigger_body_enter(body):
	if body == player_node:
		player_node.disable_input()
		timer.start()
		state = STATES.PARALYZED
		
func _on_timer_timeout():
	print("SBLOCCA")
	player_node.enable_input()
	state = STATES.NORMAL