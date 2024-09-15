extends Camera2D

var p1 : CharacterBody2D
var p2 : CharacterBody2D
var p3 : CharacterBody2D
var p4 : CharacterBody2D


# NOT WORKING CUS MAIN MENU HAS NO GAME MANAGER
#var root = get_parent()
#var game_manager = root.get_node("GameManager")

func _physics_process(_delta: float) -> void:
	pass
	#global_position = (p1.global_position + p2.global_position) / 2
	#get_viewport_rect()
