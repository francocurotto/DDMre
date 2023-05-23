extends "continuous_ability.gd"

# constants
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.target_behavior = TargetBehaviorFly.new()

func disable():
    .disable()
    monster.target_behavior = TargetBehaviorBase.new()
