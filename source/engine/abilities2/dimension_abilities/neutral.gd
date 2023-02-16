extends "res://engine/abilities2/dimension_ability.gd"

# preloads
const PowerBehaviorNeutral = preload("res://engine/dungobj/behaviors/power_behavior_neutral.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.power_behavior = PowerBehaviorNeutral.new()
