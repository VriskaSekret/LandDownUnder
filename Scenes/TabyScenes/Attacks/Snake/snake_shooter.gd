extends Node2D

@export var level: int = 1

var snake = preload("res://Scenes/TabyScenes/Attacks/Snake/snake.tscn")
var rng = RandomNumberGenerator.new()

func _on_timer_timeout() -> void:
	new_snake()

func new_snake():
	var snake_instance = snake.instantiate()
	snake_instance.level = level
	snake_instance.rotation = rng.randf_range(0, 2*PI)
	get_parent().get_parent().add_child(snake_instance)

func level_up():
	level += 1
