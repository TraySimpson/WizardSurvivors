extends Node


const goblin_prefab = preload("res://goblin.tscn")

func _ready():
	$Goblin.setFollowTarget($Player)


func spawnGoblins():
	pass

func _on_goblin_spawn_cooldown_timeout():
	spawnGoblins()
