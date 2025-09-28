extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "off"
	$AnimatedSprite2D.play()
	$Panel.visible = false
	
func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.animation = "on"
