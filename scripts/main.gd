extends Node2D

var score = 0
@export var mob_scene: PackedScene

func _ready():
	pass
	
func start_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func _on_score_timer_timeout() -> void:
	score += 1

func _on_mob_timer_timeout() -> void:
	# Instancia o inimigo
	var new_mob = mob_scene.instantiate()
	
	var path_follow_2d = $Path2D/PathFollow2D
	path_follow_2d.progress_ratio = randf()
	
	new_mob.position = path_follow_2d.position
	new_mob.rotation = path_follow_2d.rotation + PI / 2
	new_mob.rotation += randf_range(-PI/4, PI/4)
	
	var random_x = randf_range(100.0, 250.0)
	var velocity = Vector2(random_x, 0)
	new_mob.linear_velocity = velocity.rotated(new_mob.rotation)
	
	# Adiciona na cena
	add_child(new_mob)
	
	
func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()
