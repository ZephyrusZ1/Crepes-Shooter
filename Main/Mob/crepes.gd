extends RigidBody2D

func _ready():
	var crepes_variants = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = crepes_variants.pick_random()
	$AnimatedSprite2D.play()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_body_entered(body: Node):
	queue_free()
