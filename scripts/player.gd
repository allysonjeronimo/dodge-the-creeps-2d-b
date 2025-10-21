extends Area2D

signal hit

@export var speed = 400
var screen_size

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _process(delta: float):
	var velocity = Vector2.ZERO 
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() != 0:
		if velocity.x != 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = velocity.x < 0
			$AnimatedSprite2D.flip_v = false
		if velocity.y != 0:
			$AnimatedSprite2D.play("up")
			$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.stop()
		
			
	position += velocity * speed * delta
	
	position = position.clamp(Vector2.ZERO, screen_size)
	
func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	hide()
	$CollisionShape2D.set_deferred("disabled", false)
