extends Control

@onready var anim_sprite = $GameOverSprite
@onready var retry_button = $HBoxContainer/retry 
@onready var exit_button = $HBoxContainer/exit

func _ready():
	anim_sprite.play("default")
	retry_button.pressed.connect(_on_retry_pressed)
	exit_button.pressed.connect(_on_exit_pressed)  

func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://assets/ui/menu/main_menu.tscn")
