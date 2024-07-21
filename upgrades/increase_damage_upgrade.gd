class_name IncreaseDamageUpgrade
extends UpgradeBase

@export var weapon_name: String = ""
@export var damage_increase: int = 0
@export var damage_percent_increase: int = 0

func _apply(player: Player):
	var weapon = player.get_node(weapon_name)
	if (weapon != null):
		weapon.damage = weapon.damage + damage_increase + (weapon.damage * damage_percent_increase)
	else:
		print("Weapon not found!")
