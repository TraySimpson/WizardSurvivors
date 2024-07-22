extends Node

@export var all_upgrades: Array[UpgradeBase] = []
@export var player: Player = null

@onready var ui: CanvasLayer = $UI


var appliedUpgrades: Array[UpgradeBase] = []


func _ready():
	XpSystem.leveled_up.connect(handleLevelUp)
	loadUpgrades()
	ui.hide()
	
func loadUpgrades():
	all_upgrades = parse_directory_for_resources("res://upgrades")
	print("Loaded " + str(all_upgrades.size()) + " upgrades")

func parse_directory_for_resources(directory_path: String) -> Array[UpgradeBase]:
	var resources: Array[UpgradeBase] = []
	var dir = DirAccess.open(directory_path)
	
	if dir:
		dir.list_dir_begin()  # Begin listing the directory with hidden files and directories
		var file_name = dir.get_next()

		while file_name != "":
			var file_path = directory_path + "/" + file_name
			# Dumb fix for exporting
			print("Parsing: " + file_path)
			if file_path.ends_with(".remap"):
				file_path = file_path.replace(".remap", "")
				print("Trimmed to: " + file_path)
			if dir.current_is_dir():
				if file_name != "." and file_name != "..":  # Skip the current and parent directory references
					resources += parse_directory_for_resources(file_path)  # Recursively parse subdirectories
			elif file_name.ends_with("tres"):
				var resource = ResourceLoader.load(file_path)
				if resource:
					resources.append(resource)
			file_name = dir.get_next()

		dir.list_dir_end()

	return resources

func handleLevelUp(_level):
	get_tree().paused = true
	showUpgradeUI()

func showUpgradeUI():
	var upgrades = getAvailableUpgrades()
	var index := 0
	if (upgrades.size() == 0):
		get_tree().paused = false
		return
	upgrades.shuffle()
	for upgradeCell in ui.get_children():
		if (upgrades.size() > index):
			upgradeCell.setUpgrade(upgrades[index])
			upgradeCell.show()
		else:
			upgradeCell.hide()
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
