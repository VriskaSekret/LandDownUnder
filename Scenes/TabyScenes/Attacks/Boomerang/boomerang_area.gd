extends Area2D

var level: int = 1
var damage: int = 10
var knockback_amount: int = 50
var angle = Vector2.UP

func _ready():
	damage = 10 * level
	knockback_amount = 2000 * level
	angle = Vector2.UP
