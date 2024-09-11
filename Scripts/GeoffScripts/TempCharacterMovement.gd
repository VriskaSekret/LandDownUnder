extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var dir
var hp := 80
const SPEED = 200.0


# Enemy Related (temporary)
var enemy_close = []

func get_input():
	var input_direction = Input.get_vector("p1left", "p1right", "p1up", "p1down")
	dir = input_direction
	velocity = input_direction * SPEED

func _physics_process(delta):
	get_input()
	if dir[0] < 0:
		animated_sprite_2d.flip_h = true
	elif dir[0] > 0:
		animated_sprite_2d.flip_h = false
	move_and_slide()

# Enemy Detection shit 
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP
