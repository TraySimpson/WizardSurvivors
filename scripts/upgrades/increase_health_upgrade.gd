class_name IncreaseHealthUpgrade
extends UpgradeBase

@export var new_health: int = 100


func _apply(player: Player):
	var health = player.get_node("Health")
	if (health != null):
		health.increaseMaxHealth(new_health)
	else:
		print("Weapon not found!")
