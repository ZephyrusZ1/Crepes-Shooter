extends Node

@export var mob_scene: PackedScene
var score
var mob_count = 0


func game_over():
	$Score_timer.stop()
	$Mob_timer.stop()
	$HUD.show_game_over()
func new_game():
	score = 0
	$Player.start($Start_post.position)
	$Start_timer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_loc = $Crepes_path/Spawn_locat
	mob_spawn_loc.progress_ratio = randf()
	mob.position = mob_spawn_loc.position
	
	var direction = mob_spawn_loc.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4  )
	mob.rotation = direction
	
	var velocity =Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)
	mob_count += 1
	


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$Mob_timer.start()
	$Score_timer.start()
	
func _ready():
	pass
