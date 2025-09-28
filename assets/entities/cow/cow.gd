extends Area2D
func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
