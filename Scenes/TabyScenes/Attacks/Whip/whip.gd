extends Node2D

var level: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var whip_area: Area2D = $Sprite2D/WhipArea

var dir
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.flip_h = player.last_dir.x < 0
	sprite_2d.flip_v = player.last_dir.y < 0
	position = player.position + 100 * player.last_dir
	whip_area.level = level
	dir = player.last_dir
	sprite_2d.scale = Vector2(1.5 + 2 * level, 1.5 + 2 * level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += 50 * delta * dir

func _on_death_timeout() -> void:
	queue_free()
