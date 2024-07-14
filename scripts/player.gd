extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed: int = 1



func _process(delta):
	if (Input.is_action_just_pressed("test")):
		print("Hit test")
		$Health.takeDamage(10)

func _physics_process(delta):

	var velocity = Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	).normalized() * (player_speed * delta)
	if (velocity.x > 0):
		animated_sprite.flip_h = false
	elif (velocity.x < 0):
		animated_sprite.flip_h = true

	position += velocity
