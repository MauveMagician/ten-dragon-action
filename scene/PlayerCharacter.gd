extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0,-1)
const GRAVITY_SPEED = -45
const DRAG = 5
export var verticalSpeed = -1050
export var horizontalSpeed = 250
var motion = Vector2()
var facingLeft = -1
var dashing = false
var airdash = false
var gravity = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func dash ():
	motion.y = 0
	motion.x = 0
	dashing = true
	gravity = false
	$DashTiming.start()
	
func _on_DashTiming_timeout():
	gravity = true
	dashing = false
	airdash = false
	$DashStopping.start()

func _on_DashStopping_timeout():
	pass
	
func _physics_process(delta):
	if gravity:
		motion.y -= GRAVITY_SPEED
	if dashing:
		motion.x += facingLeft * 25
	elif not $DashStopping.is_stopped():
		motion.x += facingLeft * 12.5
	else:
		if Input.is_action_just_pressed("dash"):
			if is_on_floor():
				airdash = false
			else:
				airdash = true
			dash ()
		if Input.is_action_pressed("ui_right"):
			facingLeft = 1
			motion.x = horizontalSpeed
		elif Input.is_action_pressed("ui_left"):
			facingLeft = -1
			motion.x = -horizontalSpeed
		else:
			motion.x = 0
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			motion.y = verticalSpeed
	elif gravity and Input.is_action_just_released("jump") and motion.y < GRAVITY_SPEED:
		motion.y = GRAVITY_SPEED
	if is_on_floor():
		gravity = true
	motion = move_and_slide(motion, FLOOR_NORMAL)
