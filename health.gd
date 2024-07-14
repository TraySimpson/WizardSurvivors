extends Node2D


signal health_changed(int)
signal died

@export var max_health: int
@onready var health_bar = $HealthBar
@onready var health_bar_value = $HealthBar/HealthBarValue
var current_health: int


func _ready():
	current_health = max_health
	health_bar.hide()

func takeDamage(damage: int) -> void:
	print("Taking damage!")
	current_health -= damage
	health_changed.emit(-damage)
	if current_health <= 0:
		died.emit()
	updateHealthBar()
		
func healHealth(heal_points: int) -> void:
	current_health = clamp(current_health + heal_points, 1, max_health)
	health_changed.emit(heal_points)
	updateHealthBar()

func updateHealthBar() -> void:
	var ratio = float(current_health) / float(max_health)
	match(true):
		true when ratio > .5:
			health_bar_value.color = Color.LIME_GREEN
		true when ratio > .2:
			health_bar_value.color = Color.YELLOW
		true when current_health > 0:
			health_bar_value.color = Color.DARK_RED
		_ :
			health_bar_value.color = Color.BLACK
	health_bar.show()
