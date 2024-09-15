extends Node2D

@export var level: int = 1

var didgeridoo = preload("res://Scenes/TabyScenes/Attacks/Didgeridoo/didgeridoo.tscn")

func level_up():
	print("didger up!")
	level += 1

func _on_timer_timeout() -> void:
	new_didgeridoo()

func new_didgeridoo():
	var did_instance = didgeridoo.instantiate()
	did_instance.level = level
	add_child(did_instance)
