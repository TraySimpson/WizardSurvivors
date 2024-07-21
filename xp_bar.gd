extends ProgressBar

func _ready():
	XpSystem.xp_changed.connect(handleXpChanged)
	
func handleXpChanged(xpRatio: float):
	value = xpRatio
