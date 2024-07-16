extends Node2D


@export var max_targets: int = 5
@onready var area_2d = $Area2D
@onready var line_2d = $Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawnLightning():
	getLightningPoint(position, 0)

func getLightningPoint(point: Vector2, hit_count: int) -> void:
	if (hit_count >= max_targets):
		return
	area_2d.position = point
	var areas = area_2d.get_overlapping_areas()
	if (areas.size() == 0):
		return
	var closest_target: Area2D = areas.pop_front()
	var closest_distance: float = INF
	for area in areas:
		var distance: float = area.position.distance_squared_to(point)
		if (distance < closest_distance):
			closest_distance = distance
			closest_target = area
	hitWithLightning(closest_target)
	return getLightningPoint(closest_target.position, hit_count + 1)
		
func hitWithLightning(target: Area2D):
	line_2d.add_point(target.position)




func _on_timer_timeout():
	spawnLightning()
