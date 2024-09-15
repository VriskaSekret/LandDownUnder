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

var player_type

# Enemy Related (temporary)
var enemy_close = []

func _ready():
	player_type = Global.player_characters[character_player_number-1]
	Global.player_weapons[character_player_number-1] = [player_type, -1, -1]
	Global.player_weapon_levels[character_player_number-1] = [1,-1,-1]
	print("Player " + str(character_player_number))
	print("Weapons " + str(Global.player_weapons[character_player_number-1]))
	print("Weapon Levels " + str(Global.player_weapon_levels[character_player_number-1]))


func get_input() -> void:
	if not has_assigned_keys:
		left_button = "p%dleft" % character_player_number
		right_button = "p%dright" % character_player_number
		up_button = "p%dup" % character_player_number
		down_button = "p%ddown" % character_player_number
	var input_direction = Input.get_vector(left_button, right_button, up_button, down_button)
	dir = input_direction.normalized()
	velocity = input_direction * movement_speed

func _physics_process(_delta) -> void:
	if !Global.game_paused:
		get_input()
		if dir[0] < 0:
			anim_spr.flip_h = true
		elif dir[0] > 0:
			anim_spr.flip_h = false
		move_and_slide()


func _process(_delta) -> void:
	# Animation shit, doesn't relate to physics
	if !Global.game_paused:
		if velocity:
			anim_spr.play("walk")
		else:
			anim_spr.play("idle")
	


func _on_hurtbox_hurt(damage, _angle, _knockback) -> void:
	hp -= damage
	print(hp)
