extends Node2D

var boomerang = preload("res://Scenes/TabyScenes/Attacks/Boomerang/Boomerang.tscn")
@export var level: int = 1
@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	new_boomerang()

func level_up():
	print("boomer up!")
	level += 1

func new_boomerang():
	var boomerang_instance = boomerang.instantiate()
	boomerang_instance.level = level
	boomerang_instance.player = get_parent()
	var dir = get_parent().last_dir
	boomerang_instance.position = get_parent().position
	boomerang_instance.rotation = atan2(dir.y, dir.x)
	get_parent().get_parent().add_child(boomerang_instance)
