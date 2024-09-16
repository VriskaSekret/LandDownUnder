extends Area2D

var level: int = 1
var damage: int = 50
var knockback_amount: int = 200

func _ready() -> void:
	damage = 20 * level
	knockback_amount = 200 * level
