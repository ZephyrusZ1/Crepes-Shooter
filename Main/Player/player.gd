extends Area2D

@export var speed = 400
var screen_size
@export var bullet_scene: PackedScene
@onready var bullet_origin = $Marker2D

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_just_pressed("shoot"):
		pass
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

signal hit 

func _on_body_entered(body: Node2D):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled","true")
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_origin.global_position
	bullet.global_rotation = bullet_origin.global_rotation
	get_parent().add_child(bullet)
