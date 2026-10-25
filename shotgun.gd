extends Area2D



func _on_area_entered(area: Area2D):
	if area.name == "Player":
		area.shotgun += 1
		area.shotgun_active = true
		area.shotgun_activation()
		queue_free()
		
func auto_delete():
	await get_tree().create_timer(5).timeout
	queue_free()
func _ready():
	auto_delete()
