extends RigidBody2D
@export var quick_reload: PackedScene
@export var shotgun: PackedScene
@export var nade: PackedScene
@export var arrow: PackedScene
@onready var origin = $Marker2D
@export var upgrade: PackedScene
var yield_rate = 0.2
var shooter = false
signal death
var speed = 300
func _ready():
	var crepes_variants = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = crepes_variants.pick_random()
	$AnimatedSprite2D.play()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	killed()
	


func _on_body_entered(body: Node):
	killed()
	
	
func killed():
	death.emit()
	if randf() <= yield_rate :
		var pools = [nade, shotgun,  quick_reload]
		var pool_pick = pools.pick_random()
		if pool_pick:
			var drop = pool_pick.instantiate()
			drop.global_position = global_position
			get_tree().current_scene.call_deferred("add_child", drop)
	queue_free()
	if randf() <= 0.8:
		var ability = upgrade.instantiate()
		ability.global_position = global_position
		get_tree().current_scene.call_deferred("add_child", ability)
	queue_free()
	
func shooting():
	if randf() <= 0.3:
		shooter = true
	if shooter == true:
		var angle = [PI, 0, PI/2, -PI/2]
		for projectiles in angle:
			var arrows = arrow.instantiate()
			arrows.global_position = origin.global_position
			arrows.rotation += projectiles
			arrows.velocity = Vector2(speed, 0).rotated(projectiles)
			get_tree().current_scene.add_child(arrows)
		shooter = false

func _on_timer_timeout() -> void:
	shooting()


func _on_opt2():
	if yield_rate < 0.8:
		yield_rate += 0.05
