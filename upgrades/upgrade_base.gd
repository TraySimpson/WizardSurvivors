class_name UpgradeBase
extends Resource

@export var name: String = ""
@export_multiline var description: String = ""
@export var prerequesites: Array[UpgradeBase] = []
@export var primary_icon: AtlasTexture = null
@export var secondary_icon: AtlasTexture = null

func _apply(player: Player):
	pass
