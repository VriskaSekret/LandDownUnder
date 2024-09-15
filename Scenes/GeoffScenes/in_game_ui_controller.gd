extends CanvasLayer

@onready var item_select: VBoxContainer = $MarginContainer/ItemSelect
@onready var player_items: HBoxContainer = $PlayerItems

#
# Buttons for items when levelling up
#
@onready var item_1_button: Button = $MarginContainer/ItemSelect/HBoxContainer/Item1Button
@onready var item_2_button: Button = $MarginContainer/ItemSelect/HBoxContainer/Item2Button
@onready var item_3_button: Button = $MarginContainer/ItemSelect/HBoxContainer/Item3Button
#
# Buttons for items when levelling up
#
var reciever
var random_items

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_upgrade_buttons():
	var items = Global.randomised_items
	$MarginContainer/ItemSelect/HBoxContainer/Item1Button.text = str(items[0])
	$MarginContainer/ItemSelect/HBoxContainer/Item2Button.text = str(items[1])
	$MarginContainer/ItemSelect/HBoxContainer/Item3Button.text = str(items[2])

func update_player_inventory():
	pass



func _on_item_1_button_pressed() -> void:
	reciever = Global.player_recieving_item
	var item = Global.randomised_items[0]
	if item < 9: #AMOUNT OF WEAPONS
		if item in Global.player_weapons[reciever]:
			var temp_index = Global.player_weapons[reciever].find(item)
			Global.player_weapon_levels[reciever][temp_index] += 1
		else:
			var temp_index = Global.player_weapons[reciever].find(-1)
			Global.player_weapons[reciever][temp_index] = item
			Global.player_weapon_levels[reciever][temp_index] = 1
	else:
		pass # ADD BUFF BASED ON ITEM
	Engine.time_scale = 1
	item_select.hide()
	Global.game_paused = false
	print("Player " + str(1))
	print("Weapons " + str(Global.player_weapons[0]))
	print("Weapon Levels " + str(Global.player_weapon_levels[0]))

func _on_item_2_button_pressed() -> void:
	reciever = Global.player_recieving_item
	var item = Global.randomised_items[1]
	if item < 9: #AMOUNT OF WEAPONS
		if item in Global.player_weapons[reciever]:
			var temp_index = Global.player_weapons[reciever].find(item)
			Global.player_weapon_levels[reciever][temp_index] += 1
		else:
			var temp_index = Global.player_weapons[reciever].find(-1)
			Global.player_weapons[reciever][temp_index] = item
			Global.player_weapon_levels[reciever][temp_index] = 1
	else:
		pass # ADD BUFF BASED ON ITEM
	Engine.time_scale = 1
	item_select.hide()
	Global.game_paused = false
	print("Player " + str(1))
	print("Weapons " + str(Global.player_weapons[0]))
	print("Weapon Levels " + str(Global.player_weapon_levels[0]))


func _on_item_3_button_pressed() -> void:
	reciever = Global.player_recieving_item
	var item = Global.randomised_items[2]
	if item < 9: #AMOUNT OF WEAPONS
		if item in Global.player_weapons[reciever]:
			var temp_index = Global.player_weapons[reciever].find(item)
			Global.player_weapon_levels[reciever][temp_index] += 1
		else:
			var temp_index = Global.player_weapons[reciever].find(-1)
			Global.player_weapons[reciever][temp_index] = item
			Global.player_weapon_levels[reciever][temp_index] = 1
	else:
		pass # ADD BUFF BASED ON ITEM
	Engine.time_scale = 1
	item_select.hide()
	Global.game_paused = false
	print("Player " + str(1))
	print("Weapons " + str(Global.player_weapons[0]))
	print("Weapon Levels " + str(Global.player_weapon_levels[0]))
