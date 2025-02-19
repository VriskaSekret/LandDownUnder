extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")

var level: int = 1
var speed: float = 100.0
var damage: int = 25
var knockback: int = 200
var hp: int = 2

var angle = Vector2.ZERO

func _ready():
	damage = 100 * level
	speed = 100 + 20 * level
	knockback = 200 + 50 * level

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_queue_free_timer_timeout() -> void:
	queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()
