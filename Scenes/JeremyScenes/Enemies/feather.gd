extends Area2D

var player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	global_position += player.global_position
