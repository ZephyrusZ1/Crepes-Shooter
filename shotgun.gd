extends Area2D



func _on_area_entered(area: Area2D):
	if area.name == "Player":
		area.shoutgun += 1
		queue_free()
		
func auto_delete():
	await get_tree().create_timer(5).timeout
	queue_free()
func _ready():
	auto_delete()
