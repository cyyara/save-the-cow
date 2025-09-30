extends RigidBody2D
class_name Barrel
var health = 2
func _ready():
	add_to_group("shootable")

func hit():
	health -= 1
	if health <= 0:
		for body in $ExplosionArea.get_overlapping_bodies():
			if body.is_in_group("shootable"):
				body.queue_free()
		queue_free()
