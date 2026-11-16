extends Area2D


@export var options: PackedScene



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_entered(area: Area2D):
	if area.name == "Player":
		options_called()
		queue_free()
	
func options_called():
	if options != null:
		var ability = options.instantiate()
		get_tree().current_scene.call_deferred("add_child", ability)
		
func auto_delete():
	await get_tree().create_timer(5).timeout
	queue_free()

func _ready():
	auto_delete()
