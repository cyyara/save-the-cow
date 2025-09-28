extends Area2D
var direction
var speed = 1500
var lifetime = 1
func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * delta * speed
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("shootable"):
		body.hit()
	queue_free()
