extends Area2D

var level: int = 1
var damage: int = 10
var knockback: int = 100

func _ready():
	damage = 10 * level
	knockback = 100 * level
