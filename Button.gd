class_name UpgradeCell
extends Button

signal upgrade_selected(upgrade: UpgradeBase)

@export var upgrade: UpgradeBase = null
@onready var primary_icon = $PrimaryIcon
@onready var secondary_icon = $SecondaryIcon
@onready var title = $Title
@onready var description = $Description



func _ready():
	updateUI()

func updateUI():
	primary_icon.texture = upgrade.primary_icon
	secondary_icon.texture = upgrade.secondary_icon
	title.text = upgrade.name
	description.text = upgrade.description

func setUpgrade(newUpgrade: UpgradeBase):
	upgrade = newUpgrade
	updateUI()

func _on_pressed():
	upgrade_selected.emit(upgrade)
