extends Area2D

@export var size_radius: float = 1
@export var orbit_radius: int = 120
@export var rotation_speed: int = 5
@export var damage: int = 5
@export var cooldown_time: int = 5
@export var max_hits_before_cooldown: int = 20
var current_hits: int = 0
var is_cooling_down: bool = false

@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var cooldown_timer = $CooldownTimer



func _ready():
	cooldown_timer.wait_time = cooldown_time
	startAttack()


func _process(delta):
	if (is_cooling_down):
		return
	rotation += rotation_speed * delta
	
func startAttack():
	collision_shape.position = Vector2(0, -orbit_radius)
	animated_sprite.position = Vector2(0, -orbit_radius)
	collision_shape.disabled = false
	animated_sprite.show()
	current_hits = 0
	is_cooling_down = false

func startCooldown():
	collision_shape.disabled = true
	animated_sprite.hide()
	cooldown_timer.start()
	is_cooling_down = true

func _on_body_entered(body):
	for child in body.get_children():
		if child is Health:
			child.takeDamage(damage)
			current_hits += 1
			if (current_hits >= max_hits_before_cooldown):
				startCooldown()
			return


func _on_cooldown_timer_timeout():
	startAttack()
