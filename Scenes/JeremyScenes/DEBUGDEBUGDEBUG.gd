extends Label

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		visible = not visible
	text = "FPS: " + str(Engine.get_frames_per_second()) + "\nCurrent Enemies: " + str(get_tree().get_nodes_in_group("active_enemy").size())
