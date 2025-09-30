extends Sprite2D
@export var random_textures: Array[Texture2D]

func _ready() -> void:
	if random_textures.size() > 0:
		texture = random_textures.pick_random()
