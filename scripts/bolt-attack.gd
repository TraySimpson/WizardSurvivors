class_name BoltAttack
extends Area2D


@export var damage: int  = 50
@export var bullet_speed: int = 200
@export var direction: Vector2 = Vector2(1,1)
@export var max_penetrated_bodies: int = 1
var bodies_penetrated: int = 0


func _physics_process(delta):
	position += delta * bullet_speed * direction

func _on_body_entered(body):
	if (bodies_penetrated >= max_penetrated_bodies):
		queue_free()
		return
	for child in body.get_children():
		if child is Health:
			child.takeDamage(damage)
			increaseBodiesHit()
			return

func increaseBodiesHit():
	bodies_penetrated += 1
	if (bodies_penetrated >= max_penetrated_bodies):
		queue_free()

func _on_timer_timeout():
	queue_free()
