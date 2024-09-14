extends Node2D

var player_character = preload("res://Scripts/GeoffScripts/TemporaryPlayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(Global.number_players):
		var player_instance = player_character.instantiate()
		player_instance.character_player_number = i + 1
		print (player_instance.character_player_number)
		add_child(player_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
