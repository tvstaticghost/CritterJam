extends Control

var opening_scene = preload("res://Scenes/opening_scene.tscn")

func _on_button_pressed(new_scene = null) -> void:  # optional parameter
	get_tree().change_scene_to_packed(opening_scene)
#fix this shit not sure why its broken
