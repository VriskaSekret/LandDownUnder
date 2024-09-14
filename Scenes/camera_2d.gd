extends Camera2D

@export var p1 : CharacterBody2D
@export var p2 : CharacterBody2D

func _physics_process(delta: float) -> void:
	global_position = (p1.global_position + p2.global_position) / 2
	get_viewport_rect()
