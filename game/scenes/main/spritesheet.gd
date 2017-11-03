extends Sprite

# class member variables go here, for example:
var rows = 21
var frame_size = 64

var animation_row = {
	"WALK_UP": 8,  # Row index at which the WALK_UP animation can be found inside the spritesheet
	"WALK_LEFT": 9,
	"WALK_DOWN": 10,
	"WALK_RIGHT": 11
}

var animation_frames = {
	"WALK_UP": 9,  # number of frames for WALK_UP animation
	"WALK_LEFT": 9,
	"WALK_DOWN": 9,
	"WALK_RIGHT": 9
}

var frame = 0
var next_frame_delay = 0.1  # seconds
var elapsed_time = 0
var current_frame = Rect2(Vector2(0,0), Vector2(frame_size, frame_size))
var walk_direction = ""

func _ready():
	set_region(true)
	set_region_rect(current_frame)
	set_fixed_process(true)
	
func _fixed_process(delta):
	elapsed_time += delta
	
	if walk_direction != "":
		animate(walk_direction)  # updates current frame
	else:
		frame = 0
		_update_region_rect(walk_direction)

func animate(a):
	if(elapsed_time > next_frame_delay):
		frame += 1
		if frame == animation_frames[a]:
			frame = 0
		_update_region_rect(a)
		elapsed_time = 0

func walk_right():
	walk_direction = "WALK_RIGHT"

func walk_left():
	walk_direction = "WALK_LEFT"

func rest():
	walk_direction = ""
	
func _update_region_rect(a):
	if a == "":
		# rest stance, here defaults to WALK_DOWN
		set_region_rect(Rect2(frame*frame_size, animation_row["WALK_DOWN"]*frame_size, frame_size, frame_size))
	else:
		set_region_rect(Rect2(frame*frame_size, animation_row[a]*frame_size, frame_size, frame_size))