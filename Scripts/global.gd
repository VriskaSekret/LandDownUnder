extends Node

var number_players = -1

var game_paused = false
var experience = 0
var total_level = 1
var experience_needed = 10.0 * (total_level * 1.2)


# player_characters [player1, player2, player3, player4]
# FOR FINDING WHAT CHARACTER EACH PLAYER IS USING
# -1 MEANS NO SELECTION
var player_characters = [-1,-1,-1,-1]
var player_weapons = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
var player_weapon_levels = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
# 
# RANDOMISED ITEMS ARRAY
# always 3 items
var player_recieving_item
var randomised_items = [-1,-1,-1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://Scenes/GeoffScenes/main_menu.tscn")

func add_xp(xp_added: int) -> void:
	experience += xp_added
	if experience >= experience_needed:
		player_recieving_item = total_level % number_players
		total_level += 1
		experience = 0
