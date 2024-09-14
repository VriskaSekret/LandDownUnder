extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var fall_timer: Timer = $FallTimer
@onready var aoe_timer: Timer = $AOETimer
@onready var vegemite_aoe: Area2D = $VegemiteAOE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.animation = "default"
	fall_timer.start()
	vegemite_aoe.monitorable = false
	vegemite_aoe.monitoring = false

func _on_aoe_timer_timeout() -> void:
	queue_free()

func _on_fall_timer_timeout() -> void:
	animated_sprite.animation = "burst"
	gravity_scale = 0
	linear_velocity = Vector2(0, 0)
	aoe_timer.start()
	vegemite_aoe.monitorable = true
	vegemite_aoe.monitoring = true
