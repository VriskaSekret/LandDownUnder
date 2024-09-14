extends CharacterBody2D

@export var speed := 40.0
@export var hp := 10
@export var knockback_recovery := 3.5
var knockback := Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("Player")

@onready var sprite: Sprite2D = $Sprite2D
@onready var snd_hit: AudioStreamPlayer2D = $"Sound Hit"

var death_anim = preload("res://Scenes/JeremyScenes/Enemies/Explosion/explosion.tscn")
var coin_drop = preload("res://Scenes/GeoffScenes/coin.tscn")

signal remove_from_arr(obj)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	
	# MOVEMENT
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	velocity += knockback
	move_and_slide()
	
	if (player.position.x - position.x) < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_hurtbox_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()

func death():
	emit_signal("remove_from_arr", self)
	var coin = coin_drop.instantiate()
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale
	coin.scale = sprite.scale
	enemy_death.global_position = global_position
	coin.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	get_parent().call_deferred("add_child", coin)
	queue_free()
