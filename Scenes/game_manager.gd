extends Node2D

var player_character = preload("res://Scripts/GeoffScripts/TemporaryPlayer.tscn")
var last_level = Global.total_level
@onready var in_game_ui: Control = $"../InGameUI"
var paused_for_item = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(Global.number_players):
		var player_instance = player_character.instantiate()
		player_instance.character_player_number = i + 1
		player_instance.name = "Player%d" % (i + 1)
		print (player_instance.character_player_number)
		add_child(player_instance)
		last_level = Global.total_level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pause_for_item():
	in_game_ui.item_select.show()
	Engine.time_scale = 0
	paused_for_item = true
	Global.game_paused = true

func check_level():
	if last_level < Global.total_level:
		last_level = Global.total_level
		print("Level: " + str(Global.total_level))
		pause_for_item()
