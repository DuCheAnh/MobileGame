extends KinematicBody2D


const lengthen_speed=10
const bridge_base_size=32

var landed=false
var disabled
var failed=false
var is_init=false

signal landed(length,posx)

func _ready():
	disabled=true


func _process(_delta):
	#disable additional movement when the bridge is not active
	#or is landing
	if disabled==false and not $Tween.is_active():
		if is_init and not landed:
			_lengthenBridge(lengthen_speed)
		if !is_init and $ColorRect.rect_size.y!=bridge_base_size:
			$Tween.interpolate_property(self,"rotation_degrees",rotation_degrees,
			90,1,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
			$Tween.start()
			emit_signal("landed",getWidth(),global_position.x)


func enable()->void:
	disabled=false

func getWidth()->float:
	return $ColorRect.rect_size.y

func _lengthenBridge(_pixel:float)->void:
	$ColorRect.rect_size.y+=_pixel
	$ColorRect.rect_position.y-=_pixel
	$RayCast2D.position.y=-$ColorRect.rect_size.y
	$CollisionShape2D.shape.extents.y=$ColorRect.rect_size.y/2
	$CollisionShape2D.position.y=-$CollisionShape2D.shape.extents.y

func _on_Tween_tween_completed(_object, _key):
	landed=true
	disabled=true
	#do another 90 if the bridge doesnt connect
	if !failed:
		if !$RayCast2D.is_colliding():
			print("failed")
			failed=true
			$Tween.interpolate_property(self,"rotation_degrees",rotation_degrees,
			180,1,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
			$Tween.start()

func _on_Pillar_initialize_bridge():
	is_init=true

func _on_Pillar_terminate_bridge():
	is_init=false

