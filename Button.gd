extends Button


@export var upgrade: UpgradeBase = null
@onready var primary_icon = $PrimaryIcon
@onready var secondary_icon = $"Secondary Icon"
@onready var title = $Title
@onready var description = $Description

# Called when the node enters the scene tree for the first time.
func _ready():
	primary_icon.texture = upgrade.primary_icon
	secondary_icon.texture = upgrade.secondary_icon
	title.text = upgrade.name
	description.text = upgrade.description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
