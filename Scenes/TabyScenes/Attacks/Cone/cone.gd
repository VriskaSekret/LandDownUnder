extends RigidBody2D

var level: int = 1
var player
var damage_multiplier

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cone_area: Area2D = $Sprite2D/ConeArea
var dir: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cone_area.level = level
	sprite_2d.scale = Vector2(1 + 1.5 * level, 1 + 1.5 * level)
	if player.last_dir.x < 0:
		dir = -1
	apply_impulse(Vector2(100 * dir, -700))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_force(Vector2(0, 1000))
	rotation += 3.5 * delta

func _on_death_timeout() -> void:
	queue_free()
