extends Label

func _physics_process(delta: float) -> void:
	text = "FPS: " + str(Engine.get_frames_per_second()) + "\nCurrent Enemies: " + str(get_tree().get_nodes_in_group("active_enemy").size())
