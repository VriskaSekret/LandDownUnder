extends Area2D

var level: int = 1
var damage: int = 50
var knockback: int = 200

func _ready() -> void:
	damage = 50 * level
	knockback = 200 * level
