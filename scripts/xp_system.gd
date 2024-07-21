extends Node

signal leveled_up(level: int)

const FIRST_LEVEL_XP_AMOUNT = 100
var current_xp: int = 0
var current_level: int = 1
var xp_for_next_level: int = FIRST_LEVEL_XP_AMOUNT
var multiplier_for_xp_level: float = 1.5

func addXp(xp: int):
	current_xp += xp
	while (current_xp >= xp_for_next_level):
		levelUp()

func levelUp():
	current_level += 1
	current_xp = clamp(current_xp - xp_for_next_level, 0, INF)
	xp_for_next_level = int(xp_for_next_level * multiplier_for_xp_level)
	leveled_up.emit(current_level)

func restartXp():
	setLevel(1)

func setLevel(level: int):
	current_level = level
	current_xp = 0
	xp_for_next_level = FIRST_LEVEL_XP_AMOUNT * pow(multiplier_for_xp_level, (current_level - 1)) 
