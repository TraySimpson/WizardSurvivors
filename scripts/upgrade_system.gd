extends Node

@export var all_upgrades: Array[UpgradeBase] = []
@export var player: Player = null

@onready var ui: CanvasLayer = $UI
@onready var available_upgrades = $AvailableUpgrades

var appliedUpgrades: Array[UpgradeBase] = []


func _ready():
	XpSystem.leveled_up.connect(handleLevelUp)

func handleLevelUp(_level):
	get_tree().paused = true
	showUpgradeUI()

func showUpgradeUI():
	var upgrades = getAvailableUpgrades()
	# TODO get random 3
	var index := 0
	for upgradeCell in ui.get_children():
		if (upgrades.size() > index):
			upgradeCell.setUpgrade(upgrades[index])
		else:
			upgradeCell.hide()
		upgradeCell.show()
		index += 1
	ui.show()

func applyUpgrade(upgrade: UpgradeBase):
	upgrade._apply(player)
	appliedUpgrades.append(upgrade)
	get_tree().paused = false
	ui.hide()

func getAvailableUpgrades() -> Array[UpgradeBase]:
	var availableUpgrades: Array[UpgradeBase] = []
	for upgrade in all_upgrades:
		if (canApplyUpgrade(upgrade)):
			availableUpgrades.append(upgrade)
	return availableUpgrades
	
func canApplyUpgrade(upgrade: UpgradeBase) -> bool:
	if (appliedUpgrades.has(upgrade)):
		return false
	for prereq in upgrade.prerequesites:
		if (not appliedUpgrades.has(prereq)):
			return false
	return true
