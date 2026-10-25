extends RigidBody2D
@export var shotgun: PackedScene




func _ready():
	var crepes_variants = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = crepes_variants.pick_random()
	$AnimatedSprite2D.play()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	killed()
	queue_free()
	

func _on_body_entered(body: Node):
	killed()
	queue_free()

func killed():
	if randf() <= 0.3 :
		var drop = shotgun.instantiate()
		drop.global_position = global_position
		get_tree().current_scene.call_deferred("add_child", drop)
	queue_free()
