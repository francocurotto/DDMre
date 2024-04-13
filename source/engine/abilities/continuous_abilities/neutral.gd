extends "res://engine/abilities/continuous_ability.gd"

# preloads
const PowerBehaviorNeutral = preload("res://engine/dungobj/behaviors/power_behavior_neutral.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate():
    summon.power_behavior = PowerBehaviorNeutral.new(summon)

func deactivate():
    summon.target_behavior = PowerBehaviorBase.new(summon)
