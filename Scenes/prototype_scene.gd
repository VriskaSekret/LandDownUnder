extends Node2D

@onready var camera_2d: Camera2D = $Camera2D

var players
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuBgMusic.stop()
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		camera_2d.add_target(i)

func _process(delta: float) -> void:
	if not players:
		return
	
	for player in players:
		player.camera_die.connect(_on_player_camera_died)

func _on_player_camera_died():
	camera_2d.remove_arget(player)
