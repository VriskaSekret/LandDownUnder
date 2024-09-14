extends Area2D
@onready var game_manager: Node2D = $"../../GameManager"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	Global.add_xp(1)
	game_manager.check_level()
	queue_free()
