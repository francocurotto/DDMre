extends "base_ability.gd"

# preloads
const AdvantageBehaviorNeutral = preload("res://engine/dungobj/behaviors/advantage_behavior_neutral.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    summon.advantage_behavior = AdvantageBehaviorNeutral.new()
