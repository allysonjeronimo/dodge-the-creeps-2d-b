extends RigidBody2D

func _ready():
	var animation_names = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var animation_index = randi() % animation_names.size()
	$AnimatedSprite2D.play(animation_names[animation_index])
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
