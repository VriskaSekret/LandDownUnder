extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.animation = "default"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
