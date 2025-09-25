extends CharacterBody2D
@export var speed = 400

func _ready() -> void:
	$AnimatedSprite2D.play() # Replace with function body.

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"): velocity.x -= 1
	if Input.is_action_pressed("move_right"): velocity.x += 1
	
	velocity = velocity.normalized() * speed
	if velocity.length() == 0:
		$AnimatedSprite2D.animation = "idle"
	elif velocity.x > 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true

	move_and_slide()
	
	
