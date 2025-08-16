extends Control

var world_scene = preload("res://Scenes/world.tscn")

func play_button() -> void:
	get_tree().change_scene_to_packed(world_scene)
