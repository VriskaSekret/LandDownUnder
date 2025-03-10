extends Node2D

var player_character = preload("res://Scripts/GeoffScripts/TemporaryPlayer.tscn")
var last_level = Global.total_level
@onready var in_game_ui: CanvasLayer = $"../InGameUI"

var is_game_over = false


# FOR TIMER
@onready var count_up: Timer = $CountUp
# GameOver timer
@onready var game_over_timer: Timer = $GameOverTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	count_up.start()
	for i in range(Global.number_players):
		var player_instance = player_character.instantiate()
		player_instance.character_player_number = i + 1
		player_instance.name = "Player%d" % (i + 1)
		print (player_instance.character_player_number)
		add_child(player_instance)
		last_level = Global.total_level
	in_game_ui.update_player_inventory()
	print(Global.experience_needed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.players_alive == [false, false, false, false]:
		game_over()

func game_over():
	if not is_game_over:
		is_game_over = true
		print("everyone is dead!!!!!")
		game_over_timer.start()


func _on_game_over_timer_timeout() -> void:
	#show game over ui
	var time_lasted = ("%02d:%02d" % [floor(in_game_ui.local_time/60), in_game_ui.local_time%60])
	in_game_ui.game_over.get_child(0).get_child(0).text = "Game Over\n\nYou lasted %s\nScore: %d" % [time_lasted, Global.score]
	in_game_ui.game_over.show()
	in_game_ui.go_home_button.grab_focus()
	in_game_ui.xp_bar.hide()
	#in_game_ui.player_items.hide()
	Engine.time_scale = 0
	Global.game_paused = true

func pause_for_item():
	randomise_item_select()
	in_game_ui.update_upgrade_buttons()
	in_game_ui.item_select.show()
	in_game_ui.item_1_button.grab_focus()
	in_game_ui.xp_bar.hide()
	in_game_ui.player_items.hide()
	Engine.time_scale = 0
	Global.game_paused = true

func randomise_item_select() -> void:
	# ITEMS ARE AS FOLLOWS:
	# 0 - tradie default wep - cone 
	# 1 - raygun default wep - vegemite
	# 2 - abo default wep - didgeridoo
	# 3 - bush default wep - whip
	# 4 - boomerang
	# 5 - shrimp from the barbie
	# 6 - thongs
	# 7 - snake
	# 8 - surfboard
	# IF ALL WEAPON SLOTS ARE FULL, START GIVING PASSIVE BUFFS
	# 9 - walk speed buff
	# 10 - attack speed buff
	# 11 - heal buff
	# 12 - attack damage buff
	
	var item_array = []
	##### CHECK PLAYER ITEMS THEN RANDOMISE #####
	var player_recieving = Global.player_recieving_item
	var inventory = Global.player_weapons[player_recieving]
	var inventory_levels = Global.player_weapon_levels[player_recieving]
	var inv_full = not -1 in inventory
	if inv_full:
		for i in range(len(inventory)):
			if inventory_levels[i] < 3:
				item_array.append(inventory[i])
		item_array += [9,10,11,12]
	else:
		item_array = [0,1,2,3,4,5,6,7,8]
	var output = []
	for i in range(len(inventory)):
		var added_item = item_array.pick_random()
		item_array.erase(added_item)
		output.append(added_item)
	Global.randomised_items = output

func check_level():
	if last_level < Global.total_level:
		last_level = Global.total_level
		print("Level: " + str(Global.total_level))
		print(Global.experience_needed)
		pause_for_item()


func _on_count_up_timeout() -> void:
	Global.time_seconds += 1
