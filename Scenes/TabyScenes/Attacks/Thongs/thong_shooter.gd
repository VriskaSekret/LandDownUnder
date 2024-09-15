extends Node2D

var thong = preload("res://Scenes/TabyScenes/Attacks/Thongs/thong.tscn")

@export var level: int = 1
@export var orbit_radius: float = 70.0

func _on_timer_timeout() -> void:
	for i in range(level):
		new_thong((2*PI/level) * i)

func level_up():
	print("thong up!")
	level += 1

func new_thong(offset):
	var thong_instance = thong.instantiate()
	thong_instance.level = level
	thong_instance.position.x = orbit_radius * cos(offset)
	thong_instance.position.y = orbit_radius * sin(offset)
	thong_instance.offset = offset
	add_child(thong_instance)
