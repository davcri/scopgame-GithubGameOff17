extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var tilemap = get_parent().get_node("TileMap")
onready var player = get_parent().get_node("Player")
onready var audio = get_parent().get_node("EventTrigger/SamplePlayer2D")

const manhole_open_tile_id = 26
const manhole_close_tile_id = 1

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_released("action") and player_is_on_manhole(player.get_pos()):
		change_tile(player.get_pos(), manhole_open_tile_id)
		audio.play("rumore")


func change_tile(global_pos, tile_id):
	var tile_pos = tilemap.world_to_map(global_pos) + Vector2(0, 1)
	var tile = tilemap.get_cell(tile_pos.x, tile_pos.y)
	print(tile)
	tilemap.set_cell(tile_pos.x, tile_pos.y, tile_id)
	
func player_is_on_manhole(global_pos):
	var tile_pos = tilemap.world_to_map(global_pos) + Vector2(0, 1)
	var tile_id = tilemap.get_cell(tile_pos.x, tile_pos.y)
	return tile_id == manhole_close_tile_id