extends Control

@onready var object_selection_menu = $OptionButton
@onready var control: Control = $"../Control"
@onready var world: Node3D = $"../.."


func submit_button_pressed() -> void:
	var index = object_selection_menu.get_selected()
	var object_text = object_selection_menu.get_item_text(index)
	if object_text == "":
		return
	
	world.check_game_won(object_text)


func close_menu_pressed() -> void:
	visible = false
	control.visible = true
	world.can_open_phone = true
