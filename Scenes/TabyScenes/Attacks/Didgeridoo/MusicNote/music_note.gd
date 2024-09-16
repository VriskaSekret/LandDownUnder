extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")

var speed = 100.0
var damage = 10
var hp = 2


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_queue_free_timer_timeout() -> void:
	queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()
