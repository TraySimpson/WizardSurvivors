class_name Xp
extends Area2D


@export var xp: int = 1

func _on_area_entered(_area):
	XpSystem.addXp(xp)
	queue_free()
