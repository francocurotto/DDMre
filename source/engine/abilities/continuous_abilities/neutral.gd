extends "res://engine/abilities/continuous_ability.gd"

# preloads
const PowerBehaviorNeutral = preload("res://engine/dungobj/behaviors/power_behavior_neutral.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    summon.power_behavior = PowerBehaviorNeutral.new()

func disable():
    .disable()
    summon.target_behavior = PowerBehaviorBase.new()
