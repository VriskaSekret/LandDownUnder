class_name Magpie
extends CharacterBody2D

var bomb = preload("res://Scenes/JeremyScenes/Enemies/Magpie/magpie_bomb.tscn")
@export var movement_speed = 200.0

@onready var players = get_tree().get_nodes_in_group("Player")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer


signal remove_from_array(object)

var screen_size
var player 
var direction
var distance
var drop_location
var has_dropped

func _ready():
	player = get_random_player()
	# anim.play("walk")
	screen_size = get_viewport_rect().size
	has_dropped = false
	if player:
		drop_location = player.global_position
		look_at(drop_location)
		direction = global_position.direction_to(player.global_position)

func _physics_process(_delta):
	if player != null:
		if (global_position.distance_to(player.global_position) > 2000):
			print("enemy deleted")
			queue_free()
		distance = global_position.distance_to(player.global_position)
		velocity = direction*movement_speed
		move_and_slide()

func get_random_player() -> CharacterBody2D:
	# SO I DON'T CRASH THE FUCK OUT OF THIS GAME
	var alive_counter = 0
	if alive_counter >= 4:
		return
	for i in Global.players_alive:
		if not i:
			alive_counter += 1
		if alive_counter >= 4:
			return
	
	player = players.pick_random()
	while player.dead:
		player = players.pick_random()
	return player


func _on_timer_timeout() -> void:
	spawn_bomb()


func spawn_bomb() -> void:
	var new_bomb = bomb.instantiate()
	new_bomb.global_position = global_position
	get_parent().get_parent().add_child(new_bomb)

# this function does nothing, it exists because all the other enemies has it
# and i can't be bothered making an exception for this darn enemy
func set_hp() -> void:
	pass
