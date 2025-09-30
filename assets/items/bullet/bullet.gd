extends Area2D
var direction
var speed = 1500

func _physics_process(delta: float) -> void:
	position += direction * delta * speed
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("shootable"):
		body.hit()
	queue_free()
