extends KinematicBody2D


export var speed : float = 200

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)

export (NodePath) var joystickRightPath
onready var joystickRight : Joystick = get_node(joystickRightPath)

var rotation_speed = 3

var velocity = Vector2.ZERO
var rotation_dir = 0
func _get_joy_input():
	if joystickLeft and joystickLeft.is_working:
		velocity = Vector2.ZERO
		if joystickLeft.output.y>0.4:
			velocity-=transform.y
		elif joystickLeft.output.y<-0.4:
			velocity+=transform.y
	
	if joystickRight and joystickRight.is_working:
		rotation_dir += joystickRight.output.x
	
func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_down'):
		velocity -= transform.y
	if Input.is_action_pressed('ui_up'):
		velocity += transform.y

func _physics_process(delta):
	get_input()
	_get_joy_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity*speed)



