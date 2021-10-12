extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!$Player/PlayerRayCast2D.is_colliding()):
		pass
	


func _on_Area2D_body_entered(body: Node) -> void:
	if (body.name == "Ground2"):
		$Stick.position.x = $Ground2.position.x + 25
		$Stick.reset()
		$Ground1.position.x +=250
	if (body.name == "Ground1"):
		$Stick.position.x = $Ground1.position.x + 25
		$Stick.reset()
		$Ground2.position.x +=250
