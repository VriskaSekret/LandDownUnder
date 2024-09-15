extends Node2D

var feather = preload("res://Scenes/JeremyScenes/Enemies/feather.tscn")

func shoot() -> void:
	var new_feather = feather.instantiate()
	new_feather.global_position = get_parent().global_position
	get_parent().get_parent().add_child(new_feather)

func _on_timer_timeout() -> void:
	shoot()
