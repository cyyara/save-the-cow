extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "off"
	$AnimatedSprite2D.play()
	$Panel.visible = false
	
func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.animation = "on"
		$Panel.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$Panel.visible = false
