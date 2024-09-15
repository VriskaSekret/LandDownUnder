extends RigidBody2D

var level: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cone_area: Area2D = $Sprite2D/ConeArea
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.scale = Vector2(0.5 + 0.5 * level, 0.5 + 0.5 * level)
	cone_area.level = level
	apply_impulse(Vector2(100 * [1, -1][randi() % 2], -700))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_force(Vector2(0, 1000))
	rotation += 3.5 * delta

func _on_death_timeout() -> void:
	queue_free()
