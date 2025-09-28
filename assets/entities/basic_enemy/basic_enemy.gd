extends CharacterBody2D
var health = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("shootable")


func hit():
	health -= 1
	if health <= 0: queue_free()
