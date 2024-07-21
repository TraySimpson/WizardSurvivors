extends Node


const goblin_prefab = preload("res://goblin.tscn")
var spawn_pos: PathFollow2D = null



func _ready():
	spawn_pos = $Player/GoblinSpawns/GoblinSpawnPos
	$UpgradeSystem.player = $Player

func spawnGoblins():
	spawnGoblin()
	
func spawnGoblin():
	spawn_pos.progress_ratio = randf()
	var goblin = goblin_prefab.instantiate()
	goblin.setFollowTarget($Player)
	add_child(goblin)
	goblin.position = spawn_pos.global_position

func _on_goblin_spawn_cooldown_timeout():
	spawnGoblins()
