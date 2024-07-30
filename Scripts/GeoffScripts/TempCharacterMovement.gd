extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var dir
const SPEED = 600.0

func get_input():
	var input_direction = Input.get_vector("p1left", "p1right", "p1up", "p1down")
	dir = input_direction
	print (dir)
	velocity = input_direction * SPEED

func _physics_process(delta):
	get_input()
	if dir[0] < 0:
		animated_sprite_2d.flip_h = true
	elif dir[0] > 0:
		animated_sprite_2d.flip_h = false
	move_and_slide()
