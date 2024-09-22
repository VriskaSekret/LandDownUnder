extends Area2D
@onready var thong: Node2D = $".."

var level: int = 1
var damage: int = 10
var knockback_amount: int = 100

func _ready():
	damage = 10 * level * thong.player.damage_multiplier
	knockback_amount = 100 * level * thong.player.damage_multiplier
