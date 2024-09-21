extends Area2D
@onready var cone: RigidBody2D = $"../.."

var level: int = 1
var damage: int = 50
var knockback_amount: int = 200

func _ready() -> void:
	damage = 20 * level * cone.damage_multiplier
	knockback_amount = 200 * level
