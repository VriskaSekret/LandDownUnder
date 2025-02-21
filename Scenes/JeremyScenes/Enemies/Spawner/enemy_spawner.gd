extends Node2D

var enemy_cap = 300
var enemies_to_spawn = []
var spawn_rate = 1
var rate_counter
@export var spawns: Array[Spawn_info] = []
@onready var camera: Camera2D = $"../../Camera2D"
var enemy_spawn
var enemy_manager
var time = 0


func _ready() -> void:
	enemy_manager = get_tree().get_first_node_in_group("enemy_manager")
	
	if (0 < Global.number_players and Global.number_players < 3):
		spawn_rate = 1
	elif (2 < Global.number_players and Global.number_players < 5):
		spawn_rate = 2

func _on_timer_timeout():
	time += 1
	enemy_spawn = spawns
	for i in enemy_spawn: # loop through array holding spawn information
		if time >= i.time_start and time <= i.time_end: # check if it's within the spawn time
			if i.spawn_delay_counter < i.enemy_spawn_delay: # check if it's during a delay
				i.spawn_delay_counter += 1
			else: # wait time is over, so spawn n number of enemies
				i.spawn_delay_counter = 1
				
				# check if it's reached enemy cap & whether it's a magpie
				if get_tree().get_nodes_in_group("active_enemy").size() >= enemy_cap:
					enemies_to_spawn.append(i)
				else: # enemy cap has not been reached or enemy is magpie
					spawn_enemy(i)
	# if there's little to no spawning happening, pull from enemy cap array
	if (get_tree().get_nodes_in_group("active_enemy").size() < enemy_cap) and (enemies_to_spawn.size() > 0):
		spawn_enemy(enemies_to_spawn[0])
		enemies_to_spawn.pop_at(0)
	



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

func spawn_enemy(enemy_info: Resource):
	var counter = 0
	while counter < enemy_info.enemy_num:
		rate_counter = spawn_rate
		while rate_counter > 0:
			var new_enemy = enemy_manager.get_enemy(enemy_info.enemy)
			new_enemy.global_position = get_random_position()
			new_enemy.set_hp()
			#print(new_enemy.hp)
			if !(new_enemy.get_parent() == self):
				add_child(new_enemy)
			
			
			rate_counter -= 1
		counter += 1

func _on_delete_past_spawn_info_timer_timeout() -> void:
	delete_past_spawn_info()

func delete_past_spawn_info():
	for i in range(enemy_spawn.size()-1, -1, -1):
		if time > enemy_spawn[i].time_end:
			enemy_spawn.pop_at(i)
