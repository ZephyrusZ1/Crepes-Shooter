extends Area2D


# Called when the node enters the scene tree for the first time.
func _on_area_entered(area: Area2D):
	if area.name == "Player":
		area.explosives += 1
		area.explosives = true
		area.nade += 1
		area.queue_free()
