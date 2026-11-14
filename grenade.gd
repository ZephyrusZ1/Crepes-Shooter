extends Area2D
@onready var collision_shape = $CollisionShape2D


func _ready() -> void:
	hide()
	thrown()
func thrown():
	show()
	$Sprite2D.show()
	$AnimatedSprite2D.hide()
	collision_shape.set_deferred("disabled", true)
	await get_tree().create_timer(3).timeout
	collision_shape.set_deferred("disabled", false)
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("Kaboom!")
	await $AnimatedSprite2D.animation_finished
	queue_free()
	$AnimatedSprite2D.stop()


func _on_body_entered(body: Node2D):
	body.killed()
	body.queue_free()
	
