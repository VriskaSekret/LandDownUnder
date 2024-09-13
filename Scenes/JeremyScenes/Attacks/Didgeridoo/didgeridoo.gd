extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("left_click"):
		print("shoot")
