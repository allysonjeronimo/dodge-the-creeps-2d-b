extends Node2D

var score = 0
@export var mob_scene: PackedScene

func _ready():
	$StartTimer.start()
	
func start_game():
	pass
	
func game_over():
	pass
	
func _on_score_timer_timeout() -> void:
	score += 1

func _on_mob_timer_timeout() -> void:
	var new_mob = mob_scene.instantiate()
	
	var path_follow_2d = $Path2D/PathFollow2D
	path_follow_2d.progress_ratio = randf()
	
	new_mob.position = path_follow_2d.position
	new_mob.rotation = path_follow_2d.rotation + PI / 2
	
	var velocity = Vector2(250.0 , 0)
	new_mob.linear_velocity = velocity.rotated(new_mob.rotation)
	add_child(new_mob)
	
	
func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()
