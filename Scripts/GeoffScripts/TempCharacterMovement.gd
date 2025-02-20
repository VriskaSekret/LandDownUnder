extends CharacterBody2D

@onready var anim_spr: AnimatedSprite2D = $AnimatedSprite2D

@onready var health_bar: ProgressBar = $HealthBar
@export var hp := 80
var dead = false

var attack_speed: float = 1.0
var damage_multiplier: float = 1.0

var character_player_number
var dir
var last_dir: Vector2 = Vector2(1, 1)
var has_assigned_keys: bool = false
var movement_speed := 100.0
var left_button
var right_button
var up_button
var down_button
var controller_id: int

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
var thongs = preload("res://Scenes/TabyScenes/Attacks/Thongs/thong_shooter.tscn")
var vegemite = preload("res://Scenes/TabyScenes/Attacks/Vegemite/vegemite_shooter.tscn")
var cone = preload("res://Scenes/TabyScenes/Attacks/Cone/cone_shooter.tscn")
var surf = preload("res://Scenes/TabyScenes/Attacks/Surfboard/surf.tscn")
var snake = preload("res://Scenes/TabyScenes/Attacks/Snake/snake_shooter.tscn")
var whip = preload("res://Scenes/TabyScenes/Attacks/Whip/whip_shooter.tscn")



func _ready():
	set_base_stats()
	health_bar.max_value = hp
	health_bar.value = hp
	player_type = Global.player_characters[character_player_number-1]
	Global.player_weapons[character_player_number-1] = [player_type, -1, -1]
	Global.player_weapon_levels[character_player_number-1] = [1,-1,-1]
	print("Player " + str(character_player_number))
	print("Weapons " + str(Global.player_weapons[character_player_number-1]))
	print("Weapon Levels " + str(Global.player_weapon_levels[character_player_number-1]))
	add_weapons()


func get_input() -> void:
	if not has_assigned_keys:
		has_assigned_keys = true
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
	if !Global.game_paused and not dead:
		get_input()
		if dir[0] < 0:
			anim_spr.flip_h = true
		elif dir[0] > 0:
			anim_spr.flip_h = false
		move_and_slide()


func _process(_delta) -> void:
	# Animation shit, doesn't relate to physics
	if !Global.game_paused and not dead:
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

func set_base_stats():
	var char_index: int = Global.player_characters[character_player_number - 1]
	if char_index == 0:
		hp = 15
		damage_multiplier = 1.0
		movement_speed = 140.0
	if char_index == 1:
		hp == 10
		damage_multiplier = 0.85
		movement_speed = 170.0
	if char_index == 2:
		hp = 20
		damage_multiplier = 1.0
		movement_speed = 120.0
	if char_index == 3:
		hp = 10
		damage_multiplier = 1.2
		movement_speed = 140.0
	

func _on_hurtbox_hurt(damage, _angle, _knockback) -> void:
	if not dead:
		hp -= damage
		print(hp)
		health_bar.value = hp
		if hp <= 0:
			die()
		anim_spr.modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		anim_spr.modulate = Color.WHITE

func die() -> void:
	var camera = get_tree().get_first_node_in_group("Camera")
	camera.remove_target(self)
	dead = true
	Global.players_alive[character_player_number - 1] = false
	anim_spr.rotate(-PI/2)
	anim_spr.play(get_char_name() + "_idle")
	anim_spr.speed_scale = 0
	for wp in weapon_nodes:
		if is_instance_valid(wp):
			wp.queue_free()

func add_weapons():
	for i in range(len(Global.player_weapons[character_player_number - 1])):
		if weapons[i] != Global.player_weapons[character_player_number - 1][i]:
			weapons[i] = Global.player_weapons[character_player_number - 1][i]
			wlevels[i] = 1
			var new_weapon = create_weapon(weapons[i])
			if new_weapon:
				weapon_nodes.push_back(new_weapon)
				new_weapon.player = $"."
				add_child(new_weapon)

func upgrade_weapons():
	Engine.time_scale = 2
	for i in range(len(Global.player_weapon_levels[character_player_number - 1])):
		if wlevels[i] != Global.player_weapon_levels[character_player_number - 1][i]:
			wlevels[i] = Global.player_weapon_levels[character_player_number - 1][i]
			while wlevels[i] > weapon_nodes[i].level:
				weapon_nodes[i].level_up()

func add_buff(buff: int):
	create_weapon(buff)

func create_weapon(number):
	if number == 0:
		return cone.instantiate()
	elif number == 1:
		return skewer.instantiate()
	elif number == 2:
		return didgeridoo.instantiate()
	elif number == 3:
		return whip.instantiate()
	elif number == 4:
		return boomerang.instantiate()
	elif number == 5:
		return vegemite.instantiate()
	elif number == 6:
		return thongs.instantiate()
	elif number == 7:
		return snake.instantiate()
	elif number == 8:
		return surf.instantiate()
	elif number == 9:
		movement_speed += 5.0
	elif number == 10:
		attack_speed = max(0.7, attack_speed - 0.05)
	elif number == 11:
		hp = min(health_bar.max_value, hp + health_bar.max_value * 0.5)
		health_bar.value = hp
	elif number == 12:
		damage_multiplier += 0.05
