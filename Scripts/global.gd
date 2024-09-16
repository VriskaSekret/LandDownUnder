extends Node

var number_players = -1

var game_paused = false
var experience = 0
var score: int = 0
var total_level = 1
var experience_needed = 10.0 * (total_level * 1.2)
var time_seconds = 0


# player_characters [player1, player2, player3, player4]
# FOR FINDING WHAT CHARACTER EACH PLAYER IS USING
# -1 MEANS NO SELECTION
var player_characters = [-1,-1,-1,-1]
var player_weapons = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
var player_weapon_levels = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
var players_alive = [false, false, false, false]
# 
# RANDOMISED ITEMS ARRAY
# always 3 items
var player_recieving_item: int = -1
var randomised_items = [-1,-1,-1]

func reset_global_variables():
	Engine.time_scale = 1
	number_players = -1
	game_paused = false
	experience = 0
	score = 0
	total_level = 1
	experience_needed = 10.0 * (total_level * 1.2)
	time_seconds = 0
	player_characters = [-1,-1,-1,-1]
	player_weapons = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
	player_weapon_levels = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]
	players_alive = [false, false, false, false]
	player_recieving_item = -1
	randomised_items = [-1,-1,-1]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://Scenes/GeoffScenes/main_menu.tscn")

func add_xp(xp_added: int) -> void:
	experience += xp_added
	score += xp_added
	if experience >= experience_needed:
		#player_recieving_item = (total_level -1 )% number_players
		update_recieving_player()
		total_level += 1
		experience = 0

func update_recieving_player():
	var next_player = (player_recieving_item + 1) % 4
	while not players_alive[next_player]:
		next_player = (next_player + 1) % 4
	player_recieving_item = next_player
