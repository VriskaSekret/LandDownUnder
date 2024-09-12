extends Sprite2D

@onready var snd_explosion: AudioStreamPlayer2D = $Sound
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("explosion")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
