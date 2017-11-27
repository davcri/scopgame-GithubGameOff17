extends Node

# For explanations about how this script works, see here: 
# https://godot.readthedocs.io/en/stable/learning/step_by_step/singletons_autoload.html


var current_scene = null
var root

func _ready():
	root = get_tree().get_root()
	set_process_input(true)

func _input(event):
	if event.is_action_released("enter_debug_room"):
		goto_scene("res://game/scenes/main/main.tscn")

func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)

func _get_current_scene():
	return root.get_child(root.get_child_count() - 1)

func _deferred_goto_scene(path):
    # Immediately free the current scene,
    # there is no risk here.
    _get_current_scene().free()

    # Load new scene
    var s = ResourceLoader.load(path)

    # Instance the new scene
    current_scene = s.instance()

    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene(current_scene)