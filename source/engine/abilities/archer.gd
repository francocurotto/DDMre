extends "base_ability.gd"

# constants
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    summon.target_behavior = TargetBehaviorFly.new(summon.player)
