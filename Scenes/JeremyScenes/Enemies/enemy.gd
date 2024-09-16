extends CharacterBody2D


@export var movement_speed = 20.0
@export var hp = 10 
@export var knockback_recovery = 3.5
@export var experience = 1
@export var enemy_damage = 1
var knockback = Vector2.ZERO

@onready var players = get_tree().get_nodes_in_group("Player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
#@onready var snd_hit = $snd_hit
@onready var hitBox = $Hitbox

# CHANGE THE DEATH ANIMATION
var death_anim = preload("res://Scenes/JeremyScenes/Enemies/Explosion/explosion.tscn")
var coin_drop = preload("res://Scenes/GeoffScenes/coin.tscn")

signal remove_from_array(object)

var screen_size
var player 
var direction

func _ready():
	player = get_random_player()
	print("targetting", player.name)
	hp = hp + (hp * Global.time_seconds * 0.02)
	anim.play("walk")
	hitBox.damage = enemy_damage
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	#if player is dead: # WORK ON HERE
		#get_random_player()
	
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	velocity += knockback
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true

func get_random_player() -> CharacterBody2D:
	var player = players.pick_random()
	return player

func death():
	# wtf does this signal do
	#emit_signal("remove_from_arr", self)
	var coin = coin_drop.instantiate()
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale
	coin.scale = sprite.scale
	enemy_death.global_position = global_position
	coin.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	get_parent().call_deferred("add_child", coin)
	queue_free()

func _on_hurtbox_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	#else:
		#snd_hit.play()
