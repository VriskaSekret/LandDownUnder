extends Area2D

var level: int = 1
var damage: int = 10
var knockback: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 10 * level
	knockback = 200 + 50 * level
