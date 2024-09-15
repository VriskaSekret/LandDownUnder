extends Node2D

@export var level: int = 1

var whip = preload("res://Scenes/TabyScenes/Attacks/Whip/whip.tscn")

func level_up():
	level += 1

func new_whip():
	print("smack")
	var whip_instance = whip.instantiate()
	whip_instance.level = level
	whip_instance.player = get_parent()
	get_parent().get_parent().add_child(whip_instance)

func _on_timer_timeout() -> void:
	new_whip()
