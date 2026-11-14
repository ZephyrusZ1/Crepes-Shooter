extends Area2D

var velocity = Vector2.ZERO
@onready var collision_shape = $CollisionShape2D
var fire = false


func _ready() -> void:
	warning()
	show()


func _process(delta: float) -> void:
	if fire == true:
		global_position += velocity * delta


func warning():
	$Sprite2D.hide()
	$Line2D.show()
	collision_shape.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	$Sprite2D.show()
	$Line2D.hide()
	collision_shape.set_deferred("disabled", false)
	fire = true
	
