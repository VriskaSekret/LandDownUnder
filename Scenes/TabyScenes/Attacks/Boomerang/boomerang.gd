extends RigidBody2D

var rng = RandomNumberGenerator.new()
var projectile_speed: int = 400
var direction: int = [1, -1][rng.randi_range(0, 1)]
var arc_speed: int = -100 * direction
var phase :int = 0
var damage: int = 20
var knockback: int = 100
var player
var normal_dir
var tan_dir
var initial_v

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var switch_timer: Timer = $SwitchTimer
@onready var reverse_timer: Timer = $ReverseTimer

func _ready():
	initial_v = Vector2(projectile_speed, 0).rotated(rotation)
	apply_impulse(Vector2(projectile_speed, 0).rotated(rotation))

func _physics_process(delta: float) -> void:
	sprite_2d.rotate(10 * delta)
	if(phase > 0):
		apply_force(-1.5 * initial_v)
	if(phase == 2):
		apply_force(5 * tan_dir * arc_speed)

func _on_switch_timer_timeout() -> void:
	phase = 1
	print(phase)
	normal_dir = (player.position - position).normalized()
	tan_dir = normal_dir.orthogonal()
	apply_impulse(-tan_dir * arc_speed)

func _on_death_timeout() -> void:
	print("die")
	queue_free()

func _on_reverse_timer_timeout() -> void:
	phase = 2
	print(phase)
