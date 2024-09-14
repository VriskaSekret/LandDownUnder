extends Area2D

var level: int = 1
var damage: int = 5
var knockback: int = 50

func _ready():
	damage = 5 * level
	knockback = 50 * level
