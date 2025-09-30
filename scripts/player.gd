extends Area2D

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta: float):
	var velocity = Vector2.ZERO #(1,0)
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	if velocity.y != 0:
		$AnimatedSprite2D.play("up")
		
			
	position += velocity * speed * delta
	
