extends Area2D

signal landed(length,posx)
signal initialize_bridge
signal terminate_bridge

func _ready():
	randomize()

func _changeWidth(_new_width : float)->void:
	$ColorRect.rect_size.x=_new_width
	$CollisionShape2D.shape.extents.x=_new_width/2
	$CollisionShape2D.position.x=_new_width/2

func getPillarWidth()->float:
	return $ColorRect.size.x

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Pillar_body_entered(body):
	if body.name=="Player":
		$Bridge.enable()

func _on_Bridge_landed(length,posx):
	emit_signal("landed",length,posx)

func _on_MainScene_initialize_bridge():
	emit_signal("initialize_bridge")

func _on_MainScene_terminate_bridge():
	emit_signal("terminate_bridge")
