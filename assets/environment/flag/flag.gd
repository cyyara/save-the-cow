extends Area2D
@export_enum("move", "jump", "shoot", "off") var message:String = "off"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("off")
	$Message.hide()
func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.animation = "on"
		$Message.show()
		$Message.play(message)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$Message.hide()
