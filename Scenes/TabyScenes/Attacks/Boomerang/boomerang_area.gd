extends Area2D

var level: int = 1
var damage: int = 10
var knockback: int = 50

func _ready():
	damage = 10 * level
	knockback = 2000 * level
