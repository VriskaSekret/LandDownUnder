extends Node2D

var thong = preload("res://Scenes/TabyScenes/Attacks/Thongs/thong.tscn")

func _on_timer_timeout() -> void:
	var thong_instance = thong.instantiate()
	add_child(thong_instance)
