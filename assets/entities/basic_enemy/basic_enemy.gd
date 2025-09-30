extends CharacterBody2D
var health = 3
var speed = 250
var patrol_distance = 200
var detection_range = 400
var start_pos: Vector2
var direction = 1
var state = "patrol"
var at_boundary = false

func _ready() -> void:
	add_to_group("shootable")
	start_pos = position
	$AnimatedSprite2D.play()
func _physics_process(delta: float) -> void:
	match state:
		"patrol":
			patrol(delta)
			$AnimatedSprite2D.play("walk")
			check_for_player()
		"chase":
			chase_player(delta)
			$AnimatedSprite2D.play("walk")
		"attack":
			$AnimatedSprite2D.play("attack")

func patrol(_delta):
	velocity.x = direction * speed
	move_and_slide()
	
	if abs(position.x - start_pos.x) > patrol_distance and not at_boundary:
		direction *= -1
		$AnimatedSprite2D.flip_h = direction < 0
		at_boundary = true
		await get_tree().create_timer(2).timeout
		at_boundary = false

func check_for_player():
	var player = get_tree().get_root().get_node("Level/Player")
	if player and position.distance_to(player.position) <= detection_range:
		state = "chase"

func chase_player(_delta):
	var player = get_tree().get_root().get_node("Level/Player")
	if player:
		direction = 1 if (player.position.x > position.x) else -1
		$AnimatedSprite2D.flip_h = direction < 0
		velocity.x = direction * speed * 2
		move_and_slide()
		if position.distance_to(player.position) < 150:
			state = "attack"
		elif position.distance_to(player.position) > detection_range + 50:
			state = "patrol"
func attack_player():
		var player = get_tree().get_root().get_node("Level/Player")
		if player:
			player.hit()
	
func hit():
	health -= 1
	if health <= 0: queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "attack":
		state = "chase"
	attack_player()
