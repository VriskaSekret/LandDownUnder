extends CharacterBody2D
@onready var game_manager: Node2D = $"../../GameManager"

@export var target = null
var speed = 350

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if target != null:
		velocity = position.direction_to(target.position) * speed
		move_and_slide()

func _on_magnetism_range_body_entered(body: Node2D) -> void:
	target = body
	#print("someones here!")


func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.add_xp(1)
	CoinSound.play()
	game_manager.check_level()
	queue_free()
