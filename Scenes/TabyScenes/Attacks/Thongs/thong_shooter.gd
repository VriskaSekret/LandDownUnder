extends Node2D

var thong = preload("res://Scenes/TabyScenes/Attacks/Thongs/thong.tscn")

var level: int = 1
var orbit_speed: float = 3.0

func _on_timer_timeout() -> void:
	for i in range(min(level, 4)):
		new_thong()
		await get_tree().create_timer((2*PI)/min(level, 4) * orbit_speed)

func level_up():
	print("thong up!")
	level += 1

func new_thong():
	var thong_instance = thong.instantiate()
	thong_instance.level = level
	orbit_speed = thong_instance.orbit_speed
	add_child(thong_instance)
