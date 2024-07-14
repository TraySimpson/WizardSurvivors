extends Area2D


@export var player_speed: int = 1



func _physics_process(delta):

	var velocity = Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	).normalized() * (player_speed * delta)

	position += velocity
