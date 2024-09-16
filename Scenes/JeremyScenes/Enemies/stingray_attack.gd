extends Node2D

@onready var shooting_point: Marker2D = $"../ShootingPoint"

@export var orbit_radius: float = 80.0
@export var orbit_speed: float = 5.0

var rng = RandomNumberGenerator.new()
var stingray_barb = preload("res://Scenes/JeremyScenes/Enemies/stingray_barb.tscn")
var shot = false
var start_angle: float = rng.randf_range(0.0, 2 * PI)
var angle = start_angle
var directions = []



func _physics_process(delta: float) -> void:
	pass

func shoot() -> void:
	var new_stingray_barb = stingray_barb.instantiate()
	new_stingray_barb.transform = shooting_point.global_transform
	get_parent().get_parent().get_parent().add_child(new_stingray_barb)

func _on_timer_timeout() -> void:
	shoot()
