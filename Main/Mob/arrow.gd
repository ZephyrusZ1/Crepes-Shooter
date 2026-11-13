extends Area2D

var velocity = Vector2.ZERO
func _ready() -> void:
	show()



func _process(delta: float) -> void:
	global_position += velocity * delta

func warning():
	$Sprite2D.hide()
	$Line2D.show()
