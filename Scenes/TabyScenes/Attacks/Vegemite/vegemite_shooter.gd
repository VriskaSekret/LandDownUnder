extends Node2D

@export var level: int = 1
var cooldown: float = 3.0
@onready var timer: Timer = $Timer
var rng = RandomNumberGenerator.new()
var vegemite = preload("res://Scenes/TabyScenes/Attacks/Vegemite/vegemite.tscn")
@onready var player = get_parent()

func set_timer():
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()

func _ready() -> void:
	set_timer()
	
func _on_timer_timeout() -> void:
	set_timer()
	for i in range(level):
		new_vegemite()

func level_up():
	level += 1

func new_vegemite():
	var x = player.position.x + rng.randi_range(-100, 100)
	var y = player.position.y + rng.randi_range(0, -100)
	var vegemite_instance = vegemite.instantiate()
	vegemite_instance.level = level
	vegemite_instance.position = Vector2(x, y)
	get_parent().get_parent().add_child(vegemite_instance)
