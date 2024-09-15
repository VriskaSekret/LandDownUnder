extends RigidBody2D

var level: int = 1

@onready var snake_area: Area2D = $AnimatedSprite2D/SnakeArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snake_area.level = level
	apply_impulse(Vector2(0, -500).rotated(rotation))

func _physics_process(delta: float) -> void:
	rotation = linear_velocity.angle() + (PI/2)

func _on_death_timeout() -> void:
	queue_free()
