extends AnimatedSprite2D
func _ready():
	randomize()
	frame = randi_range(0, sprite_frames.get_frame_count(animation) - 1)
	play()
