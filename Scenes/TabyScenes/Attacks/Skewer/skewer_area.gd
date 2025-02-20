extends Area2D

@onready var skewer: Node2D = $".."

var level: int = 1
var damage: int = 200
var knockback_amount: int = 50

@onready var attack: Timer = $"../Attack"

func _ready():
	damage = 200 * level * skewer.damage_multiplier
	knockback_amount = 50 * level

func _on_move_timeout() -> void:
	monitorable = false
	monitoring = false
	skewer.animated_sprite_2d.animation = "default"

func _on_attack_timeout() -> void:
	monitoring = true
	monitorable = true
	skewer.animated_sprite_2d.animation = "attack"
