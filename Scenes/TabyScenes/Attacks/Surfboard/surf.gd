extends Node2D

@export var level: int = 1

@onready var surf_area: Area2D = $AnimatedSprite2D/SurfArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var initial_scale: int = 3
var level_scale: int = 2.5
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()
	surf_area.level = level
	animated_sprite_2d.scale = Vector2(initial_scale + (level_scale * (level-1)), initial_scale + (level_scale * (level-1)))

func level_up():
	level += 1
	animated_sprite_2d.scale = Vector2(initial_scale + (level_scale * (level-1)), initial_scale + (level_scale * (level-1)))
