extends AnimatableBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	var guardian_defeated = get_tree().get_nodes_in_group("guardian").is_empty()
	if body is Player and guardian_defeated:
		$AnimationPlayer.play("back and forth")
