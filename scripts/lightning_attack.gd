extends Node2D


@export var max_targets: int = 5
@export var damage: int = 5
@onready var shapecast: ShapeCast2D = $ShapeCast2D
@onready var line_2d = $Line2D
var hit_bodies = []



func _ready():
	line_2d.clear_points()
	line_2d.add_point(Vector2.ZERO)
	line_2d.add_point(Vector2(100, 100))
	
func _process(delta):
	pass


func spawnLightning():
	line_2d.clear_points()
	line_2d.add_point(Vector2.ZERO)
	hit_bodies = []
	getLightningPoint(Vector2.ZERO, 0)
	shapecast.position = Vector2.ZERO

func getLightningPoint(point: Vector2, hit_count: int) -> void:
	if (hit_count >= max_targets):
		return
	shapecast.position = point
	var collidedCount = shapecast.get_collision_count()
	if (collidedCount == 0):
		return
	print("Hit with lightning: " + str(collidedCount) + " on recursive layer: " + str(hit_count))
	var closest_target: Area2D = shapecast.get_collider(0)
	var closest_distance: float = INF
	for index in range(1, collidedCount):
		var area = shapecast.get_collider(index)
		var distance: float = to_local(area.global_position).distance_squared_to(point)
		if (distance < closest_distance && not hit_bodies.has(area)):
			closest_distance = distance
			closest_target = area
	if (hit_bodies.has(closest_target)):
		return
	hitWithLightning(closest_target)
	return getLightningPoint(to_local(closest_target.global_position), hit_count + 1)
		
func hitWithLightning(target: Area2D):
	hit_bodies.append(target)
	line_2d.add_point(to_local(target.global_position))
	for child in target.get_children():
		if child is Health:
			child.takeDamage(damage)
			return

func _on_timer_timeout():
	spawnLightning()
