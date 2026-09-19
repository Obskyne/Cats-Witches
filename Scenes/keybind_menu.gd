extends Control

func _on_back_to_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
