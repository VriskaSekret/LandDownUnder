extends Node2D

var enemy_cap = 300
var enemies_to_spawn = []
var spawn_rate = 1
var rate_counter
@export var spawns: Array[Spawn_info] = []

#@onready var player = get_tree().get_first_node_in_group("Player")
@onready var camera: Camera2D = $"../Camera2D"

var time = 0

func _ready() -> void:
	if (0 < Global.number_players and Global.number_players < 3):
		spawn_rate = 1
	elif (2 < Global.number_players and Global.number_players < 5):
		spawn_rate = 2

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	var my_children = get_children()
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end: # wait time increments until it's beyond the delay
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else: # wait time is over, so spawn n number of enemies
				i.spawn_delay_counter = 0
				var new_enemy = i.enemy
				var counter = 0
				while counter < (i.enemy_num):
					# checks if mob count minus coins is less than enemy cap
					if (my_children.size() - get_tree().get_nodes_in_group("coins").size()) <= enemy_cap:
						rate_counter = spawn_rate
						while rate_counter > 0:
							var enemy_spawn = new_enemy.instantiate()
							enemy_spawn.global_position = get_random_position()
							add_child(enemy_spawn)
							rate_counter -= 1
					else:
						enemies_to_spawn.append(new_enemy)
					counter += 1
		if time > i.time_end:
			spawns.pop_front()
	if my_children.size() <= enemy_cap and enemies_to_spawn.size() > 0:
		var spawn_number = clamp(enemies_to_spawn.size(), 1, 50) - 1
		var counter = 0
		while counter < spawn_number:
			var new_enemy = enemies_to_spawn[0].instantiate()
			new_enemy.global_position = get_random_position()
			add_child(new_enemy)
			enemies_to_spawn.remove_at(0)
			counter += 1

func get_random_position():
	var vpr = (get_viewport_rect().size / camera.zoom) * randf_range(1.1, 1.4)
	var top_left = Vector2(camera.global_position.x - vpr.x/2, camera.global_position.y - vpr.y/2)
	var top_right = Vector2(camera.global_position.x + vpr.x/2, camera.global_position.y - vpr.y/2)
	var bottom_left = Vector2(camera.global_position.x - vpr.x/2, camera.global_position.y + vpr.y/2)
	var bottom_right = Vector2(camera.global_position.x + vpr.x/2, camera.global_position.y + vpr.y/2)
	var pos_side = ["up", "down", "left", "right"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right

	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
