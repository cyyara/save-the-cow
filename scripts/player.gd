extends CharacterBody2D
@export var speed = 400

func _ready() -> void:
	$AnimatedSprite2D.play() # Replace with function body.

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if velocity.length() != 0:
		$AnimatedSprite2D.animation = "walk"
		velocity = velocity * speed
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.animation = "idle"
	move_and_slide()
	
	
