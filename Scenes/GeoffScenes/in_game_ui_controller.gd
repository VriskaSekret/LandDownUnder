extends CanvasLayer

@onready var item_select: VBoxContainer = $MarginContainer/ItemSelect
@onready var player_items: HBoxContainer = $PlayerItems
@onready var game_manager: Node2D = $"../GameManager"
@onready var count_up_time: Label = $XPBar/CountUpTime
var local_time = 0
@onready var select_item_label: Label = $MarginContainer/ItemSelect/SelectItemLabel

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
	if local_time != Global.time_seconds:
		local_time = Global.time_seconds
		count_up_time.text = ("%02d:%02d" % [floor(local_time/60), local_time%60])
	pass

func update_upgrade_buttons():
	var items = Global.randomised_items
	select_item_label.text = str("Player %d\nSelect your item" % (Global.player_recieving_item + 1))
	$MarginContainer/ItemSelect/HBoxContainer/Item1Button.text = str(items[0])
	$MarginContainer/ItemSelect/HBoxContainer/Item2Button.text = str(items[1])
	$MarginContainer/ItemSelect/HBoxContainer/Item3Button.text = str(items[2])

func update_player_inventory():
	var list_of_all = []
	for i in Global.player_weapons:
		for j in i:
			list_of_all.append(j)
	$PlayerItems/ItemsPlayer1/Item1/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[0]
	$PlayerItems/ItemsPlayer1/Item2/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[1]
	$PlayerItems/ItemsPlayer1/Item3/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[2]
	$PlayerItems/ItemsPlayer2/Item1/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[3]
	$PlayerItems/ItemsPlayer2/Item2/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[4]
	$PlayerItems/ItemsPlayer2/Item3/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[5]
	$PlayerItems/ItemsPlayer3/Item1/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[6]
	$PlayerItems/ItemsPlayer3/Item2/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[7]
	$PlayerItems/ItemsPlayer3/Item3/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[8]
	$PlayerItems/ItemsPlayer4/Item1/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[9]
	$PlayerItems/ItemsPlayer4/Item2/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[10]
	$PlayerItems/ItemsPlayer4/Item3/Frame/ItemImage.texture = "res://Assets/Icons/%d.png" % list_of_all[11]
				#player_items.get_child(player_i).get_child\
				#(weapon_i).get_child(0).get_child\
				#(0).Texture = "res://Assets/Icons/%d.png" % Global.player_weapons[player_i][weapon_i]


func _on_item_1_button_pressed() -> void:
	item_selected(0)

func _on_item_2_button_pressed() -> void:
	item_selected(1)

func _on_item_3_button_pressed() -> void:
	item_selected(2)

func item_selected(num: int) -> void:
	Global.player_recieving_item = 0
	reciever = Global.player_recieving_item
	var player_instance = get_parent().get_node("GameManager").get_node("Player%d" % (reciever + 1))
	var item = Global.randomised_items[num]
	if item in Global.player_weapons[reciever]:
		var temp_index = Global.player_weapons[reciever].find(item)
		Global.player_weapon_levels[reciever][temp_index] += 1
		player_instance.upgrade_weapons()
	else:
		var temp_index = Global.player_weapons[reciever].find(-1)
		Global.player_weapons[reciever][temp_index] = item
		Global.player_weapon_levels[reciever][temp_index] = 1
		player_instance.add_weapons()
	Engine.time_scale = 1
	item_select.hide()
	Global.game_paused = false
	print("Player " + str(1))
	print("Weapons " + str(Global.player_weapons[0]))
	print("Weapon Levels " + str(Global.player_weapon_levels[0]))
