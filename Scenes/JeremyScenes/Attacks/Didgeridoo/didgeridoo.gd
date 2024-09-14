extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var music_note = preload("res://Scenes/JeremyScenes/Attacks/Didgeridoo/MusicNote/music_note.tscn")
@onready var shooting_point: Marker2D = $PivotPoint/Sprite2D/ShootingPoint


func _physics_process(delta: float) -> void:
	look_at(player.get_closest_target())

func shoot() -> void:
	var new_note = music_note.instantiate()
	new_note.transform = shooting_point.global_transform
	get_parent().get_parent().add_child(new_note)


func _on_shoot_timer_timeout() -> void:
	shoot()
