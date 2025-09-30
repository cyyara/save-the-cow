extends CharacterBody2D
class_name Player
@export var default_speed = 400
var speed = default_speed
@export var jump_speed = 400
@export var gravity = 1000
var jump_count = 0
@export var PUSH_STRENGTH = 300
var max_health = 3
var health = max_health
var max_bullets = 6
var bullets = max_bullets

var BulletScene = preload("res://assets/items/bullet/bullet.tscn")
var shooting = false
var receiving_damage = false
func _ready() -> void:
	add_to_group("shootable")
	$AnimatedSprite2D.play("idle")
	
	var heart_container = get_tree().current_scene.get_node("UI/Hearts")
	var bullet_container = get_tree().current_scene.get_node("UI/Bullets")
	
	var heart_on_texture = preload("res://assets/ui/heart/remaining.png")
	var bullet_on_texture = preload("res://assets/ui/bullet/on.png")
	var h_pos = Vector2(55, 665)
	var b_pos = Vector2(1225, 665)
	
	for i in range(max_health):
		var h = Sprite2D.new()
		h.texture = heart_on_texture
		h.position = h_pos
		h_pos.x += 55
		heart_container.add_child(h)
	for i in range(max_bullets):
		var b = Sprite2D.new()
		b.texture = bullet_on_texture
		b.position = b_pos
		b_pos.x -= 55
		bullet_container.add_child(b)
	
		
func _physics_process(delta: float) -> void:
	var input_x = Input.get_axis("move_left", "move_right")
	var can_jump = jump_count < 2
	
	if is_on_floor():
		jump_count = 0
		velocity.y = 0

	if shooting or receiving_damage:
		pass
	elif Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = -jump_speed
		jump_count += 1
	elif not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0 and jump_count == 2:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("fall")
	elif input_x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	
	var can_shoot = is_on_floor() and not shooting and not receiving_damage and bullets > 0
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shooting = true
		speed *= 0.6
		$AnimatedSprite2D.play("shoot")

	velocity.x = input_x * speed
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	move_and_slide()
	
	if input_x != 0:
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var body = collision.get_collider()
			
			if body is Crate or body is Barrel:
				var normal = collision.get_normal()
			
				if sign(input_x) == -sign(normal.x):
					body.linear_velocity.x = input_x * PUSH_STRENGTH

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "shoot":
		shooting = false
		speed = default_speed
		var bullet = BulletScene.instantiate()
		bullet.position = global_position
		if $AnimatedSprite2D.flip_h:
			bullet.get_child(0).flip_h = true
			bullet.direction = Vector2.LEFT
			bullet.position += Vector2(-70, -16)
		else:
			bullet.get_child(0).flip_h = false
			bullet.direction = Vector2.RIGHT
			bullet.position += Vector2(70, -16)
		get_tree().current_scene.add_child(bullet)
		bullets -= 1
		
		var bullet_container = get_tree().current_scene.get_node("UI/Bullets")
		var bullet_off_texture = preload("res://assets/ui/bullet/off.png")
		
		bullet_container.get_child(bullets).texture = bullet_off_texture
	
	if $AnimatedSprite2D.animation == "hurt":
		var heart_container = get_tree().current_scene.get_node("UI/Hearts")
		var heart_off_texture = preload("res://assets/ui/heart/lost.png")

		health -= 1
		heart_container.get_child(health).texture = heart_off_texture
		get_tree().set_meta("last_scene", get_tree().current_scene.scene_file_path)
		if health <= 0: get_tree().change_scene_to_file("res://assets/ui/game_over/game_over_menu.tscn")
		receiving_damage = false
		
func hit():
	if not receiving_damage:
		$AnimatedSprite2D.play("hurt")
		receiving_damage = true


func _on_texture_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
