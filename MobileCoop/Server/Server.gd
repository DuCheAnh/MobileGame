extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 3224

var network = NetworkedMultiplayerENet.new()
var selected_IP
var selected_port

var local_player_id=0
sync var players = {}
sync var player_data = {}

func _ready():
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self,"_player_disconnected")
	get_tree().connect("connection_failed",self,"_connect_failed")
	get_tree().connect("server_disconnected",self,"_server_disconnected")

func _connect_to_server():
	get_tree().connect("connected_to_server",self,"_connected_ok")
	network.create_client(selected_IP,selected_port)
	get_tree().set_network_peer(network)

func _player_connected(id):
	print("player " + str(id) + " connected")

func _player_disconnected(id):
	print("player " + str(id) + " disconnected")

func _connected_ok():
	print("successfully connected to server")
	register_player()
	rpc_id(1,"send_player_info",local_player_id,player_data)
func _connect_failed():
	print("connection failed")

func _server_disconnected():
	print("server disconnected")

func register_player():
	local_player_id = get_tree().get_network_unique_id()
	player_data=Save.save_data
	players[local_player_id]=player_data

sync func update_waiting_room():
	get_tree().call_group("WaitingRoom","refresh_player",players)

