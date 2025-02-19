extends Node2D

@export var level: int = 1
var skewer = preload("res://Scenes/TabyScenes/Attacks/Skewer/skewer.tscn")
var player
func _ready():
	for i in range(level):
		new_skewer()

func level_up():
	level += 1
	new_skewer()

func new_skewer():
	var skewer_instance = skewer.instantiate()
	skewer_instance.level = level
	skewer_instance.player = get_parent()
	skewer_instance.damage_multiplier = get_parent().damage_multiplier
	get_parent().get_parent().add_child(skewer_instance)
