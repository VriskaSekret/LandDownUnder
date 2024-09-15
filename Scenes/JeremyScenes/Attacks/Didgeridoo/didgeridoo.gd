extends Node2D

var level: int = 1

@onready var sprite_2d: Sprite2D = $PivotPoint/Sprite2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var music_note = preload("res://Scenes/TabyScenes/Attacks/Didgeridoo/MusicNote/music_note.tscn")
@onready var shooting_point: Marker2D = $PivotPoint/Sprite2D/ShootingPoint

@export var orbit_radius: float = 80.0
@export var orbit_speed: float = 5.0

@onready var post: Timer = $Post

var rng = RandomNumberGenerator.new()
var start_angle: float = rng.randf_range(0.0, 2 * PI)
var angle = start_angle
var shot = false
var shrink = false

func _ready():
	rotation = angle
	sprite_2d.position.x = orbit_radius

func _physics_process(delta: float) -> void:
	angle += orbit_speed * delta
	orbit_speed -= 2 * delta
	if not shot:
		rotation = angle
	else:
		if sprite_2d.scale.x < 2 and not shrink:
			sprite_2d.scale += Vector2(10 * delta, 10 * delta)
		else:
			shrink = true
			if sprite_2d.scale.x > 1:
				sprite_2d.scale -= Vector2(10 * delta, 10 * delta) 
	if angle - start_angle >= 2 * PI:
		shoot()

func shoot() -> void:
	var angles = [-0.08, 0.08, -0.2, 0.2, -0.4, 0.4]
	if not shot:
		shot = true
		for i in range(min(level * 2, 6)):
			var new_note = music_note.instantiate()
			new_note.level = level
			new_note.transform = shooting_point.global_transform
			new_note.rotation += angles[i]
			get_parent().get_parent().get_parent().add_child(new_note)

func _on_post_timeout() -> void:
	print("bye?")
	queue_free()
