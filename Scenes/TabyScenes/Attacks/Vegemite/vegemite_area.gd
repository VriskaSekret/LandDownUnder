extends Area2D

var level: int = 5
var damage: int = 10
var knockback: int = 5

func _ready():
	damage = 5 * level
	knockback = 5 * level
