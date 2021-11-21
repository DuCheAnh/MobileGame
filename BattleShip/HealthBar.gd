extends Control

export (Color) var normal_color = Color.chartreuse
export (Color) var cautious_color = Color.yellowgreen
export (Color) var danger_color = Color.coral

export (float, 0, 1, 0.05) var cautious_zone = 0.5
export (float, 0, 1, 0.05) var danger_zone = 0.2


func _on_health_updated(health):
	$HealthFront.value = health
	$Tween.interpolate_property($HealthBack,"value",$HealthBack.value,health,0.3,Tween.TRANS_SINE,Tween.EASE_IN_OUT,0.2)
	$Tween.start()
	_apply_health_tint(health)
func _on_max_health_updated(max_health):
	$HealthBack.max_value=max_health
	$HealthFront.max_value=max_health

func _apply_health_tint(health):
	if health<=danger_zone*$HealthFront.max_value:
		$HealthFront.tint_progress=danger_color
	elif health<=cautious_zone*$HealthFront.max_value:
		$HealthFront.tint_progress=cautious_color
	else:
		$HealthFront.tint_progress=normal_color

func update_health(health):
	_on_health_updated(health)
