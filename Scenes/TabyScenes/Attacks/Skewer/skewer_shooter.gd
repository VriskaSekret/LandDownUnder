extends Node2D

var level = 1
var skewer = preload("res://Scenes/TabyScenes/Attacks/Skewer/skewer.tscn")

func _ready():
	var skewer_instance = skewer.instantiate()
	new_skewer()

func level_up():
	level += 1
	new_skewer()

func new_skewer():
	var skewer_instance = skewer.instantiate()
	skewer_instance.player = get_parent()
	get_parent().get_parent().add_child(skewer_instance)
