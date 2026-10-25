extends Area2D

@export var speed = 400
var screen_size
@export var bullet_scene: PackedScene
@onready var bullet_origin = $Marker2D

var bullet_count = 10
var rel_delay = 2
var fire_rate = 0.8
var delay = true
var delay2 = false
@onready var bullet_counter = $Bullet_count

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
		 
		if bullet_count > 0 and delay == true:
			fire_bullet()
			bullet_count -= 1
			delay = false
			update_counter()
			await get_tree().create_timer(fire_rate).timeout
			delay = true
		else:
			pass
	if Input.is_action_just_pressed("reload"):
			bullet_count = 0
			update_counter()
			await get_tree().create_timer(rel_delay).timeout
			bullet_count += 10
			update_counter()
		
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
	queue_free()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled","true")
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_origin.global_position
	bullet.look_at(get_global_mouse_position())
	get_parent().add_child(bullet)

func update_counter():
	bullet_counter.text = str(bullet_count)
	$Bullet_count.show()
