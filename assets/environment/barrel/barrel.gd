extends RigidBody2D
class_name Barrel
var health = 2
func _ready():
	add_to_group("shootable")
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D2.hide()
	$AnimatedSprite2D3.hide()
func hit():
	health -= 1
	if health <= 0:
		$Sprite2D.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D2.show()
		$AnimatedSprite2D3.show()
		$AnimatedSprite2D.play("explode")
		$AnimatedSprite2D2.play("explode")
		$AnimatedSprite2D3.play("explode")
		for body in $ExplosionArea.get_overlapping_bodies():
			if body.is_in_group("shootable") and body is not Barrel:
				body.kill()

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
