extends Node2D

@export var level: int = 1
@onready var timer: Timer = $Timer
var cooldown: float = 5.0
var damage_multiplier

var cone = preload("res://Scenes/TabyScenes/Attacks/Cone/cone.tscn")

func set_timer():
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()
	
func _ready() -> void:
	set_timer()

func level_up():
	level += 1

func _on_timer_timeout() -> void:
	set_timer()
	damage_multiplier = get_parent().damage_multiplier
	new_cone()

func new_cone():
	var cone_instance = cone.instantiate()
	cone_instance.level = level
	cone_instance.damage_multiplier = damage_multiplier
	cone_instance.player = get_parent()
	get_parent().get_parent().add_child(cone_instance)
	cone_instance.position = get_parent().position
