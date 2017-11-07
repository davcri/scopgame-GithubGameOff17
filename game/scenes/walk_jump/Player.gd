extends KinematicBody2D

# MOVEMENT CONST
const GRAVITY = Vector2(0, 2000)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_FRICTION = 20
const MOVEMENT_SPEED = 600
const ACCELERATION = 0.9
const JUMP_FORCE = 800
# Jump threshold to avoid multi-jump
const JUMP_TIME_THRESHOLD = 0.2

# PLAYER ATTRIBUTES
var velocity = Vector2()
var can_jump = false
var jump_timer = 0

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	if(can_jump && Input.is_action_pressed("ui_up")):
		velocity.y -= JUMP_FORCE
		jump_timer = JUMP_TIME_THRESHOLD

func _process(delta):
	# Add Gravity
	velocity += GRAVITY * delta

	# Increment time
	jump_timer += delta

	# Move and Slide
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_FRICTION)

	# Jump Timer Controller
	if(is_move_and_slide_on_floor()):
		jump_timer = 0

	# Can jump?
	can_jump = jump_timer < JUMP_TIME_THRESHOLD

	# Movement
	var movement = 0

	if(Input.is_action_pressed("ui_left")):
		movement -= 1
	if(Input.is_action_pressed("ui_right")):
		movement += 1

	# Set movement speed
	movement *= MOVEMENT_SPEED

	# Change horizontal velocity
	velocity.x = lerp(velocity.x, movement, ACCELERATION)
