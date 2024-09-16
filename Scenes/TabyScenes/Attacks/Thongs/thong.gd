extends Node2D

@export var orbit_radius: float = 70.0
@export var orbit_speed: float = 3.0 # Speed of orbit in radians per second

var level: int = 1
@onready var thong_aoe: Area2D = $ThongAOE

var angle: float = 0.0
var offset: float = 0.0

func _ready() -> void:
	thong_aoe.level = level

func _process(delta: float) -> void:
	# Update the angle based on the orbit speed
	angle += orbit_speed * delta
	
	# Calculate the new position relative to the parent
	position.x = orbit_radius * cos(angle + offset)
	position.y = orbit_radius * sin(angle + offset)


func _on_death_timeout() -> void:
	queue_free()
