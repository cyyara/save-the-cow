extends CharacterBody2D
@export var speed = 200
@export var jump_speed = 400
@export var gravity = 0

func _ready() -> void:
	$AnimatedSprite2D.play() # Replace with function body.

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var input_x = Input.get_axis("move_left", "move_right")
	velocity.x = input_x
	if velocity.length() != 0:
		$AnimatedSprite2D.animation = "walk"
		velocity = velocity * speed
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.animation = "jump"
		velocity.y = -jump_speed
	move_and_slide()
