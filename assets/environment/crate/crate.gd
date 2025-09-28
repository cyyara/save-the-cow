extends RigidBody2D
class_name Crate

func _ready():
	add_to_group("shootable")

func hit():
	queue_free()
