extends "base_ability.gd"

# preloads
const PowerBehaviorNeutral = preload("res://engine/dungobj/behaviors/power_behavior_neutral.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    summon.power_behavior = PowerBehaviorNeutral.new()
