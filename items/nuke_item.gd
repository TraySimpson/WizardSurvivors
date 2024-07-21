extends Area2D


func _on_area_entered(area):
	get_tree().call_group("enemies", "die")
