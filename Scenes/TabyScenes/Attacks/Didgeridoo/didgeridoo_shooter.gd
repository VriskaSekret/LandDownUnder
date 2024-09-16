extends Node2D

@export var level: int = 1
var cooldown: float = 5.0

var didgeridoo = preload("res://Scenes/TabyScenes/Attacks/Didgeridoo/didgeridoo.tscn")
@onready var timer: Timer = $Timer

func set_timer():
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()

func _ready() -> void:
	set_timer()

func level_up():
	level += 1

func _on_timer_timeout() -> void:
	set_timer()
	new_didgeridoo()

func new_didgeridoo():
	var did_instance = didgeridoo.instantiate()
	did_instance.level = level
	add_child(did_instance)
