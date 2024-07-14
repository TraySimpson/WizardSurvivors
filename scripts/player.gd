extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed: int = 1
var velocity: Vector2 = Vector2.ZERO


func _process(delta):
	if (Input.is_action_just_pressed("test")):
		$Health.takeDamage(10)


func _physics_process(delta):
	velocity = Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	).normalized() * (player_speed * delta)
	if (velocity.x > 0):
		animated_sprite.flip_h = false
	elif (velocity.x < 0):
		animated_sprite.flip_h = true

	position += velocity


func _on_bolt_spawner_bolt_spawned(bolt: BoltAttack, index: int):
	if (velocity.is_zero_approx()):
		bolt.direction = Vector2(-1, 0) if animated_sprite.flip_h else Vector2(1, 0)
		_offsetByIndex(bolt, index)
		return
	bolt.direction = velocity.normalized()
	_offsetByIndex(bolt, index)
	
	
func _offsetByIndex(bolt: BoltAttack, index: int):
	if (index == 0):
		return
	var angle_increment = 5.0 * ((index + 1) / 2) * (1 if index % 2 == 1 else -1)
	var angle_radians = deg_to_rad(angle_increment)
	var rotated_direction = bolt.direction.rotated(angle_radians)
	bolt.direction = rotated_direction.normalized()
