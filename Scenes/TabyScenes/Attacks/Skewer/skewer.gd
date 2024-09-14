extends Node2D

var player
@export var circle_radius: float = 50.0
@export var move_time: float = 1.0 # Time to move to the new point on the circle
@export var wait_time: float = 3.0 # Time between each movement

var level: int = 1
@onready var skewer_area: Area2D = $SkewerArea

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var move: Timer = $Move

var timer: Timer

# Connect the signal directly in the _ready() function
func _ready() -> void:
	move.wait_time = move_time
	animated_sprite_2d.animation = "default"
	skewer_area.level = level
	
	# Set up Timer
	timer = Timer.new()
	timer.wait_time = wait_time
	timer.one_shot = false
	
	timer.timeout.connect(_on_timer_timeout)
	
	add_child(timer)
	timer.start()

func _on_timer_timeout() -> void:
	animated_sprite_2d.animation = "attack"
	rotation = get_angle_to(player.position)
	var random_angle = randf() * 2.0 * PI
	
	var new_position = player.position + Vector2(
		circle_radius * cos(random_angle),
		circle_radius * sin(random_angle)
	)
	
	# Create a Tween node in the scene tree to handle movement
	var tween = create_tween()
	
	# Use Tween to move the node smoothly to the new position
	tween.tween_property(self, "position", new_position, move_time)
	move.start()


func _on_move_timeout() -> void:
	animated_sprite_2d.animation = "default"
