extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var attack_damage: int = 10
@export var attack_cooldown: float = .25
@export var move_speed: int = 50
const xp_drop = preload("res://xp.tscn")
var can_attack: bool = true
var is_attacking: bool = false
var attacked_target = null
var follow_target = null


func _ready():
	$AttackCooldown.wait_time = attack_cooldown
	can_attack = true
	
func _physics_process(delta):
	if (follow_target != null):
		var move_direction = move_speed * delta * (follow_target.position - position).normalized()
		position += move_direction
		if (move_direction.x > 0):
			animated_sprite.flip_h = false
		elif (move_direction.x < 0):
			animated_sprite.flip_h = true
	

func _on_health_died():
	call_deferred("spawnXp")
	
func spawnXp():
	var xp = xp_drop.instantiate()
	get_tree().current_scene.add_child(xp)
	xp.position = position
	queue_free()
	
func setFollowTarget(target):
	follow_target = target
	
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
	#can_attack = trues
	if (is_attacking):
		attack(attacked_target)

func _on_area_exited(_area):
	is_attacking = false
	attacked_target = null
