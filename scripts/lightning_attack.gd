extends Area2D


@export var max_targets: int = 15
@export var damage: int = 20
@export var radius: int = 300
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var line_2d = $Line2D
var hit_bodies = []
var lightning_ready: bool = true



func _ready():
	collision_shape.shape.radius = radius
	spawnLightning()

func _physics_process(delta):
	if (not lightning_ready):
		return
	spawnLightning()
	lightning_ready = false

func spawnLightning():
	line_2d.clear_points()
	line_2d.add_point(Vector2.ZERO)
	hit_bodies = []
	getLightningPoint(Vector2.ZERO, 0)
	line_2d.show()
	collision_shape.position = Vector2.ZERO
	$FlashTimer.start()

func getLightningPoint(point: Vector2, hit_count: int) -> void:
	if (hit_count >= max_targets):
		return
	collision_shape.position = point
	var collisions = get_overlapping_areas()
	if (get_overlapping_areas().size() == 0):
		return
	var closest_target: Area2D = collisions.pop_front()
	var closest_distance: float = INF
	for area in collisions:
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
	lightning_ready = true


func _on_flash_timer_timeout():
	line_2d.hide()
