extends CharacterBody2D

@export var speed = 200
@export var jump_speed = 400
@export var gravity = 1000
var jump_count = 0

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	var input_x = Input.get_axis("move_left", "move_right")
	velocity.x = input_x * speed
	
	var can_jump = jump_count < 2 and velocity.y >= 0
	
	if is_on_floor():
		jump_count = 0
		velocity.y = 0
	
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = -jump_speed
		jump_count += 1

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
