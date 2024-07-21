extends Node

@export var upgrades: Array[UpgradeBase] = []
@export var player: Player = null

@onready var ui = $UI
@onready var available_upgrades = $AvailableUpgrades


func _ready():
	XpSystem.leveled_up.connect(handleLevelUp)

func handleLevelUp(_level):
	print("Showing upgrades!")

func applyUpgrade(upgrade: UpgradeBase):
	upgrade._apply(player)

