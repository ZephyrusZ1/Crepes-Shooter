extends Area2D

@export var speed = 450
var screen_size
@export var bullet_scene: PackedScene
@export var grenade: PackedScene
@onready var bullet_origin = $Marker2D
@onready var shotgun_label = $CanvasLayer/Shotgun_mode
var shotgun_lock = true
var bullet_count = 10
var rel_delay = 2
var fire_rate = 1.2
var normal_fire_rate = 1.2
var delay = true
var delay2 = false
@onready var grenade_counter = $Grenade_count
var shotgun = 0
var shotgun_active = false
var unlock  = false
var nade = 1

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	shotgun_mode()
	shotgun_activation()
	EventBus.opt1.connect(_on_opt1)
	EventBus.opt3.connect(_on_opt3)
func _process(delta):
	if unlock == true:
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
				bullet_count -= 1
				delay = false
				update_counter()
				fire_bullet()
				await get_tree().create_timer(fire_rate).timeout
				delay = true
				
			else:
				pass
		if Input.is_action_just_pressed("reload"):
				bullet_count = 0
				update_counter()
				await get_tree().create_timer(rel_delay).timeout
				bullet_count = 10
				update_counter()
		if Input.is_action_just_pressed("shotgun_lock"):
			shotgun_lock = false
		if Input.is_action_just_pressed("nade") and nade > 0:
			nade -= 1
			throw_grenade()
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
		auto_shoot()
signal hit 

func _on_body_entered(body: Node2D):
	hide()
	hit.emit()
	shotgun = 0
	$CollisionShape2D.set_deferred("disabled","true")
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	bullet_count = 10
	update_counter()
func fire_bullet():
	if shotgun_active == true and shotgun_lock == false:
		var angle = [0.2, 0, -0.2]
		for pellets in angle:
			var bullet = bullet_scene.instantiate()
			bullet.global_position = bullet_origin.global_position
			bullet.look_at(get_global_mouse_position())
			bullet.rotation += pellets
			get_parent().add_child(bullet)
			shotgun -= 1
			shotgun_activation()
			if shotgun < 1:
				shotgun_active = false
				shotgun_lock = true
				shotgun_activation()
	else:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = bullet_origin.global_position
		bullet.look_at(get_global_mouse_position())
		get_parent().add_child(bullet)

func update_counter():
	grenade_counter.text = str(nade)
	

func shotgun_activation():
	if shotgun_active == true:
		shotgun_label.text = "Standby"
		shotgun_label.show()
	else:
		shotgun_label.text = "Inactive"
		shotgun_label.show()
func shotgun_mode():
	if shotgun > 0:
		shotgun_active = true


func auto_shoot():
	if delay == true:
		fire_bullet()
		delay = false
		await get_tree().create_timer(fire_rate).timeout
		delay = true

func throw_grenade():
	var explosives = grenade.instantiate()
	explosives.global_position = get_global_mouse_position()
	get_parent().add_child(explosives)
	explosives.thrown



func _on_area_entered(area: Area2D):
	hide()
	hit.emit()
	fire_rate = normal_fire_rate

func _on_opt1():
	if fire_rate > 0.3:
		fire_rate -= 0.05
		
func _on_opt3():
	if speed < 600:
		speed +=15
