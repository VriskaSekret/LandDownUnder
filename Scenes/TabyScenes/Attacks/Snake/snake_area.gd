extends Area2D
@onready var snake: RigidBody2D = $"../.."

var level: int = 1
var damage: int = 5
var knockback_amount: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = 20 * level * snake.player.damage_multiplier
