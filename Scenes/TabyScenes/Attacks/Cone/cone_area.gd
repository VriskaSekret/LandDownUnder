extends Area2D

var level: int = 1
var damage: int = 20
var knockback_amount: int = 200
var angle = Vector2.UP

func _ready() -> void:
	damage = 20 * level
	knockback_amount = 200 * level
	angle = Vector2.UP
