extends Area2D


@onready var timer: Timer = $Timer

var bd_entered = false
var feather = preload("res://Scenes/JeremyScenes/Enemies/feather.tscn")

func _physics_process(delta: float) -> void:
	if bd_entered and timer.is_stopped():
		var new_feather = feather.instantiate()
		get_parent().add_child(new_feather)
		timer.start()
		bd_entered = false

func _on_body_entered(body: Node2D) -> void:
	print("body entered")
	bd_entered = true


func _on_timer_timeout() -> void:
	pass
