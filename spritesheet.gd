extends Sprite

# class member variables go here, for example:
var rows = 21

var frame_size = 64
var frame = 0
var next_frame_delay = 0.1  # seconds
var elapsed_time = 0

var current_frame = Rect2(Vector2(0,0), Vector2(frame_size, frame_size))

const WALK_UP_ROW = 8
const WALK_LEFT_ROW = 9
const WALK_DOWN_ROW = 10
const WALK_RIGHT_ROW = 11
const WALK_FRAME_COUNT = 9



func _ready():
	set_region(true)
	set_region_rect(current_frame)
	set_fixed_process(true)
	
func _fixed_process(delta):
	elapsed_time += delta
	
	var direction = WALK_UP_ROW
	
	if Input.is_action_pressed("ui_up"):
		animate()  # updates current frame
	else:
		frame = 0
		_update_region_rect()

func animate():
	if(elapsed_time > next_frame_delay):
		frame += 1
		if frame == WALK_FRAME_COUNT:
			frame = 0
		_update_region_rect()
		elapsed_time = 0

func _update_region_rect():
	set_region_rect(Rect2(frame*frame_size, WALK_UP_ROW*frame_size, frame_size, frame_size))
