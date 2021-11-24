extends Area2D

export (bool) var give_bullet = false
export (bool) var give_health = false




func _on_Item_body_entered(body):
	if body.is_in_group("ship"):
		if give_bullet:
			body.add_bullet(5)
		if give_health:
			body.add_health(20)
		queue_free()
