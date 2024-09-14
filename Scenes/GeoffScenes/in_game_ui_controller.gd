extends Control

@onready var item_select: VBoxContainer = $MarginContainer/ItemSelect

#
# Buttons for items when levelling up
#
@onready var item_1_button: Button = $MarginContainer/ItemSelect/HBoxContainer/Item1Button
@onready var item_2_button: Button = $MarginContainer/ItemSelect/HBoxContainer/Item2Button
@onready var item_3_button: Button = $MarginContainer/ItemSelect/HBoxContainer/Item3Button
#
# Buttons for items when levelling up
#


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
