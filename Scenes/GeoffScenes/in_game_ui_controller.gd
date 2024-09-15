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
	#updates UI
	pass


func _on_item_1_button_pressed() -> void:
	item_selected(0)

func _on_item_2_button_pressed() -> void:
	item_selected(1)

func _on_item_3_button_pressed() -> void:
	item_selected(2)

func item_selected(num: int) -> void:
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
