extends Node2D

const smartphone_scene_path = "res://game/scenes/common/PuzzleSmartphone/Smartphone.tscn"
const fade_node_path = "/root/Level1/GraphicEffects/FadeInEffect"
const player_node_path = "/root/Level1/Player"


func _ready():
	set_process_input(true)
	
signal action_event_available
signal action_event_no_longer_available
signal puzzle_started
signal puzzle_completed
signal puzzle_quit

var smartphone_puzzle = null  # Scene variable

enum STATES {
	SMARTPHONE_SHOWED,
	SMARTPHONE_NOT_SHOWED
}
	
var state = STATES.SMARTPHONE_NOT_SHOWED

func _input(event):
	if state == STATES.SMARTPHONE_SHOWED:
		if event.is_action_released("cancel"):
			emit_signal("puzzle_quit")
			quit_puzzle()
	elif state == STATES.SMARTPHONE_NOT_SHOWED:
		if event.is_action_released("action"):
			on_action_pressed()
			
func on_action_pressed():
	var colliding_bodies = get_node("Sprite/Area2D").get_overlapping_bodies()
	for b in colliding_bodies:
		if b.get_name() == "Player":
			_load_smartphone_scene()
			get_node(fade_node_path).dim()

func quit_puzzle():
	if smartphone_puzzle != null:
		print(smartphone_puzzle)
		_unload_smartphone_scene()
		get_node(fade_node_path).fadein(0.5, 0)
		get_node(player_node_path).enable_input()
	else:
		print("smartphone scene null")

func _on_Area2D_body_enter(body):
	if body.get_name() == "Player":
		emit_signal("action_event_available")

func _on_Area2D_body_exit(body):
	if body.get_name() == "Player":
		emit_signal("action_event_no_longer_available")

func _load_smartphone_scene():
	var smartphonescene = load(smartphone_scene_path)
	smartphone_puzzle = smartphonescene.instance()
	get_node("/root/Level1/").call_deferred("add_child", smartphone_puzzle)
	# set_process_input(false)
	emit_signal("puzzle_started")
	
	state = STATES.SMARTPHONE_SHOWED

func _unload_smartphone_scene():
	smartphone_puzzle.queue_free()
	smartphone_puzzle = null
	set_process_input(true)
	state = STATES.SMARTPHONE_NOT_SHOWED