extends Node2D

@export var level: int = 1

var cone = preload("res://Scenes/TabyScenes/Attacks/Cone/cone.tscn")

func level_up():
	level += 1

func _on_timer_timeout() -> void:
	new_cone()

func new_cone():
	var cone_instance = cone.instantiate()
	cone_instance.level = level
	get_parent().get_parent().add_child(cone_instance)
