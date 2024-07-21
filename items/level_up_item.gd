extends Area2D


func _on_area_entered(area):
	XpSystem.levelUp()
	queue_free()
