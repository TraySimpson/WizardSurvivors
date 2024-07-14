class_name BoltAttack
extends Area2D


@export var impact_damage: int  = 50
@export var bullet_speed: int = 200
@export var direction: Vector2 = Vector2(1,1)


func _physics_process(delta):
	position += delta * bullet_speed * direction

func _on_body_entered(body):
	print("Bolt collided!")
	for child in body.get_children():
		if child is Health:
			child.takeDamage(impact_damage)
			return


func _on_timer_timeout():
	queue_free()
