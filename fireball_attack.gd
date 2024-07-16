extends Area2D

@export var size_radius: float = 1
@export var orbit_radius: int = 120
@export var rotation_speed: int = 5
@export var damage: int = 5
@export var cooldown_time: int = 5
@export var max_hits_before_cooldown: int = 20
var current_hits: int = 0

@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D



func _ready():
	startAttack()


func _process(delta):
	rotation += rotation_speed * delta
	
func startAttack():
	collision_shape.position = Vector2(0, -orbit_radius)
	animated_sprite.position = Vector2(0, -orbit_radius)
	current_hits = 0


func _on_body_entered(body):
	for child in body.get_children():
		if child is Health:
			child.takeDamage(damage)
			current_hits += 1
			return
