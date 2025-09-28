extends RigidBody2D
class_name Crate
var health = 2
func _ready():
	add_to_group("shootable")

func hit():
	health -= 1
	if health <= 0: queue_free()
