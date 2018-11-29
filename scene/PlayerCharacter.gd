extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0,-1)
const GRAVITY_SPEED = -45
export var verticalSpeed = -1050
export var horizontalSpeed = 250
var motion = Vector2()
var facingLeft = -1
var dashing = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func dash ():
	motion.y = 0
	dashing = true
	$DashTiming.start()
	
func _on_DashTiming_timeout():
	dashing = false
	
func _physics_process(delta):
	if dashing:
		motion.x += facingLeft * 35
	if Input.is_action_just_pressed("dash") and not dashing:
		dash ()
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			motion.y = verticalSpeed
	elif Input.is_action_just_released("jump") and motion.y < GRAVITY_SPEED:
		motion.y = GRAVITY_SPEED
	if not dashing:
		motion.y -= GRAVITY_SPEED
		if Input.is_action_pressed("ui_right"):
			facingLeft = 1
			motion.x = horizontalSpeed
		elif Input.is_action_pressed("ui_left"):
			facingLeft = -1
			motion.x = -horizontalSpeed
		else:
			motion.x = 0
	motion = move_and_slide(motion, FLOOR_NORMAL)
