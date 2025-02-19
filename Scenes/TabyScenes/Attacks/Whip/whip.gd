extends Node2D

var level: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var whip_area: Area2D = $Sprite2D/WhipArea

var dir
var player
var last_x_dir

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.flip_h = last_x_dir < 0
	position.x = player.position.x + 100 * last_x_dir
	position.y = player.position.y
	whip_area.level = level
	dir = Vector2(player.last_dir.x, 0).normalized()
	sprite_2d.scale = Vector2(3 + 2 * level, 3 + 2 * level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += 50 * delta * dir

func _on_death_timeout() -> void:
	queue_free()
