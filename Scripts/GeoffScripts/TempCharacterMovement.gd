extends CharacterBody2D

@onready var anim_spr: AnimatedSprite2D = $AnimatedSprite2D

var hp := 80

var character_player_number
var dir
var last_dir = Vector2(1, 1)
var has_assigned_keys = false
var movement_speed := 100.0
var left_button
var right_button
var up_button
var down_button

var player_type

var weapons = [-1, -1, -1]
var wlevels = [-1, -1, -1]
var weapon_nodes = []

# Enemy Related (temporary)
var enemy_close = []

# Weapons
var boomerang = preload("res://Scenes/TabyScenes/Attacks/Boomerang/boomerang_shooter.tscn")
var didgeridoo = preload("res://Scenes/TabyScenes/Attacks/Didgeridoo/didgeridoo_shooter.tscn")
var skewer = preload("res://Scenes/TabyScenes/Attacks/Skewer/skewer_shooter.tscn")
var thongs = preload("res://Scenes/TabyScenes/Attacks/Thongs/thong.tscn")
var vegemite = preload("res://Scenes/TabyScenes/Attacks/Vegemite/vegemite_shooter.tscn")

func _ready():
	print("hi im " + get_char_name())
	player_type = Global.player_characters[character_player_number-1]
	Global.player_weapons[character_player_number-1] = [player_type, -1, -1]
	Global.player_weapon_levels[character_player_number-1] = [1,-1,-1]
	print("Player " + str(character_player_number))
	print("Weapons " + str(Global.player_weapons[character_player_number-1]))
	print("Weapon Levels " + str(Global.player_weapon_levels[character_player_number-1]))
	add_weapons()


func get_input() -> void:
	if not has_assigned_keys:
		left_button = "p%dleft" % character_player_number
		right_button = "p%dright" % character_player_number
		up_button = "p%dup" % character_player_number
		down_button = "p%ddown" % character_player_number
	var input_direction = Input.get_vector(left_button, right_button, up_button, down_button)
	dir = input_direction.normalized()
	if (dir != Vector2(0, 0)):
		last_dir = dir
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
		if velocity != Vector2(0, 0):
			anim_spr.play(get_char_name() + "_walk")
		else:
			anim_spr.play(get_char_name() + "_idle")

func get_char_name() -> String:
	var char_index: int = Global.player_characters[character_player_number - 1]
	if char_index == 0:
		return "tradie"
	elif char_index == 1:
		return "raygun"
	elif char_index == 2:
		return "abo"
	else:
		return "bush"


func _on_hurtbox_hurt(damage, _angle, _knockback) -> void:
	hp -= damage
	print(hp)

func add_weapons():
	for i in range(len(Global.player_weapons[character_player_number - 1])):
		if weapons[i] != Global.player_weapons[character_player_number - 1][i]:
			weapons[i] = Global.player_weapons[character_player_number - 1][i]
			wlevels[i] = 1
			var new_weapon = create_weapon(weapons[i])
			weapon_nodes.push_back(new_weapon)
			add_child(new_weapon)

func upgrade_weapons():
	for i in range(len(Global.player_weapon_levels[character_player_number - 1])):
		if wlevels[i] != Global.player_weapon_levels[character_player_number - 1][i]:
			wlevels[i] += 1
			weapon_nodes[i].level_up()
			print(weapon_nodes)
			print(weapon_nodes[i])

func create_weapon(number):
	if number == 0:
		#return cone.instantiate()
		pass
	elif number == 1:
		return vegemite.instantiate()
	elif number == 2:
		return didgeridoo.instantiate()
	elif number == 3:
		return boomerang.instantiate()
	elif number == 4:
		#stop_sign.instantiate()
		pass
	elif number == 5:
		return skewer.instantiate()
	elif number == 6:
		return thongs.instantiate()
	elif number == 7:
		#tongs.instantiate()
		pass
	elif number == 8:
		#surfboard.instantiate()
		pass
	else:
		print("invalid weapon number")
