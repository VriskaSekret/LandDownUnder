extends Area2D
@onready var vegemite: RigidBody2D = $"../.."

var level: int = 5
var damage: int = 10
var knockback_amount: int = 5

func _ready():
	damage = 5 * level * vegemite.player.damage_multiplier
	knockback_amount = 2 * level * vegemite.player.damage_multiplier
