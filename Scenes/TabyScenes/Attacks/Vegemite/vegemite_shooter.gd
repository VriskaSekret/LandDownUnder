extends Node2D

@export var level: int = 1
var rng = RandomNumberGenerator.new()
var vegemite = preload("res://Scenes/TabyScenes/Attacks/Vegemite/vegemite.tscn")
@onready var player = get_parent()

func _on_timer_timeout() -> void:
	for i in range(level):
		new_vegemite()

func level_up():
	level += 1

func new_vegemite():
	var x = player.position.x + rng.randi_range(-200, 200)
	var y = player.position.y + rng.randi_range(-20, -200)
	var vegemite_instance = vegemite.instantiate()
	vegemite_instance.level = level
	vegemite_instance.position = Vector2(x, y)
	get_parent().get_parent().add_child(vegemite_instance)
