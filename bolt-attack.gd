class_name BoltAttack
extends Area2D


@export var impact_damage: int  = 50


func _on_body_entered(body):
	for child in body.get_children():
		if child is Health:
			child.takeDamage(impact_damage)
			return


func _on_timer_timeout():
	queue_free()
