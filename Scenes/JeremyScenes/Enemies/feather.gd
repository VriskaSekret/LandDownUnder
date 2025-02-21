extends Area2D

@export var damage := 1
@export var speed = 200.0

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disable_timer: Timer = $DisableHitboxTimer

@onready var players = get_tree().get_nodes_in_group("Player")
var player
var direction
var player_pos

func temp_disable():
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()


func _on_disable_hitbox_timer_timeout():
	collision.call_deferred("set", "disabled", false)
	


func _ready() -> void:
	player = get_random_player()
	if player:
		player_pos = player.global_position
		direction = global_position.direction_to(player_pos)
		look_at(player_pos)

func _physics_process(delta: float) -> void:
	if direction:
		position += direction * speed * delta

func _on_timer_timeout() -> void:
	queue_free()

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

func kill_feather() -> void:
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	print("i hit the player")
	kill_feather()
