extends "continuous_ability.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const PassBehaviorFly = preload("res://engine/dungobj/behaviors/pass_behavior_fly.gd")
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.pass_behavior = PassBehaviorFly.new()
    monster.target_behavior = TargetBehaviorFly.new()
    monster.speed = 0.5

func disable():
    .disable()
    monster.pass_behavior = PassBehaviorBase.new()
    monster.target_behavior = TargetBehaviorBase.new()
    monster.speed = 1
