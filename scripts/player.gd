extends CharacterBody2D

@export var speed = 200
@export var jump_speed = 400
@export var gravity = 1000

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	var input_x = Input.get_axis("move_left", "move_right")
	velocity.x = input_x * speed

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed

	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "jump"
		else:
			$AnimatedSprite2D.animation = "fall"
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "idle"

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	move_and_slide()
