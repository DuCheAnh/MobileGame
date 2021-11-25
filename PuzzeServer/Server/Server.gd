extends Node

var network = NetworkedMultiplayerENet.new()
var port = 3224
var max_player = 4

func _ready():
	start_server()

func start_server():
	network.create_server(port,max_player)
	get_tree().set_network_peer(network)
	network.connect("peer_connected",self,"_player_connected")
	network.connect("peer_disconnected",self,"_player_disconnected")
	print("server started")

func _player_connected(id):
	print("player " + str(id) + " connected")
func _player_disconnected(id):
	print("player " + str(id) + " disconnected")
