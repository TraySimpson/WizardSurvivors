extends Node2D


@export var radius: int = 250
@export var damage: int = 1
@export var cooldown_time: float = .33
@onready var shape_cast = $ShapeCast2D
@onready var timer = $Timer


func _ready():
	shape_cast.shape.radius = radius
	timer.wait_time = cooldown_time

func _on_timer_timeout():
	var hitCount: int = shape_cast.get_collision_count()
	print("Hit: " + str(hitCount))
	for hitIndex in range(hitCount):
		var hit = shape_cast.get_collider(hitIndex)
		applyDamage(hit)

func applyDamage(target):
	if (target == null):
		return
	for child in target.get_children():
		if child is Health:
			child.takeDamage(damage)
			return
