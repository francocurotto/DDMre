extends "res://engine/abilities/continuous_ability.gd"

# constants
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate():
    summon.target_behavior = TargetBehaviorFly.new()

func deactivate():
    summon.target_behavior = TargetBehaviorBase.new()
