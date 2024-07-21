class_name Health
extends Node2D


signal health_changed(int)
signal died

@export var max_health: int
@onready var health_bar: ProgressBar = $HealthBar
var current_health: int


func _ready():
	current_health = max_health
	health_bar.max_value = max_health
	updateHealthBar()
	health_bar.hide()

func takeDamage(damage: int) -> void:
	current_health -= damage
	health_changed.emit(-damage)
	if current_health <= 0:
		died.emit()
	updateHealthBar()
		
func healHealth(heal_points: int) -> void:
	current_health = clamp(current_health + heal_points, 1, max_health)
	health_changed.emit(heal_points)
	updateHealthBar()

func increaseMaxHealth(new_health: int) -> void:
	max_health = new_health
	healHealth(new_health)

func updateHealthBar() -> void:
	$Timer.stop()
	#var ratio = float(current_health) / float(max_health)
	#var color = Color.LIME_GREEN
# TODO fix so this isn't a global resource, currently all health bars update to the same color
	#match(true):
		#true when ratio > .5:
			#color = Color.LIME_GREEN
		#true when ratio > .2:
			#color = Color.YELLOW
		#true when current_health > 0:
			#color = Color.CRIMSON
		#_ :
			#color = Color.BLACK
	#health_bar.get("theme_override_styles/fill").bg_color = color
	health_bar.value = current_health
	health_bar.show()
	if (current_health == max_health):
		$Timer.wait_time = 1
		$Timer.start()
	


func _on_timer_timeout():
	health_bar.hide()
