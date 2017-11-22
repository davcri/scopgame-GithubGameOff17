extends ProgressBar

onready var timer = get_node("/root/Level1/Paralysis/SleepParalysis/Timer")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var val = 100 * (timer.get_wait_time() - timer.get_time_left()) / timer.get_wait_time()
	set_value(val)