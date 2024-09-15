extends Node2D

var player_character = preload("res://Scripts/GeoffScripts/TemporaryPlayer.tscn")
var last_level = Global.total_level
@onready var in_game_ui: Control = $"../CanvasLayer/InGameUI"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(Global.number_players):
		var player_instance = player_character.instantiate()
		player_instance.character_player_number = i + 1
		player_instance.name = "Player%d" % (i + 1)
		print (player_instance.character_player_number)
		add_child(player_instance)
		last_level = Global.total_level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func pause_for_item():
	randomise_item_select()
	in_game_ui.update_upgrade_buttons()
	in_game_ui.item_select.show()
	Engine.time_scale = 0
	Global.game_paused = true

func randomise_item_select() -> void:
	# ITEMS ARE AS FOLLOWS:
	# 0 - tradie default wep - stop sign or cone idk
	# 1 - raygun default wep - vegemite
	# 2 - abo default wep - didgeridoo
	# 3 - bush default wep - boomerang
	# 4 - stop sign or cone depending on tradie default wep
	# 5 - shrimp from the barbie
	# 6 - thongs
	# 7 - TONGS (not the slipper)
	# 8 - surfboard
	# IF ALL WEAPON SLOTS ARE FULL, START GIVING PASSIVE BUFFS
	# 9 - walk speed buff
	# 10 - attack speed buff
	# 11 - hp buff
	# 12 - attack damage buff
	
	var item_array = []
	##### CHECK PLAYER ITEMS THEN RANDOMISE #####
	var player_recieving = Global.player_recieving_item
	var inventory = Global.player_weapons[player_recieving-1]
	var inventory_levels = Global.player_weapon_levels[player_recieving-1]
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
		pause_for_item()
