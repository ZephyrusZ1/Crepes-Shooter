extends Area2D

@export var speed = 450
var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _physics_process(delta):
	position += transform.x * speed * delta
	
	
func _on_body_entered(body: Node):
	queue_free()
	body.queue_free()
	



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
