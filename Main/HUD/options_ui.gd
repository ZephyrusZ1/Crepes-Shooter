extends CanvasLayer

@onready var button_1 = $Control/Button1
@onready var button_2 = $Control/Button2
@onready var button_3 = $Control/Button3

var options = [{"signal": EventBus.opt1, "text": "Fire rate"},
	{"signal": EventBus.opt2, "text": "Yield rate"},
	{"signal": EventBus.opt3, "text": "Speed"},]
var opt1: Signal
var opt2: Signal
var opt3: Signal

func randomizer():
	options.shuffle()
	var option_1 = options[0]
	var option_2 = options[1]
	var option_3 = options[2]
	opt1 = option_1["signal"]
	opt2 = option_2["signal"]
	opt3 = option_3["signal"]
	button_1.text = option_1["text"]
	button_2.text = option_2["text"]
	button_3.text = option_3["text"]
	
func _ready() -> void:
	show()
	randomizer()
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
