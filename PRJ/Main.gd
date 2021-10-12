extends Node2D

onready var platform = get_node("Platform")
onready var player = get_node("Player")
var platform_posion = 0
var platform_width
var point = 0

func rand_position():
	randomize()
	platform_posion = int(rand_range(100,450))
	platform.position = Vector2(platform_posion, platform.position.y)

func new_platform():
	if platform.get_parent():
		platform.get_parent().remove_child(platform)
	platform.set_shape()
	add_child(platform)
	rand_position()
	platform_width = platform.width

func reset_bridge():
	$Player/Bridge/Line2D.lenght = 0
	$Player/Bridge/Line2D.set_point_position(1, Vector2 (0, $Player/Bridge/Line2D.lenght))

func _ready():
	pass

func _process(delta):
	#test 
	if Input.is_action_just_pressed("touch"):
		$Player/Bridge/Line2D.scream = true
	if Input.is_action_just_released("touch"):
		$Player/Bridge/Line2D.scream = false
	if Input.is_action_just_pressed("score +"):
		point+=1
		$Player/Bridge/Line2D.landed = false
		new_platform()
		reset_bridge()
		print("point ",point)
	if Input.is_action_just_pressed("reset"):
		point = 0
		$Player/Bridge/Line2D.landed = false
		new_platform()
		reset_bridge()
		print("point ",point)
	#test
	platform_width = platform.width
	if $Player/Bridge/Line2D.landed == true:
		if platform.position.x - 52 - $Player/Bridge/Line2D.drew_lenght in range(-platform_width, platform_width):
			point+=1
			$Player/Bridge/Line2D.landed = false
			new_platform()
			reset_bridge()
			print("point ",point)
		else: 
			point = 0
			$Player/Bridge/Line2D.landed = false
			new_platform()
			reset_bridge()
			print("point ",point)
		
	print(platform.position.x - 52, " distance")
	#print(platform_width, " platforn width")
	print(point, " point")
