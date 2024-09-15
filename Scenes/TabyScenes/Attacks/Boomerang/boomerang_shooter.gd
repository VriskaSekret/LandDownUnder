extends Node2D

var boomerang = preload("res://Scenes/TabyScenes/Attacks/Boomerang/Boomerang.tscn")
@export var level: int = 1
@onready var timer: Timer = $Timer
var cooldown: float = 5.0

func set_timer():
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()

func _ready() -> void:
	set_timer()

func _on_timer_timeout() -> void:
	set_timer()
	new_boomerang()

func level_up():
	level += 1
	timer.stop()
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()

func new_boomerang():
	var boomerang_instance = boomerang.instantiate()
	boomerang_instance.level = level
	boomerang_instance.player = get_parent()
	var dir = get_parent().last_dir
	boomerang_instance.position = get_parent().position
	boomerang_instance.rotation = atan2(dir.y, dir.x)
	get_parent().get_parent().add_child(boomerang_instance)
