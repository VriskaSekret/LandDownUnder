extends Control
@onready var starting_menu: HBoxContainer = $MarginContainer/StartingMenu
@onready var player_count_select: VBoxContainer = $MarginContainer/PlayerCountSelect
@onready var character_select: VBoxContainer = $MarginContainer/CharacterSelect
@onready var player_selecting_label: Label = $MarginContainer/CharacterSelect/PlayerSelecting
var is_fullscreen = false


var players = 0
var player_selecting = 0

func _ready() -> void:
	MenuBgMusic.play()
	Global.reset_global_variables()
	starting_menu.visible = true
	player_count_select.visible = false
	character_select.visible = false
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("focus_entered", _on_button_focused)
	$MarginContainer/StartingMenu/VBoxContainer/StartButton.grab_focus()

func _process(_delta: float) -> void:
	if player_selecting > players:
		get_tree().change_scene_to_file("res://Scenes/prototype_scene.tscn")
	player_selecting_label.text = "Player %d Select" % player_selecting

func _on_button_focused():
	MenuSelectSound.play()

func _on_start_button_pressed() -> void:
	starting_menu.visible = false
	player_count_select.visible = true
	$"MarginContainer/PlayerCountSelect/Buttons/VBoxContainer/1PButton".grab_focus()
	CoinSound.play()


func _on_options_button_pressed() -> void:
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		is_fullscreen = false
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		is_fullscreen = true
	CoinSound.play()


func _on_quit_button_pressed() -> void:
	CoinSound.play()
	get_tree().quit()


func _on_1p_button_pressed() -> void:
	CoinSound.play()
	players = 1
	Global.players_alive = [true, false, false, false]
	Global.number_players = 1
	player_count_select.visible = false
	character_select.visible = true
	player_selecting = 1
	$MarginContainer/CharacterSelect/Buttons/VBoxContainer/Tradie.grab_focus()

func _on_2p_button_pressed() -> void:
	CoinSound.play()
	players = 2
	Global.players_alive = [true, true, false, false]
	Global.number_players = 2
	player_count_select.visible = false
	character_select.visible = true
	player_selecting = 1
	$MarginContainer/CharacterSelect/Buttons/VBoxContainer/Tradie.grab_focus()


func _on_3p_button_pressed() -> void:
	CoinSound.play()
	players = 3
	Global.players_alive = [true, true, true, false]
	Global.number_players = 3
	player_count_select.visible = false
	character_select.visible = true
	player_selecting = 1
	$MarginContainer/CharacterSelect/Buttons/VBoxContainer/Tradie.grab_focus()


func _on_4p_button_pressed() -> void:
	CoinSound.play()
	players = 4
	Global.players_alive = [true, true, true, true]
	Global.number_players = 4
	player_count_select.visible = false
	character_select.visible = true
	player_selecting = 1
	$MarginContainer/CharacterSelect/Buttons/VBoxContainer/Tradie.grab_focus()


func _on_tradie_pressed() -> void:
	CoinSound.play()
	if player_selecting == 1:
		Global.player_characters[0] = 0
	elif player_selecting == 2:
		Global.player_characters[1] = 0
	elif player_selecting == 3:
		Global.player_characters[2] = 0
	elif player_selecting == 4:
		Global.player_characters[3] = 0
	player_selecting += 1


func _on_abo_pressed() -> void:
	CoinSound.play()
	if player_selecting == 1:
		Global.player_characters[0] = 2
	elif player_selecting == 2:
		Global.player_characters[1] = 2
	elif player_selecting == 3:
		Global.player_characters[2] = 2
	elif player_selecting == 4:
		Global.player_characters[3] = 2
	player_selecting += 1


func _on_raygun_pressed() -> void:
	CoinSound.play()
	if player_selecting == 1:
		Global.player_characters[0] = 1
	elif player_selecting == 2:
		Global.player_characters[1] = 1
	elif player_selecting == 3:
		Global.player_characters[2] = 1
	elif player_selecting == 4:
		Global.player_characters[3] = 1
	player_selecting += 1

func _on_ranger_pressed() -> void:
	CoinSound.play()
	if player_selecting == 1:
		Global.player_characters[0] = 3
	elif player_selecting == 2:
		Global.player_characters[1] = 3
	elif player_selecting == 3:
		Global.player_characters[2] = 3
	elif player_selecting == 4:
		Global.player_characters[3] = 3
	player_selecting += 1


func _on_start_button_mouse_entered() -> void:
	$MarginContainer/StartingMenu/VBoxContainer/StartButton.grab_focus()


func _on_options_button_mouse_entered() -> void:
	$MarginContainer/StartingMenu/VBoxContainer/OptionsButton.grab_focus()


func _on_quit_button_mouse_entered() -> void:
	$MarginContainer/StartingMenu/VBoxContainer/QuitButton.grab_focus()
