extends Node2D

var CloudScene = preload("res://assets/environment/cloud/cloud.tscn")
@export var columns_count: int = 15

func _ready():
	var level_width = self.get_viewport_rect().size.x*2
	var level_height = self.get_viewport_rect().size.y
	var column_size = level_width / columns_count
	
	for i in range(columns_count):
		var cloud = CloudScene.instantiate()
		
		var col_x = i * column_size
		cloud.position.x = randf_range(col_x - column_size/2, col_x + column_size/2)
		cloud.position.y = randf_range(0, level_height * 0.4)
		add_child(cloud)
		move_child(cloud, 1)
