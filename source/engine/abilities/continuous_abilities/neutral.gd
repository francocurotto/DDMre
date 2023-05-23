extends "continuous_ability.gd"

# preloads
const PowerBehaviorNeutral = preload("res://engine/dungobj/behaviors/power_behavior_neutral.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.power_behavior = PowerBehaviorNeutral.new()

func disable():
    .disable()
    monster.target_behavior = PowerBehaviorBase.new()
