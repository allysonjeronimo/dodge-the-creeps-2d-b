extends Node2D

var score = 0
@export var mob_scene: PackedScene
	
func start_game():
	score = 0
	get_tree().call_group("mob", "queue_free")
	$BackMusic.play()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BackMusic.stop()
	$GameOverSound.play()
	
func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	# Instancia o inimigo
	var new_mob = mob_scene.instantiate()
	
	# Path2D e PathFollow2D permite obter uma posição ao redor da tela
	var path_follow_2d = $Path2D/PathFollow2D
	# randf() gera valor aleatório entre 0 e 1
	path_follow_2d.progress_ratio = randf()
	
	# radianos != graus
	# define rotação dos inimigos
	new_mob.position = path_follow_2d.position
	new_mob.rotation = path_follow_2d.rotation + PI / 2
	new_mob.rotation += randf_range(-PI/4, PI/4)
	
	# define movimentação
	var random_x = randf_range(100.0, 250.0)
	var velocity = Vector2(random_x, 0)
	new_mob.linear_velocity = velocity.rotated(new_mob.rotation)
	
	# Adiciona na cena
	add_child(new_mob)
	
func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()
