extends CharacterBody2D
var health = 2

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	add_to_group("shootable")

func hit():
	health -= 1
	if health <= 0: queue_free()
