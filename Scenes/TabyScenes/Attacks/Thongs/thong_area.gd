extends Area2D

var level: int = 1
var damage: int = 10
var knockback_amount: int = 100

func _ready():
	damage = 10 * level
	knockback_amount = 100 * level
