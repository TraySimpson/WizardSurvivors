class_name AddWeaponUpgrade
extends UpgradeBase

@export var weaponName: String = ""
@export var weaponToAdd: PackedScene = null
@export var positionOffset: Vector2 = Vector2.ZERO


func _apply(player: Player):
	var weapon: Node2D = weaponToAdd.instantiate()
	weapon.name = weaponName
	player.add_child(weapon)
	weapon.position = positionOffset
