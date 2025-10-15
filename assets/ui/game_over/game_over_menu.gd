extends MarginContainer

func _ready():
	$Text.play("default")

func _on_retry_level_button_pressed() -> void:
	var last = get_tree().get_meta("last_scene")
	get_tree().change_scene_to_file(last)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/ui/menu/main_menu.tscn")
