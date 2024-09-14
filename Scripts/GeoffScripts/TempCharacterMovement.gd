extends CharacterBody2D

@onready var anim_spr: AnimatedSprite2D = $AnimatedSprite2D

var hp := 80

var character_player_number
var dir
var has_assigned_keys = false
var movement_speed := 100.0
var left_button
var right_button
var up_button
var down_button
# skewer
var skewer = preload("res://Scenes/JeremyScenes/Attacks/Skewer/skewer.tscn")
@onready var skewer_base: Node2D = %SkewerBase
var skewer_ammo := 3
var skewer_level := 0

# Enemy Related (temporary)
var enemy_close = []

func _ready():
	attack()


func get_input() -> void:
	if not has_assigned_keys:
		left_button = "p%dleft" % character_player_number
		right_button = "p%dright" % character_player_number
		up_button = "p%dup" % character_player_number
		down_button = "p%ddown" % character_player_number
	var input_direction = Input.get_vector(left_button, right_button, up_button, down_button)
	dir = input_direction.normalized()
	velocity = input_direction * movement_speed

func _physics_process(delta) -> void:
	if !Global.game_paused:
		get_input()
		if dir[0] < 0:
			anim_spr.flip_h = true
		elif dir[0] > 0:
			anim_spr.flip_h = false
		move_and_slide()


func _process(delta) -> void:
	# Animation shit, doesn't relate to physics
	if !Global.game_paused:
		if velocity:
			anim_spr.play("walk")
		else:
			anim_spr.play("idle")
	


func _on_hurtbox_hurt(damage, _angle, _knockback) -> void:
	hp -= damage
	print(hp)

func attack() -> void:
	if skewer_level > 0:
		spawn_skewer()

func spawn_skewer() -> void:
	var get_skewer_total = skewer_base.get_child_count()
	var calc_spawns = skewer_ammo - get_skewer_total
	while calc_spawns > 0:
		var skewer_spawn = skewer.instantiate()
		skewer_spawn.global_position = global_position
		skewer_base.add_child(skewer_spawn)
		calc_spawns -= 1

# Enemy Detection shit 
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func get_closest_target():
	if enemy_close.size() > 0:
		var target = enemy_close.front()
		return target
	else:
		return Vector2.UP

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
