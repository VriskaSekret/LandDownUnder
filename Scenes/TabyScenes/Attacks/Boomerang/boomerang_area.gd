extends Area2D
@onready var boomerang: RigidBody2D = $"../.."

var level: int = 1
var damage: int = 10
var knockback_amount: int = 50

func _ready() -> void:
	damage = 5 * level * boomerang.damage_multiplier
	knockback_amount = 2000 * level
