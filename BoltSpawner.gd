extends Node2D

signal bolt_spawned(BoltAttack)

@export var bolt_attack_prefab: PackedScene = null
	

func _on_cooldown_timer_timeout():
	var bolt = bolt_attack_prefab.instantiate()
	get_tree().current_scene.add_child(bolt)
	bolt.transform = owner.transform
	bolt_spawned.emit(bolt)
