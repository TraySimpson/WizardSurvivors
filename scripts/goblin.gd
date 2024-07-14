extends Area2D


const xp_drop = preload("res://xp.tscn")

func _on_health_died():
	var xp = xp_drop.instantiate()
	get_tree().current_scene.add_child(xp)
	xp.position = position
	queue_free()
