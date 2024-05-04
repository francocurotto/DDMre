extends "continuous_ability.gd"
## FLY ability.
##
## Give monster flying abilities. That is, can pass through other non-flying
## monsters, cannot be attacked by other non-flying monsters, and moving speed
## is halved.

#region preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const PassBehaviorFly = preload("res://engine/dungobj/behaviors/pass_behavior_fly.gd")
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")
#endregion

#region public functions
## Activate ability. Change monster target behavior to target behavior fly,
## and pass behavior to pass behavior fly.
func activate():
    summon.pass_behavior = PassBehaviorFly.new()
    summon.target_behavior = TargetBehaviorFly.new()
    summon.speed = 0.5

## Deactivate ability. Switch monster target behavior to target behavior base,
## and pass behavior to pass behavior base.
func deactivate():
    summon.pass_behavior = PassBehaviorBase.new()
    summon.target_behavior = TargetBehaviorBase.new()
    summon.speed = 1
#endregion
