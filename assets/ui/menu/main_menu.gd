extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/levels/level_1/level_1.tscn")
