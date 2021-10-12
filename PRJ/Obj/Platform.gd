extends Node2D

onready var sprite = get_node("AnimatedSprite")
var width 

func rand_platform():
	randomize()
	sprite.animation = str(int(rand_range(1, 5)))
	set_shape()

func set_shape():
	$AnimatedSprite/Shapes/Shape1.disabled = true
	$AnimatedSprite/Shapes/Shape2.disabled = true
	$AnimatedSprite/Shapes/Shape3.disabled = true
	$AnimatedSprite/Shapes/Shape4.disabled = true
	$AnimatedSprite/Shapes/Shape5.disabled = true
	if sprite.animation == "1":
		$AnimatedSprite/Shapes/Shape1.disabled = false
		width = 32
	if sprite.animation == "2":
		$AnimatedSprite/Shapes/Shape2.disabled = false
		width = 29
	if sprite.animation == "3":
		$AnimatedSprite/Shapes/Shape3.disabled = false
		width = 24
	if sprite.animation == "4":
		$AnimatedSprite/Shapes/Shape4.disabled = false
		width = 18
	if sprite.animation == "5":
		$AnimatedSprite/Shapes/Shape5.disabled = false
		width = 14

func _ready():
	rand_platform()
