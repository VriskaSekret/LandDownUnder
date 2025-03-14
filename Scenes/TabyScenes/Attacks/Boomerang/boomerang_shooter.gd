extends Node2D

var boomerang = preload("res://Scenes/TabyScenes/Attacks/Boomerang/Boomerang.tscn")
@export var level: int = 1
@onready var timer: Timer = $Timer
var cooldown: float = 5.0
var damage_multiplier
var player
func set_timer():
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()

func _ready() -> void:
	set_timer()

func _on_timer_timeout() -> void:
	set_timer()
	damage_multiplier = get_parent().damage_multiplier
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
	boomerang_instance.damage_multiplier = damage_multiplier
	var dir = get_parent().last_dir
	boomerang_instance.position = get_parent().position
	boomerang_instance.rotation = atan2(dir.y, dir.x)
	get_parent().get_parent().add_child(boomerang_instance)
