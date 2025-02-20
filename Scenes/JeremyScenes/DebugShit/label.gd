extends Label

func _process(delta: float) -> void:
	text = "FPS: " + str(Engine.get_frames_per_second()) + "\nCurrent Kanga Weak: " + str(get_tree().get_nodes_in_group("kanga_weak").size()) + "\nCurrent Kanga Strong: " + str(get_tree().get_nodes_in_group("kanga_strong").size()) + "\nCurrent Emu Weak: " + str(get_tree().get_nodes_in_group("emu_weak").size()) + "\nCurrent Emu Strong: " + str(get_tree().get_nodes_in_group("emu_strong").size()) + "\nCurrent Enemies: " + str(get_tree().get_nodes_in_group("enemy").size())
