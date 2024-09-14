extends Node

var number_players = -1

var game_paused = false
var experience = 0
var total_level = 1
var experience_needed = 10.0 * (total_level * 1.2)

var player1_character = -1
var player2_character = -1
var player3_character = -1
var player4_character = -1



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
		total_level += 1
		experience = 0
