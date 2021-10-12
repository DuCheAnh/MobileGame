extends Node2D

var pillar_preload= preload("res://Scenes/Pillar.tscn")
var bridge_preload= preload("res://Scenes/Bridge.tscn")

const max_distance=768 #16*48
const min_distance=384 #16*16
const pillar_width=192
const threshold=-20

var current_pillar
var current_distance
var is_over_threshold=false

signal initialize_bridge
signal terminate_bridge

func _ready():
	randomize()
	_spawnPillar(max_distance)


func _process(delta):
	var volume=	AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Record"), 0)
	if volume>threshold and not is_over_threshold:
		$Timer.start()
		is_over_threshold=true
	elif volume<threshold and is_over_threshold:
		is_over_threshold=false
		$Timer.stop()
		emit_signal("terminate_bridge")

func _spawnPillar(_pos:float)->void:
	var distance=_pos
	current_distance=distance-pillar_width
	var last_pillar=$Pillars.get_child($Pillars.get_child_count()-1)
	var new_pillar=pillar_preload.instance()
	new_pillar.position=last_pillar.position
	new_pillar.position.x+=distance
	new_pillar.connect("landed",self,"_on_Pillar_landed")
	connect("initialize_bridge",new_pillar,"_on_MainScene_initialize_bridge")
	connect("terminate_bridge",new_pillar,"_on_MainScene_terminate_bridge")
	$Pillars.add_child(new_pillar)

func _on_Pillar_landed(length,posx):
	#if bridge is short, the player will only move half the length
	if length>$Player.getWidth() and length<current_distance:
		yield(get_tree().create_timer(.5),"timeout")
		movePlayer(length/2,posx)
	else:
		yield(get_tree().create_timer(1),"timeout")
		movePlayer(length,posx)
	#spawn a new pillar after bridge landed
	_spawnPillar(rand_range(min_distance,max_distance))

func movePlayer(_bridge_length:float,_bridge_posx:float)->void:
	var new_pos=$Player.position
	var player_bridge_distance=abs($Player.position.x-_bridge_posx)
	new_pos.x+=player_bridge_distance+_bridge_length+$Player.getWidth()/2
	$Tween.interpolate_property($Player,"position",$Player.position,
	new_pos,.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()

func _on_Timer_timeout():
	emit_signal("initialize_bridge")
