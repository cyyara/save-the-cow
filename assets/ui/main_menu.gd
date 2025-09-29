extends Control


func _on_startgame_pressed():
	get_tree().change_scene_to_file("res://assets/levels/level_1/level_1.tscn")
	


func _on_exit_pressed():
	get_tree().quit()
