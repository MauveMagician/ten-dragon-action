extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0,-1)
const GRAVITY_SPEED = -45
export var verticalSpeed = -1050
export var horizontalSpeed = 250
var motion = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _physics_process(delta):
	motion.y -= GRAVITY_SPEED	
	if Input.is_action_pressed("ui_right"):
		motion.x = horizontalSpeed
	elif Input.is_action_pressed("ui_left"):
		motion.x = -horizontalSpeed
	else:
		motion.x = 0
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			motion.y = verticalSpeed
	elif Input.is_action_just_released("jump") and motion.y < -45:
		motion.y = GRAVITY_SPEED
	motion = move_and_slide(motion, FLOOR_NORMAL)