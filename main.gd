extends Node


const goblin_prefab = preload("res://goblin.tscn")
var spawn_pos: PathFollow2D = null



func _ready():
# TODO figure out spawn pos that moves with camera
	spawn_pos = $Player/Camera2D/GoblinSpawns/GoblinSpawnPos
	spawnGoblin()
	spawnGoblin()
	spawnGoblin()

func spawnGoblins():
	spawnGoblin()
	
func spawnGoblin():
	spawn_pos.progress_ratio = randf()
	var goblin = goblin_prefab.instantiate()
	goblin.setFollowTarget($Player)
	add_child(goblin)
	goblin.position = spawn_pos.position

func _on_goblin_spawn_cooldown_timeout():
	spawnGoblins()
