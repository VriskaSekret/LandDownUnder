extends Area2D

var level: int = 1
var damage: int = 5
var knockback: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 5 * level
