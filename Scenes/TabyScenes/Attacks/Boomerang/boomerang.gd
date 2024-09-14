extends RigidBody2D

var rng = RandomNumberGenerator.new()
var projectile_speed = 400
var direction = [1, -1][rng.randi_range(0, 1)]
var arc_speed = 100 * direction
var switched = 0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	apply_impulse(Vector2(projectile_speed, arc_speed).rotated(rotation))

func _physics_process(delta: float) -> void:
	sprite_2d.rotate(10 * delta)
	apply_impulse(-1 * Vector2(projectile_speed/20, switched * arc_speed/5).rotated(rotation))

func _on_switch_timer_timeout() -> void:
	switched = 1
