extends Area2D

@export var attack_damage: int = 10
@export var attack_cooldown: float = .25
const xp_drop = preload("res://xp.tscn")
var can_attack: bool = true
var is_attacking: bool = false
var attacked_target = null


func _ready():
	$AttackCooldown.wait_time = attack_cooldown
	can_attack = true

func _on_health_died():
	var xp = xp_drop.instantiate()
	get_tree().current_scene.add_child(xp)
	xp.position = position
	queue_free()
	
func attack(target):
	target.takeDamage(attack_damage)
	can_attack = false
	is_attacking = true
	$AttackCooldown.start()

func _on_area_entered(body):
	if (not can_attack):
		return
	for child in body.get_children():
		if child is Health:
			attack(child)
			attacked_target = child
			return

func _on_attack_cooldown_timeout():
	can_attack = true
	if (is_attacking):
		attack(attacked_target)

func _on_area_exited(area):
	is_attacking = false
	attacked_target = null
