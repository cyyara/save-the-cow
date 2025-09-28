extends CharacterBody2D

@export var speed = 200
@export var jump_speed = 400
@export var gravity = 1000
var jump_count = 0
@export var PUSH_STRENGTH = 400

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	var input_x = Input.get_axis("move_left", "move_right")
	var can_jump = jump_count < 2
	
	if is_on_floor():
		jump_count = 0
		velocity.y = 0
	
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = -jump_speed
		jump_count += 1

	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0 and jump_count == 2:
			$AnimatedSprite2D.animation = "jump"
		else:
			$AnimatedSprite2D.animation = "fall"
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "idle"

	velocity.x = input_x * speed

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	move_and_slide()
	
	if input_x != 0:
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var body = collision.get_collider()
			
			if body is Crate:
				var normal = collision.get_normal()
			
				if sign(input_x) == -sign(normal.x):
					body.linear_velocity.x = input_x * PUSH_STRENGTH
