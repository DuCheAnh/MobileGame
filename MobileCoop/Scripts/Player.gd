extends KinematicBody2D

export (int) var speed = 500
export (int) var jump_speed = -1800
export (int) var gravity = 4000

onready var sprite=$AnimatedSprite

var velocity = Vector2.ZERO
var was_on_floor=false

func _physics_process(delta):
	_get_input()
	_apply_animation()
	_normalize_animation_scale(delta)
	was_on_floor=is_on_floor()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jump(1)
func _apply_animation():
	#flip animations
	if velocity.x!=0:
		if velocity.x>0:
			sprite.flip_h=false
		else:
			sprite.flip_h=true
	#set animations
	if is_on_floor():
		if abs(velocity.x)>0:
			sprite.play("walk")
		else:
			sprite.play("idle")
	else:
		sprite.play("jump")
	#bounce when drop
	if is_on_floor() and !was_on_floor:
		sprite.scale = Vector2(1.1, 0.9)
func _normalize_animation_scale(delta):
	sprite.scale = sprite.scale.linear_interpolate(Vector2(1, 1), delta * 12)

func jump(multiplier):
	sprite.scale = Vector2(0.75, 1.25)
	velocity.y = jump_speed * multiplier
