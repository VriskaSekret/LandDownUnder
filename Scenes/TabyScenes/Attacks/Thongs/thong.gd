extends Node2D

@export var orbit_radius: float = 50.0
@export var orbit_speed: float = 3.0 # Speed of orbit in radians per second

var angle: float = 0.0

func _process(delta: float) -> void:
	# Update the angle based on the orbit speed
	angle += orbit_speed * delta
	
	# Calculate the new position relative to the parent
	position.x = orbit_radius * cos(angle)
	position.y = orbit_radius * sin(angle)


func _on_death_timeout() -> void:
	queue_free()
