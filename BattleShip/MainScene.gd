extends Node2D




func _on_Ship_health_changed(health):
	$UI/HealthBar.update_health(health)
