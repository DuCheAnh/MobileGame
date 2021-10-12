extends KinematicBody2D
var gravity=30
var velocity=Vector2()
func _physics_process(delta):
	if !$RayCast2D.is_colliding():
		velocity.y+=gravity
		move_and_slide(velocity)
func getWidth()->float:
	return $ColorRect.rect_size.x;


