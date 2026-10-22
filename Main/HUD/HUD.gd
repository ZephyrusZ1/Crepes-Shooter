extends CanvasLayer

signal start_game

func show_message(text):
	$Message_label.text = text
	$Message_label.show()
	$Message_timer.start()

func show_game_over():
	show_message("Game Over")
	await $Message_timer.timeout
	
	$Message_label.text = "Dodge EM!"
	$Message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	$Start.show()
func update_score(score):
	$Score_label.text = str(score)

func _on_start_pressed():
	$Start.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message_label.hide()
