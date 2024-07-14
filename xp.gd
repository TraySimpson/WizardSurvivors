extends Area2D


func _on_area_entered(area):
	print("+ xp!")
	queue_free()
