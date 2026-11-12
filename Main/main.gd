extends Node

@export var mob_scene: PackedScene
var score = 0
var count = 20
var mob_count = 0




func new_game():
	score = 0
	$Player.start($Start_post.position)
	$Start_timer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("Crepeses", "queue_free")
	$BGM.play()
	$Player.unlock = true
	get_tree().call_group("Power_up", "queue_free")
	get_tree().call_group("Shotgun", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	mob_count = 0


func _on_start_timer_timeout():
	$Mob_timer.start()
	$Score_timer.start()
	

	
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	if mob_count < count:
		add_child(mob)
		mob_count += 1
	mob.death.connect(_on_death)
	var mob_spawn_loc = $Crepes_path/Spawn_locat
	mob_spawn_loc.progress_ratio = randf()
	mob.position = mob_spawn_loc.position
	
	var direction = mob_spawn_loc.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4  )
	mob.rotation = direction
	
	var velocity =Vector2(randf_range(250, 300), 0)
	mob.linear_velocity = velocity.rotated(direction)
	

#game over
func _on_player_hit():
	$Score_timer.stop()
	$Mob_timer.stop()
	$HUD.show_game_over()
	$Death.play()
	$BGM.stop()
	
func _on_death():
	score += 1
	$HUD.update_score(score)
	mob_count -= 1
