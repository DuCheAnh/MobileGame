extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum StickState {ready, growing, stopgrow}
var state=StickState.ready
var canspeek = true
var cannotrotage = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canspeek=true;
	state = StickState.ready
	cannotrotage=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var power = AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Record"), 0)
	print(power);
	match state:
		StickState.ready:
			if (power > -20):
				state = StickState.growing
		StickState.growing:
			cannotrotage=false
			$StickCollision.scale.y -=0.01
			if (power < -20):
				state = StickState.stopgrow
		StickState.stopgrow:
			if (!cannotrotage):
				rotation_degrees = 90
				cannotrotage=true
			
func reset():
	canspeek=true;
	state = StickState.ready
	cannotrotage=false
	rotation_degrees = 0
	$StickCollision.scale.y = -1
