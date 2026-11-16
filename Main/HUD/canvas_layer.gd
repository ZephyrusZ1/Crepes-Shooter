extends CanvasLayer


var opt1 = EventBus.opt1
var opt2 = EventBus.opt2
var opt3 = EventBus.opt3
var options = [opt1, opt2, opt3]
func _ready() -> void:
	show()
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_1_pressed() -> void:
	opt1.emit()
	get_tree().paused = false
	queue_free()

func _on_button_2_pressed() -> void:
	get_tree().paused = false
	opt2.emit()
	queue_free()


func _on_button_3_pressed() -> void:
	get_tree().paused = false
	opt3.emit()
	queue_free()
