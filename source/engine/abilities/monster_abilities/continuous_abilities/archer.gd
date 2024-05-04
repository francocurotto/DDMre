extends "continuous_ability.gd"
## ARCHER ability.
##
## Change target behavior of monster to be able to target flying monsters.

#region preloads
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
#endregion

#region public functions
## Activate ability. Change monster target behavior to target behavior fly.
func activate():
    summon.target_behavior = TargetBehaviorFly.new()

## Deactivate ability. Switch monster target behavior to target behavior base.
func deactivate():
    summon.target_behavior = TargetBehaviorBase.new()
#endregion
