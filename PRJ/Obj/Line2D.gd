extends Line2D

var lenght = 0
var power = 0
var drawing = false
var landed = false
var drew_lenght = 0
var scream = false

func set_lenght():
	lenght+=1

func draw_bridge():
	power = AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Record"), 0)
	#print(power)
	#if power >= -60 :
	#	scream = true
	#else:
	#	scream = false
	
	if scream == true:
		
		set_lenght()
		if lenght > 10:
			set_point_position(1, Vector2 (0, 10 - lenght))
			rotation_degrees = 0
			drawing = true
	elif drawing == true:
			rotation_degrees = 90
			landed = true
			drew_lenght = lenght - 3
			drawing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	draw_bridge()
	print(lenght," lenght")
