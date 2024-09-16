extends Area2D

var level: int = 1
var damage: int = 5
var knockback_amount: int = 50

@onready var attack: Timer = $"../Attack"

func _ready():
	damage = 5 * level
	knockback_amount = 50 * level

func _on_move_timeout() -> void:
	monitorable = false
	monitoring = false

func _on_attack_timeout() -> void:
	monitoring = true
	monitorable = true
