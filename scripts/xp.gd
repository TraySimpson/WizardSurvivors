extends Area2D


func _on_area_entered(_area):
	print("+ xp!")
	queue_free()
