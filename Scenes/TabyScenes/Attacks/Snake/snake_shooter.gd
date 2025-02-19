extends Node2D

@export var level: int = 1
var cooldown: float = 4.0

var snake = preload("res://Scenes/TabyScenes/Attacks/Snake/snake.tscn")
@onready var timer: Timer = $Timer
var rng = RandomNumberGenerator.new()
var player

func set_timer():
	timer.wait_time = cooldown * get_parent().attack_speed
	timer.start()

func _ready():
	set_timer()

func _on_timer_timeout() -> void:
	set_timer()
	new_snake()

func new_snake():
	var snake_instance = snake.instantiate()
	snake_instance.level = level
	snake_instance.rotation = rng.randf_range(0, 2*PI)
	snake_instance.player = player
	get_parent().get_parent().add_child(snake_instance)

func level_up():
	level += 1
