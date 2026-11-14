extends Area2D

@export var bullet: PackedScene
@onready var origin: PackedScene


func _on_area_entered(area: Area2D):
	if area.name == "Player":
		var angle = [0, PI, PI/2, -PI/2]
		var speed = 800
		for projectiles in angle:
			var bullets = bullet.instantiate()
			bullets.global_position = global_position
			bullets.rotation += projectiles
			get_tree().current_scene.call_deferred("add_child", bullets)
		
		queue_free()
			
func auto_delete():
	await get_tree().create_timer(5).timeout
	queue_free()

func _ready():
	auto_delete()
