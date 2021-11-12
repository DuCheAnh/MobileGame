extends Area2D

export var speed : float = 750
export var fly_time : float  = .5
func _ready():
	yield(get_tree().create_timer(fly_time),"timeout")
	explode()
func _physics_process(delta):
	if $AnimatedSprite.animation=="shoot":
		position += transform.x * speed * delta
	
func explode():
	$AnimatedSprite.play("explode")
	yield($AnimatedSprite,"animation_finished")
	queue_free()
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
