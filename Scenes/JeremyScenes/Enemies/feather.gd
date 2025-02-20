extends Area2D

@export var damage := 1
@export var speed = 200.0

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disable_timer: Timer = $DisableHitboxTimer

@onready var player = get_tree().get_first_node_in_group("Player")
var direction

func temp_disable():
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()


func _on_disable_hitbox_timer_timeout():
	collision.call_deferred("set", "disabled", false)


func _ready() -> void:
	var player_pos = player.global_position
	direction = global_position.direction_to(player_pos)
	look_at(player_pos)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_timer_timeout() -> void:
	queue_free()
