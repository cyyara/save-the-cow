extends MarginContainer

func _ready() -> void:
	$Background.play("default")


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/levels/level_1/level_1.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/ui/menu/main_menu.tscn")
