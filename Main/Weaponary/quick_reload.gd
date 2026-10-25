extends Area2D


# Called when the node enters the scene tree for the first time.



func _on_area_entered(area: Area2D):
	if area.name == "Player":
		area.bullet_count = 10
		area.update_counter()
		queue_free()
		
func auto_delete():
	await get_tree().create_timer(5).timeout
	queue_free()

func _ready():
	auto_delete()
