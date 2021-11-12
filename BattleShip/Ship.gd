extends KinematicBody2D

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)
export (NodePath) var joystickRightPath
onready var joystickRight : Joystick = get_node(joystickRightPath)
export (PackedScene) var cannonBall

export var speed : float = 200
export var rotation_speed : float = 1.5
export var sensitivity : float = 0.3
var _velocity = Vector2.ZERO
var _rotation_dir : float = 0
const _cannon_ball_distance  = 30

func _get_joy_input():
	if joystickLeft and joystickLeft.is_working:
		_velocity = Vector2.ZERO
		if joystickLeft.output.y>sensitivity:
			_velocity-=transform.y*abs(joystickLeft.output.y)
		elif joystickLeft.output.y<sensitivity:
			_velocity+=transform.y*abs(joystickLeft.output.y)
		_rotation_dir += joystickLeft.output.x
	if joystickRight and joystickRight.is_working:
		shoot()
		if abs(joystickRight.output.y)>sensitivity or abs(joystickRight.output.x)>sensitivity:
			$GunSprite.rotation=-transform.get_rotation()+joystickRight.output.angle()
			$CannonBallPos.transform=$GunSprite.transform
			$CannonBallPos.position+=_cannon_ball_distance*$CannonBallPos.transform.x
func _get_input():
	_rotation_dir = 0
	_velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		_rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		_rotation_dir -= 1
	if Input.is_action_pressed('ui_down'):
		_velocity -= transform.y
	if Input.is_action_pressed('ui_up'):
		_velocity += transform.y
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		pass

func shoot():
	var cball = cannonBall.instance()
	owner.add_child(cball)
	cball.transform = $CannonBallPos.global_transform
func _physics_process(delta):
	_get_input()
	_get_joy_input()
	rotation += _rotation_dir * rotation_speed * delta
	_velocity = move_and_slide(_velocity*speed)



