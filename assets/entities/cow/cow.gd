extends Area2D
func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	var enemies_defeated = get_tree().get_nodes_in_group("enemy").is_empty() 
	if body is Player and enemies_defeated:
		await get_tree().create_timer(0.75).timeout
		get_tree().change_scene_to_file("res://assets/ui/game_won/winning_screen.tscn")
