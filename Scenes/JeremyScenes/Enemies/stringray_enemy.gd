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
	hp = hp + (hp * Global.time_seconds * 0.02)
	anim.play("walk")
	hitBox.damage = enemy_damage
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	if player != null:
		if player.dead:
			get_random_player()
	
		knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
		direction = global_position.direction_to(player.global_position)
		velocity = direction*movement_speed
		velocity += knockback
		move_and_slide()
		
		if direction.x > 0.1:
			sprite.flip_v = false
		elif direction.x < -0.1:
			sprite.flip_v = true

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
	else:
		sprite.modulate = Color.RED
		var old_movement_speed = movement_speed
		movement_speed = 10
		await get_tree().create_timer(0.5).timeout
		sprite.modulate = Color.WHITE
		movement_speed = old_movement_speed
		#sprite.material.set_shader_parameter("solid_color", Color.RED)
		#snd_hit.play()

func set_hp():
	pass # this only exists so it doesn't bug out
