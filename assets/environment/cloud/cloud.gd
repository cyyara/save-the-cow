extends Sprite2D
@export var random_textures: Array[SpriteFrames]

func _ready() -> void:
	if random_textures.size() > 0:
		texture = random_textures.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
