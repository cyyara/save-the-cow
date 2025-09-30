extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	var enemies_defeated = get_tree().get_nodes_in_group("enemy").is_empty() 
	if body is Player and enemies_defeated:
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file("res://assets/levels/level_2/level_2.tscn")
