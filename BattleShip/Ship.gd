extends KinematicBody2D

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)
export (NodePath) var joystickRightPath
onready var joystickRight : Joystick = get_node(joystickRightPath)
export (PackedScene) var cannonBall

export var max_health : int = 100
export var bullet_count : int = 0
export var speed : float = 200
export var rotation_speed : float = 1.5
export var sensitivity : float = 0.3

signal health_changed(health)
signal killed()

const CBALL_DISTANCE  = 30

onready var health=max_health setget _set_health

var velocity = Vector2.ZERO
var rotation_dir : float = 0


func _physics_process(delta):
	_get_input()
	_get_joy_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity*speed)

func _get_joy_input():
	if joystickLeft and joystickLeft.is_working:
		velocity = Vector2.ZERO
		if joystickLeft.output.y>sensitivity:
			velocity-=transform.y*abs(joystickLeft.output.y)
		elif joystickLeft.output.y<sensitivity:
			velocity+=transform.y*abs(joystickLeft.output.y)
		rotation_dir += joystickLeft.output.x
	if joystickRight and joystickRight.is_working:
		shoot()
		if abs(joystickRight.output.y)>sensitivity or abs(joystickRight.output.x)>sensitivity:
			$GunSprite.rotation=-transform.get_rotation()+joystickRight.output.angle()
			$CannonBallPos.transform=$GunSprite.transform
			$CannonBallPos.position+=CBALL_DISTANCE*$CannonBallPos.transform.x
func _get_input():
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
	if Input.is_action_just_pressed("ui_accept"):
		damage(5)
func _set_health(value):
	var prev_health = health
	health = clamp(value,0,max_health)
	print(health)
	if health!=prev_health:
		emit_signal("health_changed",health)
	if health==0:
		kill()	
		emit_signal("killed")

func damage(amount):
	if $InvulnerabilityTimer.is_stopped():
		$InvulnerabilityTimer.start()
		_set_health(health-amount)
		$AnimationPlayer.play("damaged")
func shoot():
	var cball = cannonBall.instance()
	owner.add_child(cball)
	cball.transform = $CannonBallPos.global_transform
func kill():
	pass





func _on_InvulnerabilityTimer_timeout():
	$AnimationPlayer.play("normal")
