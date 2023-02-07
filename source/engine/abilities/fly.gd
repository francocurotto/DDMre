extends "base_ability.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const PassBehaviorFly = preload("res://engine/dungobj/behaviors/pass_behavior_fly.gd")
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    summon.pass_behavior = PassBehaviorFly.new()
    summon.target_behavior = TargetBehaviorFly.new(summon.player)
    summon.speed = 0.5

func deactivate():
    summon.pass_behavior = PassBehaviorBase.new()
    summon.target_behavior = TargetBehaviorBase.new(summon.player)
    summon.speed = 1
