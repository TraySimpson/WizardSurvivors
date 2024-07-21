extends Area2D

@export var healing_points: int = 10

func _on_area_entered(area):
	for child in area.get_children():
		if child is Health:
			child.healHealth(healing_points)
			break
	queue_free()
