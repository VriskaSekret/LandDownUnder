extends Area2D

@export var damage := 1

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disable_timer: Timer = $DisableHitboxTimer

@onready var player = get_tree().get_first_node_in_group("Player")
var speed = 200.0
var direction

func temp_disable():
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()


func _on_disable_hitbox_timer_timeout():
	collision.call_deferred("set", "disabled", false)


func _ready() -> void:
	direction = global_position.direction_to(player.global_position)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_timer_timeout() -> void:
	queue_free()
