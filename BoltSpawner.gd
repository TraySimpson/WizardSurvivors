extends Node2D

signal bolt_spawned(BoltAttack, int)

@export var bolt_attack_prefab: PackedScene = null
@export var bolt_count: int = 1
	

func _on_cooldown_timer_timeout():
	for index in range(bolt_count):
		var bolt = bolt_attack_prefab.instantiate()
		get_tree().current_scene.add_child(bolt)
		bolt.position = owner.position
		bolt_spawned.emit(bolt, index)
